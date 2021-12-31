import 'package:flutter/material.dart';
import 'package:flutterstarter/views/pemesanan/pemesanan_container.dart';
import 'package:flutterstarter/views/profile.dart';
import 'package:flutterstarter/views/scan.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({Key key}) : super(key: key);

  @override
  _HomeContainerState createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _currentIndex = index;
            _tabController.index = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
            label: "Pemesanan"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_scanner),
              label: "Scan"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile"
          )
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          PemesananContainer(),
          ScanView(),
          Profile()
        ],
      )
    );
  }
}
