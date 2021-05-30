import 'package:flutterstarter/Models/DaftarTeamLigaInggrisModel.dart';
import 'package:flutterstarter/services/DaftarTeamService.dart';
import '../locator.dart';
import '../shareds/ViewState.dart';
import 'BaseProvider.dart';

class DaftarTeamLigaInggrisProvider extends BaseProvider{
    DaftarTeamLigaInggrisModel daftarTeamLigaInggrisModel;
    DaftarTeamService daftarTeamService = locator<DaftarTeamService>();

    void getDaftarTeamLigaInggris() async{
      setState(ViewState.Fetching);
      daftarTeamLigaInggrisModel = await daftarTeamService.getDaftarTeamLigaInggris();
      setState(ViewState.Idle);
    }
}