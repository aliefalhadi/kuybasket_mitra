import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutterstarter/Models/DaftarPemesananModel.dart';
import 'package:flutterstarter/Models/DaftarTeamLigaInggrisModel.dart';
import 'package:flutterstarter/Models/DetailPemesananModel.dart';
import 'package:flutterstarter/services/Service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PemesananService extends Service{
  Future getDaftarPemesanan({String status}) async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      String idPemilik = sharedPreferences.getString('id_pemilik_lapangan');

      var url = '/pemesanans/daftar-pemesanan-by-pemilik/'+idPemilik+'?status='+status;

      var response = await get(url);

      if (response.statusCode == 200) {
        DaftarPemesananModel daftarPemesananModel =
        daftarPemesananModelFromJson(jsonEncode(response.data));
        return daftarPemesananModel;
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

  Future getDetailPemesanan({String idPemesanan}) async {
    try {
      var url = '/pemesanans/detail-pemesanan-by-pemilik/'+idPemesanan;

      var response = await get(url);

      if (response.statusCode == 200) {
        DetailPemesananModel detailPemesananModel =
        detailPemesananModelFromJson(jsonEncode(response.data));
        return detailPemesananModel;
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

  Future postKonfirmasiPemesanan(var data) async {
    try {
      var url = '/pemesanans/konfirmasi-pemesanan';

      var response = await post(url, data);

      if (response.statusCode == 200) {
        return true;
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