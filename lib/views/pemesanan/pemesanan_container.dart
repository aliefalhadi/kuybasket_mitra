import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutterstarter/locator.dart';
import 'package:flutterstarter/services/EventBusService.dart';
import 'package:flutterstarter/views/pemesanan/daftar_pemesanan_berhasil.dart';
import 'package:flutterstarter/views/pemesanan/daftar_pemesanan_berlangsung.dart';
import 'package:flutterstarter/views/pemesanan/daftar_pemesanan_selesai.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PemesananContainer extends StatefulWidget {
  const PemesananContainer({Key key}) : super(key: key);

  @override
  _PemesananContainerState createState() => _PemesananContainerState();
}

class _PemesananContainerState extends State<PemesananContainer> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    getNotif();
  }

  Future getNotif() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
//      isUpdate = sharedPreferences.getBool('isUpdate');
      locator<EventBusService>().totalNotif = sharedPreferences.getInt('notif');


      if (locator<EventBusService>().totalNotif == 0) {
        // FlutterAppBadger.removeBadge();
      }

      log(locator<EventBusService>().totalNotif.toString(), name: 'notif');
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("KUYBASKET MITRA"),
        actions: [
          Badge(
            showBadge:  locator<EventBusService>().totalNotif == 0 ?false : true,
            badgeContent: Text( locator<EventBusService>().totalNotif.toString(), style: TextStyle(color: Colors.white, fontSize: 11),),
            position: BadgePosition(top: 2,end: 8),
            child: IconButton(
                icon: Icon(Icons.notifications),
                onPressed: (){
                  Navigator.pushNamed(context, 'notifikasi');
                }
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: "Berlangsung",),
              Tab(text: "Berhasil",),
              Tab(text: "Selesai",),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          DaftarPemesananBerlangsung(),
          DaftarPemesananBerhasil(),
          DaftarPemesananSelesai()
        ],
      ),
    );
  }
}
