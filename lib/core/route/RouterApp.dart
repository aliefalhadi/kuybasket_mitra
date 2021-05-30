import 'package:flutter/material.dart';
import 'package:flutterstarter/core/route/StringsRouterApp.dart';
import 'package:flutterstarter/views/Home.dart';
import 'package:flutterstarter/views/Login.dart';
import 'package:flutterstarter/views/lapangan/tambah_lapangan/TambahFasilitasLapangan.dart';
import 'package:flutterstarter/views/lapangan/tambah_lapangan/TambahInfoLapangan.dart';

class RouterApp {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case 'login':
        return MaterialPageRoute(builder: (_)=> Login());
        break;
      case 'home':
        return MaterialPageRoute(builder: (_)=> MyHomePage(title: 'asd',));
        break;
      case StringsRouterApp.tambahInfoLapangan :
        return MaterialPageRoute(builder: (_)=> TambahInfoLapangan());
        break;
      case StringsRouterApp.tambahFasilitasLapangan :
        return MaterialPageRoute(builder: (_)=> TambahFasilitasLapangan());
        break;
      default:
        return null;
        break;
    }
  }
}
