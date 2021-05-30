import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutterstarter/services/Service.dart';

class AuthService extends Service{
  Future<Response> postLogin(data) async {
    try {
      var url = '/auths/login-pemilik';
      print(data);
      Response response = await postLogin2(url, data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return response;
      }
      return null;
    }on TimeoutException catch(e) {
      throw SocketException('error connection');
    } catch (error) {
      DioError err = error;
      print(err.response);
      throw ('username / password anda salah');
    }
  }
}