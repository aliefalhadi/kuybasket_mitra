import 'dart:developer';
import 'dart:io';
import 'package:flutterstarter/services/Service.dart';
import 'package:dio/dio.dart';

class LapanganService extends Service{
  Future postTambahLapangan(var data) async {
    try {

      print(data);

      var url = '/lapangans/tambah-lapangan';

      Response response = await post(url, data);

      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        throw ('data tidak ditemukan');
      }
    } on SocketException catch (_) {
      throw SocketException('no_internet');
    } catch (error) {
      if (error is DioError) {
        print(error.response.statusCode);
        print(error.response.data['results']??error.response.data['message']);
        throw (error.response.statusCode);
      }
    }
  }


  Future postTambahFasilitasLapangan(var data) async {
    try {

      print(data);

      var url = '/lapangans/tambah-fasilitas-lapangan';

      Response response = await post(url, data);

      if (response.statusCode == 200) {
        return true;
      } else {
        throw ('data tidak ditemukan');
      }
    } on SocketException catch (_) {
      throw SocketException('no_internet');
    } catch (error) {
      if (error is DioError) {
        print(error.response.statusCode);
        print(error.response.data['results']??error.response.data['message']);
        throw (error.response.statusCode);
      }
    }
  }

  Future postTambahFotoLapangan(var data) async {
    try {
      var url = '/lapangans/tambah-foto-lapangan';
      print(data);
      var response = await postImage(url, data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return response;
      } else {
        throw ('data tidak ditemukan');
      }
    } catch (error) {
      if(error is DioError){
        print(error.response.statusCode);
        throw(error.response.statusCode);
      }
    }
  }
}