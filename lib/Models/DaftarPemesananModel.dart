// To parse this JSON data, do
//
//     final daftarPemesananModel = daftarPemesananModelFromJson(jsonString);

import 'dart:convert';

DaftarPemesananModel daftarPemesananModelFromJson(String str) => DaftarPemesananModel.fromJson(json.decode(str));

String daftarPemesananModelToJson(DaftarPemesananModel data) => json.encode(data.toJson());

class DaftarPemesananModel {
  DaftarPemesananModel({
    this.status,
    this.data,
  });

  String status;
  List<Datum> data;

  factory DaftarPemesananModel.fromJson(Map<String, dynamic> json) => DaftarPemesananModel(
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
    this.data,
    this.dataPemesan,
  });

  Data data;
  DataPemesan dataPemesan;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    dataPemesan: json["data_pemesan"] == null ? null : DataPemesan.fromJson(json["data_pemesan"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data.toJson(),
    "data_pemesan": dataPemesan == null ? null : dataPemesan.toJson(),
  };
}

class Data {
  Data({
    this.idPemesananLapangan,
    this.lapanganId,
    this.userIdPemesan,
    this.tanggalPemesanan,
    this.biayaPerJam,
    this.totalBaya,
    this.status,
    this.createdAt,
    this.expiredPembayaranAt,
  });

  int idPemesananLapangan;
  int lapanganId;
  int userIdPemesan;
  DateTime tanggalPemesanan;
  int biayaPerJam;
  int totalBaya;
  String status;
  DateTime createdAt;
  DateTime expiredPembayaranAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    idPemesananLapangan: json["id_pemesanan_lapangan"] == null ? null : json["id_pemesanan_lapangan"],
    lapanganId: json["lapangan_id"] == null ? null : json["lapangan_id"],
    userIdPemesan: json["user_id_pemesan"] == null ? null : json["user_id_pemesan"],
    tanggalPemesanan: json["tanggal_pemesanan"] == null ? null : DateTime.parse(json["tanggal_pemesanan"]),
    biayaPerJam: json["biaya_per_jam"] == null ? null : json["biaya_per_jam"],
    totalBaya: json["total_baya"] == null ? null : json["total_baya"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    expiredPembayaranAt: json["expired_pembayaran_at"] == null ? null : DateTime.parse(json["expired_pembayaran_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id_pemesanan_lapangan": idPemesananLapangan == null ? null : idPemesananLapangan,
    "lapangan_id": lapanganId == null ? null : lapanganId,
    "user_id_pemesan": userIdPemesan == null ? null : userIdPemesan,
    "tanggal_pemesanan": tanggalPemesanan == null ? null : "${tanggalPemesanan.year.toString().padLeft(4, '0')}-${tanggalPemesanan.month.toString().padLeft(2, '0')}-${tanggalPemesanan.day.toString().padLeft(2, '0')}",
    "biaya_per_jam": biayaPerJam == null ? null : biayaPerJam,
    "total_baya": totalBaya == null ? null : totalBaya,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "expired_pembayaran_at": expiredPembayaranAt == null ? null : expiredPembayaranAt.toIso8601String(),
  };
}

class DataPemesan {
  DataPemesan({
    this.id,
    this.username,
    this.name,
    this.noHp,
    this.authKey,
    this.passwordHash,
    this.passwordResetToken,
    this.email,
    this.userDetailId,
    this.role,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String username;
  String name;
  String noHp;
  String authKey;
  String passwordHash;
  dynamic passwordResetToken;
  String email;
  dynamic userDetailId;
  String role;
  int status;
  int createdAt;
  int updatedAt;

  factory DataPemesan.fromJson(Map<String, dynamic> json) => DataPemesan(
    id: json["id"] == null ? null : json["id"],
    username: json["username"] == null ? null : json["username"],
    name: json["name"] == null ? null : json["name"],
    noHp: json["no_hp"] == null ? null : json["no_hp"],
    authKey: json["auth_key"] == null ? null : json["auth_key"],
    passwordHash: json["password_hash"] == null ? null : json["password_hash"],
    passwordResetToken: json["password_reset_token"],
    email: json["email"] == null ? null : json["email"],
    userDetailId: json["user_detail_id"],
    role: json["role"] == null ? null : json["role"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "username": username == null ? null : username,
    "name": name == null ? null : name,
    "no_hp": noHp == null ? null : noHp,
    "auth_key": authKey == null ? null : authKey,
    "password_hash": passwordHash == null ? null : passwordHash,
    "password_reset_token": passwordResetToken,
    "email": email == null ? null : email,
    "user_detail_id": userDetailId,
    "role": role == null ? null : role,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
  };
}
