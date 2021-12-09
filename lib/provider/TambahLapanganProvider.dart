import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutterstarter/Models/UserDataModel.dart';
import 'package:flutterstarter/locator.dart';
import 'package:flutterstarter/provider/BaseProvider.dart';
import 'package:flutterstarter/services/LapanganService.dart';
import 'package:flutterstarter/shareds/ViewState.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TambahLapanganProvider extends BaseProvider{
  LapanganService _lapanganService = locator<LapanganService>();

  Map dataInfoLapangan = {
    "nama_lapangan" : "",
    "alamat_lapangan": "",
    "jam_buka" : "",
    "jam_tutup" : "",
    "biaya_per_jam" : "",
    "kontak_admin" : "",
    "deskripsi" : "",
    "pemilik_id": ""
  };

  List dataFasilitasLapangan = [];

  void dataInfoLapanganChanged({ String field, String value}){
      this.dataInfoLapangan[field] = value;
  }

  void addFasilitaslapangan(String fasilitas){
    dataFasilitasLapangan.add(fasilitas);
  }

  void removeFasilitaslapangan(String fasilitas){
    dataFasilitasLapangan.remove(fasilitas);
  }

  Future<bool> postTambahLapangan(List<File> foto2) async{
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      dataInfoLapangan['pemilik_id'] = sharedPreferences.getString('id_pemilik_lapangan');
      // dataInfoLapangan['pemilik_id'] = '6';


      var res = await _lapanganService.postTambahLapangan(jsonEncode(dataInfoLapangan));

      Map dataFasilitas = {
        'id_lapangan': res,
        'fasilitas': dataFasilitasLapangan,
      };

      var resFasilitas = await _lapanganService.postTambahFasilitasLapangan(jsonEncode(dataFasilitas));


      FormData formData;
      await Future.wait(foto2.map((foto) async {
        File file = foto;
        String fileName = file.path.split('/').last;
        print(fileName);
        // listFoto.add(MapEntry("foto[]",
        //     MultipartFile.fromFileSync(file.path, filename: fileName)));
        formData = new FormData.fromMap({
          "id_lapangan": res,
          "foto[]": MultipartFile.fromFileSync(file.path, filename: fileName)
        });

        var resFoto = await _lapanganService.postTambahFotoLapangan(formData);
      }));


      print(formData.files);

      var dataStorage = await sharedPreferences.get('data_user_login');

      UserDataModel userDataModel = userDataModelFromJson(dataStorage);
      userDataModel.data.isSudahAdaLapangan = true;
      sharedPreferences.setBool('is_lapangan_buka', false);
      sharedPreferences.setString("data_user_login", jsonEncode(userDataModel));

      return true;
    } on SocketException catch(e){

      return false;
    }
    catch (e) {
      return false;
    }
  }
}