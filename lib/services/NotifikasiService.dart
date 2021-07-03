import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutterstarter/Models/DaftarNotifikasiModel.dart';
import 'package:flutterstarter/Models/DaftarPemesananModel.dart';
import 'package:flutterstarter/Models/DaftarTeamLigaInggrisModel.dart';
import 'package:flutterstarter/Models/DetailPemesananModel.dart';
import 'package:flutterstarter/services/Service.dart';
import 'package:flutterstarter/views/notifikasi/daftar_notifikasi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotifikasiService extends Service{
  Future getDaftarNotifikasi() async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      String idUser = sharedPreferences.getString('id_pemilik_lapangan');

      var url = '/notifications/index/'+'12';

      var response = await get(url);

      if (response.statusCode == 200) {
        DaftarNotifikasiModel daftarNotifikasiModel =
        daftarNotifikasiModelFromJson(jsonEncode(response.data));

        print(daftarNotifikasiModel.data.isEmpty);
        if(daftarNotifikasiModel.data.isEmpty){
          print('asd');
          throw ('data tidak ditemukan');
        }

        return daftarNotifikasiModel;
      } else {
        throw ('data tidak ditemukan');
      }
    } on SocketException catch (_) {
      throw SocketException('no_internet');
    } catch (error) {
      if (error is DioError) {
        print(error.response.statusCode);
        throw (error.response.statusCode);
      }
    }
  }

  Future getTotalNotifUser() async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      String idUser = sharedPreferences.getString('id_pemilik_lapangan');

      var url = '/notifications/total-notif-user/'+'12';

      Response response = await get(url);

      if (response.statusCode == 200) {
        sharedPreferences.setInt('notif', int.parse(response.data['data']));
        log(response.data['data']);
        return response;
      } else {
        throw ('data tidak ditemukan');
      }
    } on SocketException catch (_) {
      throw SocketException('no_internet');
    } catch (error) {
      if (error is DioError) {
        print(error.response.statusCode);
        throw (error.response.statusCode);
      }
    }
  }

  Future getBacaNotif(String idNotif) async {
    try {
      var url = '/notifications/baca-notif/'+idNotif;

      Response response = await get(url);

      if (response.statusCode == 200) {
        return response;
      } else {
        throw ('data tidak ditemukan');
      }
    } on SocketException catch (_) {
      throw SocketException('no_internet');
    } catch (error) {
      if (error is DioError) {
        print(error.response.statusCode);
        throw (error.response.statusCode);
      }
    }
  }
}