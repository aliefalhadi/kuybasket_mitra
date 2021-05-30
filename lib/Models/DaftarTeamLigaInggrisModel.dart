// To parse this JSON data, do
//
//     final daftarTeamLigaInggrisModel = daftarTeamLigaInggrisModelFromJson(jsonString);

import 'dart:convert';

DaftarTeamLigaInggrisModel daftarTeamLigaInggrisModelFromJson(String str) => DaftarTeamLigaInggrisModel.fromJson(json.decode(str));

String daftarTeamLigaInggrisModelToJson(DaftarTeamLigaInggrisModel data) => json.encode(data.toJson());

class DaftarTeamLigaInggrisModel {
  DaftarTeamLigaInggrisModel({
    this.teams,
  });

  List<Map<String, String>> teams;

  factory DaftarTeamLigaInggrisModel.fromJson(Map<String, dynamic> json) => DaftarTeamLigaInggrisModel(
    teams: List<Map<String, String>>.from(json["teams"].map((x) => Map.from(x).map((k, v) => MapEntry<String, String>(k, v == null ? null : v)))),
  );

  Map<String, dynamic> toJson() => {
    "teams": List<dynamic>.from(teams.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v == null ? null : v)))),
  };
}
