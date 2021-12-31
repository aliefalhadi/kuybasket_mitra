import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutterstarter/Models/UserDataModel.dart';
import 'package:flutterstarter/locator.dart';
import 'package:flutterstarter/provider/BaseProvider.dart';
import 'package:flutterstarter/services/LapanganService.dart';
import 'package:flutterstarter/shareds/ViewState.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DaftarProvider extends BaseProvider{
  LapanganService _lapanganService = locator<LapanganService>();

  Map dataDaftar = {
    "nik" : "",
    "nama": "",
    "no_hp" : "",
    "alamat" : "",
    "nama_lapangan" : "",
    "alamat_lapangan" : ""
  };


  void dataDaftarChanged({ String field, String value}){
      this.dataDaftar[field] = value;
  }



  Future<bool> postDaftarMitra(File foto2) async{
    try {

      FormData formData;
      File file = foto2;
      String fileName = file.path.split('/').last;
      print(fileName);
      // listFoto.add(MapEntry("foto[]",
      //     MultipartFile.fromFileSync(file.path, filename: fileName)));
      formData = new FormData.fromMap({
        "nik": dataDaftar['nik'],
        "nama": dataDaftar['nama'],
        "no_hp": dataDaftar['no_hp'],
        "alamat": dataDaftar['alamat'],
        "nama_lapangan": dataDaftar['nama_lapangan'],
        "alamat_lapangan": dataDaftar['alamat_lapangan'],
        "foto[]": MultipartFile.fromFileSync(file.path, filename: fileName)
      });

      await _lapanganService.postDaftarMitra(formData);

      print('asd');

      return true;
    } on SocketException catch(e){

      return false;
    }
    catch (e) {
      return false;
    }
  }
}