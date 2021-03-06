import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutterstarter/Models/DaftarTeamLigaInggrisModel.dart';
import 'package:flutterstarter/Models/UserDataModel.dart';
import 'package:flutterstarter/services/AuthService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../locator.dart';
import '../shareds/ViewState.dart';
import 'BaseProvider.dart';

class LoginProvider extends BaseProvider {
  UserDataModel data;
  AuthService _authService = locator<AuthService>();
  String errMessage;
  var noHP;
  Map dataLogin = {
    'no_hp': '',
  };


  void noHoChaged(String noHp){
    this.dataLogin['no_hp'] = '+62';
    this.dataLogin['no_hp'] += noHp;
  }

  Future<String> login() async {
    try {
      Response response = await _authService.postLogin(jsonEncode(dataLogin));

      UserDataModel dataLoginModel = userDataModelFromJson(ascii
          .decode(base64.decode(base64.normalize(response.data['token'].toString().split(".")[1]))));

      Future.wait([saveSession(dataLoginModel, response.data['token'])]);

      if(dataLoginModel.data.isSudahAdaLapangan){
        return 'home';
      }else{
        return 'tambah-lapangan';
      }
    } on SocketException catch(e){
      errMessage = 'Tidak bisa terhubung ke server';
      setState(ViewState.Idle);
      return 'Gagal';
    }
    catch (e) {
      print(e.toString());
      errMessage = e;
      setState(ViewState.Idle);
      return 'Gagal';
    }
  }

  Future saveSession(UserDataModel data, token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("isLogin", true);
    sharedPreferences.setBool("is_lapangan_buka", data.data.statusLapangan == "" || data.data.statusLapangan == "tutup" ? false :true );
    sharedPreferences.setString("username", data.data.username);
    sharedPreferences.setString("email", data.data.email);
    sharedPreferences.setString("id_pengguna", data.data.idUser.toString());
    sharedPreferences.setString("id_pemilik_lapangan", data.data.dataPemilik.idPemilikLapangan.toString());
    sharedPreferences.setString("token", token);
    sharedPreferences.setString("data_user_login", jsonEncode(data));
    sharedPreferences.setInt("notif", data.data.totalNotifikasi);


   // await OneSignal.shared.sendTag("id_pengguna", data.data.idUser.toString());
   // await OneSignal.shared.sendTag("username", data.data.username);
  }

  Future ubahNoHP() async{
    try{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      String id = sharedPreferences.getString("id_pengguna");
      Map data = {
        'id': id,
        'no_hp': noHP,
      };

      bool res = await _authService.postUbahNoHP(data);
      setState(ViewState.Fetching);
      if (res) {
        print("berhasil ubah no HP");
        setState(ViewState.Idle);
        return true;
      } else {
        print("provider no hp error");
        setState(ViewState.Idle);
        return false;
      }

    } catch (e){
      print(e.toString());
    }
  }
  
  Future<String> logOut() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

}
