import 'package:flutter/material.dart';
import 'package:flutterstarter/views/pemesanan/daftar_pemesanan_berhasil.dart';
import 'package:flutterstarter/views/pemesanan/daftar_pemesanan_berlangsung.dart';
import 'package:flutterstarter/views/pemesanan/daftar_pemesanan_selesai.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("KUYBASKET MITRA"),
        actions: [
          IconButton(
              icon: Icon(Icons.notifications),
              onPressed: (){}
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
