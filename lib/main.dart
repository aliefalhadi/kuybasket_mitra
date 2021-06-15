import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutterstarter/core/route/RouterApp.dart';
import 'package:flutterstarter/locator.dart';
import 'package:flutterstarter/provider/MainProvider.dart';
import 'package:flutterstarter/views/Home.dart';
import 'package:flutterstarter/views/HomeContainer.dart';
import 'package:flutterstarter/views/Login.dart';
import 'package:flutterstarter/views/lapangan/tambah_lapangan/TambahInfoLapangan.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  MainProvider mainProvider = locator<MainProvider>();
  mainProvider.onStartApp().then((value){
    return runApp(App(initialRoute: value,));
  });
}

class App extends StatelessWidget {
  final String initialRoute;
  App({this.initialRoute});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "KUYBASKET MITRA",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: initialRoute == 'login' ? Login() : initialRoute == 'tambah-lapangan' ? TambahInfoLapangan() : HomeContainer(),
      onGenerateRoute: RouterApp.generateRoute,
      builder: EasyLoading.init(),
    );
  }
}

