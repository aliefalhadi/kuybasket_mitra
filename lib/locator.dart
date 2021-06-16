import 'package:flutterstarter/provider/DaftarTeamLigaInggrisProvider.dart';
import 'package:flutterstarter/provider/HomeProvider.dart';
import 'package:flutterstarter/provider/LoginProvider.dart';
import 'package:flutterstarter/provider/MainProvider.dart';
import 'package:flutterstarter/provider/NotifikasiProvider.dart';
import 'package:flutterstarter/provider/PemesananProvider.dart';
import 'package:flutterstarter/provider/TambahLapanganProvider.dart';
import 'package:flutterstarter/services/ApiInterceptors.dart';
import 'package:flutterstarter/services/AuthService.dart';
import 'package:flutterstarter/services/DaftarTeamService.dart';
import 'package:flutterstarter/services/EventBusService.dart';
import 'package:flutterstarter/services/LapanganService.dart';
import 'package:flutterstarter/services/NotifikasiService.dart';
import 'package:flutterstarter/services/PemesananService.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //  init injected file
  //services
  locator.registerLazySingleton(() => ApiInterceptors());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => DaftarTeamService());
  locator.registerLazySingleton(() => LapanganService());
  locator.registerLazySingleton(() => PemesananService());
  locator.registerLazySingleton(() => NotifikasiService());
  locator.registerLazySingleton(() => EventBusService());



  // provider
  locator.registerFactory(() => LoginProvider());
  locator.registerFactory(() => PemesananProvider());
  locator.registerFactory(() => HomeProvider());
  locator.registerFactory(() => MainProvider());
  locator.registerFactory(() => TambahLapanganProvider());
  locator.registerFactory(() => NotifikasiProvider());
  locator.registerFactory(() => DaftarTeamLigaInggrisProvider());
}