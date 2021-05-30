import 'package:flutterstarter/provider/DaftarTeamLigaInggrisProvider.dart';
import 'package:flutterstarter/provider/HomeProvider.dart';
import 'package:flutterstarter/provider/LoginProvider.dart';
import 'package:flutterstarter/provider/MainProvider.dart';
import 'package:flutterstarter/provider/TambahLapanganProvider.dart';
import 'package:flutterstarter/services/ApiInterceptors.dart';
import 'package:flutterstarter/services/AuthService.dart';
import 'package:flutterstarter/services/DaftarTeamService.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //  init injected file
  //services
  locator.registerLazySingleton(() => ApiInterceptors());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => DaftarTeamService());



  // provider
  locator.registerFactory(() => LoginProvider());
  locator.registerFactory(() => HomeProvider());
  locator.registerFactory(() => MainProvider());
  locator.registerFactory(() => TambahLapanganProvider());
  locator.registerFactory(() => DaftarTeamLigaInggrisProvider());
}