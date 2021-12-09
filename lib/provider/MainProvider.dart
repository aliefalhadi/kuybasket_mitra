import 'package:flutterstarter/Models/UserDataModel.dart';
import 'package:flutterstarter/locator.dart';
import 'package:flutterstarter/services/NotifikasiService.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainProvider {
  Future<String> onStartApp() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    OneSignal.shared.init(
        "79341e3c-37d7-432e-ac0d-afdc041f5595",
        iOSSettings: null
    );
    OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
    //
    // await this.checkLatestVersion();
    print('asd');
    if (sharedPreferences.containsKey('isLogin')) {
      print('asd');
      bool isLogin = sharedPreferences.getBool('isLogin');
      if (isLogin) {

        var dataStorage = await sharedPreferences.get('data_user_login');

       UserDataModel userDataModel = userDataModelFromJson(dataStorage);

       if(userDataModel.data.isSudahAdaLapangan){
         await locator<NotifikasiService>().getTotalNotifUser();
         return 'home';
       }else{
        return 'tambah-lapangan';
       }
      } else {
        return 'login';
      }
    } else {
      return 'login';
    }
  }
}