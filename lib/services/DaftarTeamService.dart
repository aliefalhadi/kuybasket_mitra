import 'dart:convert';
import 'dart:developer';
import 'package:flutterstarter/Models/DaftarTeamLigaInggrisModel.dart';
import 'package:flutterstarter/services/Service.dart';

class DaftarTeamService extends Service{
  Future getDaftarTeamLigaInggris() async{
    String url = "https://www.thesportsdb.com/api/v1/json/1/search_all_teams.php?l=English%20Premier%20League";
    var response = await get(url);
    // log(response.toString(), name: 'response dari API');
    if(response.statusCode == 200){
      DaftarTeamLigaInggrisModel daftarTeamLigaInggrisModel = daftarTeamLigaInggrisModelFromJson(jsonEncode(response.data));
      log(daftarTeamLigaInggrisModel.toString(), name: 'model');
      return daftarTeamLigaInggrisModel;
    }
  }
}