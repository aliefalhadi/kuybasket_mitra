import 'dart:convert';
import 'dart:io';

import 'package:flutterstarter/Models/DaftarNotifikasiModel.dart';
import 'package:flutterstarter/Models/DaftarPemesananModel.dart';
import 'package:flutterstarter/Models/DetailPemesananModel.dart';
import 'package:flutterstarter/services/LapanganService.dart';
import 'package:flutterstarter/services/NotifikasiService.dart';
import 'package:flutterstarter/services/PemesananService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../locator.dart';
import '../shareds/ViewState.dart';
import 'BaseProvider.dart';

class ProfileProvider extends BaseProvider {
  bool isSwitched = true;

  LapanganService lapanganService = locator<LapanganService>();

  void init() async{
    setState(ViewState.Fetching);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    isSwitched = sharedPreferences.getBool('is_lapangan_buka');
    setState(ViewState.Idle);
  }

  Future postUpdateStatusLapangan() async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      if(isSwitched){
        Map data = {
          'status' : 'tutup'
        };
        String id = sharedPreferences.getString('id_pemilik_lapangan');
        bool res = await lapanganService.postUbahStatusLapangan(id, jsonEncode(data));
        if(res){
          sharedPreferences.setBool('is_lapangan_buka', false);
          isSwitched = false;
          notifyListeners();
          return true;
        }else{
          return false;
        }
      }else{
        Map data = {
          'status' : 'buka'
        };
        String id = sharedPreferences.getString('id_pemilik_lapangan');
        bool res = await lapanganService.postUbahStatusLapangan(id, jsonEncode(data));
        if(res){
          sharedPreferences.setBool('is_lapangan_buka', true);
          isSwitched = true;
          notifyListeners();
          return true;
        }else{
          return false;
        }
      }


    } on SocketException catch (e) {
      setState(ViewState.ErrConnection);
    } catch (e) {
      if (e == 404 || e == 502 || e == 503) {
        setState(ViewState.ErrConnection);
      } else {
        setState(ViewState.FetchNull);
      }
    }
  }
}
