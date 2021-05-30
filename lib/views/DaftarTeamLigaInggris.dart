import 'package:flutter/material.dart';
import 'package:flutterstarter/provider/DaftarTeamLigaInggrisProvider.dart';
import '../shareds/ViewState.dart';
import 'BaseView.dart';

class DaftarTeamLigaInggris extends StatefulWidget {
  @override
  _DaftarTeamLigaInggrisState createState() => _DaftarTeamLigaInggrisState();
}

class _DaftarTeamLigaInggrisState extends State<DaftarTeamLigaInggris> {
  @override
  Widget build(BuildContext context) {
    return BaseView<DaftarTeamLigaInggrisProvider>(
      onModelReady: (model) => model.getDaftarTeamLigaInggris(),
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Daftar Team"),
          ),
          body: Container(
              padding: EdgeInsets.all(8),
              child: provider.state == ViewState.Fetching
                  ? Center(
                      child: Text("loading..."),
                    )
                  : ListView.builder(
                  itemCount: provider.daftarTeamLigaInggrisModel.teams.length,
                  itemBuilder: (contex, index){
                    return Card(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Text(provider.daftarTeamLigaInggrisModel.teams[index]['strTeam'].toString()),
                      ),
                    );
                  }
              )
          ),
        );
      },
    );
  }
}
