import 'dart:convert';
import 'dart:io';

import 'package:flutterstarter/Models/DaftarNotifikasiModel.dart';
import 'package:flutterstarter/Models/DaftarPemesananModel.dart';
import 'package:flutterstarter/Models/DetailPemesananModel.dart';
import 'package:flutterstarter/services/NotifikasiService.dart';
import 'package:flutterstarter/services/PemesananService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../locator.dart';
import '../shareds/ViewState.dart';
import 'BaseProvider.dart';

class NotifikasiProvider extends BaseProvider {
  DaftarNotifikasiModel daftarNotifikasiModel;
  NotifikasiService _notifikasiService = locator<NotifikasiService>();

  Future getDaftarNotifikasi() async {
    try {
      setState(ViewState.Fetching);
      daftarNotifikasiModel =
          await _notifikasiService.getDaftarNotifikasi();

      if(daftarNotifikasiModel.data.isEmpty){
        setState(ViewState.FetchNull);
      }else{
        setState(ViewState.Idle);
      }


    } on SocketException catch (e) {
      setState(ViewState.ErrConnection);
    } catch (e) {
      print('erer');
      if (e == 404 || e == 502 || e == 503) {
        setState(ViewState.ErrConnection);
      } else {
        print('erer');
        setState(ViewState.FetchNull);
      }
    }
  }

  Future bacaNotif(String idNotif) async{
    try {
      await _notifikasiService.getBacaNotif(idNotif);
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      int total = sharedPreferences.getInt('notif');


        if(total >= 1){
          await  sharedPreferences.setInt('notif', total-1);
        }else{
          await  sharedPreferences.setInt('notif', 0);
        }

      print(total);
    }  on SocketException catch(e){
      setState(ViewState.ErrConnection);
    }
    catch (e) {
      if(e == 404 || e == 502 || e == 503){
        setState(ViewState.ErrConnection);
      }else{
        setState(ViewState.FetchNull);
      }
    }
  }
}
