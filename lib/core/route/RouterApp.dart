import 'package:flutter/material.dart';
import 'package:flutterstarter/core/route/StringsRouterApp.dart';
import 'package:flutterstarter/provider/TambahLapanganProvider.dart';
import 'package:flutterstarter/views/Home.dart';
import 'package:flutterstarter/views/HomeContainer.dart';
import 'package:flutterstarter/views/Login.dart';
import 'package:flutterstarter/views/lapangan/tambah_lapangan/TambahFasilitasLapangan.dart';
import 'package:flutterstarter/views/lapangan/tambah_lapangan/TambahFotoLapangan.dart';
import 'package:flutterstarter/views/lapangan/tambah_lapangan/TambahInfoLapangan.dart';
import 'package:flutterstarter/views/pemesanan/detail_pemesanan.dart';

class RouterApp {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case 'login':
        return MaterialPageRoute(builder: (_)=> Login());
        break;
      case 'home':
        return MaterialPageRoute(builder: (_)=> HomeContainer());
        break;
      case 'pemesanan/detail':
        final String idPemesanan = routeSettings.arguments;
        return MaterialPageRoute(builder: (_)=> DetailPemesanan(idPemesanan: idPemesanan,));
        break;
      case StringsRouterApp.tambahInfoLapangan :
        return MaterialPageRoute(builder: (_)=> TambahInfoLapangan());
        break;
      case StringsRouterApp.tambahFasilitasLapangan :
        TambahLapanganProvider tambahLapanganProvider = routeSettings.arguments;
        return MaterialPageRoute(builder: (_)=> TambahFasilitasLapangan(provider: tambahLapanganProvider,));
        break;
      case StringsRouterApp.tambahFotoLapangan :
        TambahLapanganProvider tambahLapanganProvider = routeSettings.arguments;
        return MaterialPageRoute(builder: (_)=> TambahFotoLapangan(provider: tambahLapanganProvider,));
        break;
      default:
        return null;
        break;
    }
  }
}
