import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutterstarter/locator.dart';
import 'package:flutterstarter/services/ApiInterceptors.dart';
import 'package:flutterstarter/utils/ErrorDioHandler.dart';

class Service {
  Dio dio = locator<ApiInterceptors>().dio;
  // String baseUrl = 'http://172.20.10.3/kuybasket_backend/api/v1';
  String baseUrl = 'http://api.kuybasket.golkarriau.com/v1';


  Future get(String url) async {
    try {
      url = baseUrl + url;
      print(url);
      print('aleif');
      if (await locator<ApiInterceptors>().checkConnection()) {
        final response =
        dio.get(url, options: Options(headers: {"requiresToken": true}));
        return response;
      } else {
        print('no');
        throw TimeoutException('no_internet');
      }
    } on TimeoutException catch (e) {
      throw SocketException('no_internet');
    } catch (error) {
      log(error.toString(), name: 'error');
      errorDioHandler(error);
    }
  }

  Future postLogin2(String url, var data) async {
    url = baseUrl + url;
    print(url);
    if (await locator<ApiInterceptors>().checkConnection()) {
      print(data);
      final Response response = await dio.post(url,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }),
          data: data);
      return response;
    } else {
      print('no');
      throw SocketException('no_internet');
    }
  }


  Future post(String url, var data) async {
    try{
      url = baseUrl + url;
      print(url);
      if (await locator<ApiInterceptors>().checkConnection()) {
        final response = await dio.post(url,
            options: Options(headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              "requiresToken": true
            }),
            data: data);
        return response;
      } else {
        print('no');
        throw SocketException('no_internet');
      }
    } on TimeoutException catch (e) {
      throw SocketException('no_internet');
    } catch (error) {
      errorDioHandler(error);
    }
  }

  Future postImage(String url, var data) async {
    url = baseUrl + url;
    print(url);
    print(data);

    if (await locator<ApiInterceptors>().checkConnection()) {
      final response = await dio.post(url,
          options:
          Options(sendTimeout: 20000, headers: {'requiresToken': true, 'content-type': null}),
          data: data);
      print(response);
      return response;
    } else {
      print('no');
      throw SocketException('no_internet');
    }
  }


  Future patch(String url, var data) async {
    if (await locator<ApiInterceptors>().checkConnection()) {
      final response = await dio.patch(url,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }),
          data: data);
      return response;
    } else {
      print('no');
      throw SocketException('no_internet');
    }
  }

}