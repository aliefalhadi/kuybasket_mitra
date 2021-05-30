import 'package:flutterstarter/Models/UserDataModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '';

class MainProvider {
  Future<String> onStartApp() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // OneSignal.shared.init(
    //     "14c55d81-1c95-4205-b483-3446a5e15e47",
    //     iOSSettings: null
    // );
    // OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
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