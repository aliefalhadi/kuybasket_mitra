// To parse this JSON data, do
//
//     final daftarNotifikasiModel = daftarNotifikasiModelFromJson(jsonString);

import 'dart:convert';

DaftarNotifikasiModel daftarNotifikasiModelFromJson(String str) => DaftarNotifikasiModel.fromJson(json.decode(str));

String daftarNotifikasiModelToJson(DaftarNotifikasiModel data) => json.encode(data.toJson());

class DaftarNotifikasiModel {
  DaftarNotifikasiModel({
    this.status,
    this.data,
  });

  String status;
  List<Datum> data;

  factory DaftarNotifikasiModel.fromJson(Map<String, dynamic> json) => DaftarNotifikasiModel(
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.userId,
    this.type,
    this.notifikasi,
    this.keterangan,
    this.status,
    this.createdAt,
  });

  int id;
  int userId;
  String type;
  String notifikasi;
  String keterangan;
  int status;
  DateTime createdAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    type: json["type"] == null ? null : json["type"],
    notifikasi: json["notifikasi"] == null ? null : json["notifikasi"],
    keterangan: json["keterangan"] == null ? null : json["keterangan"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "type": type == null ? null : type,
    "notifikasi": notifikasi == null ? null : notifikasi,
    "keterangan": keterangan == null ? null : keterangan,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
  };
}
