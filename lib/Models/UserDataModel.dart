// To parse this JSON data, do
//
//     final userDataModel = userDataModelFromJson(jsonString);

import 'dart:convert';

UserDataModel userDataModelFromJson(String str) => UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  UserDataModel({
    this.iat,
    this.iss,
    this.data,
  });

  int iat;
  String iss;
  Data data;

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
    iat: json["iat"] == null ? null : json["iat"],
    iss: json["iss"] == null ? null : json["iss"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "iat": iat == null ? null : iat,
    "iss": iss == null ? null : iss,
    "data": data == null ? null : data.toJson(),
  };
}

class Data {
  Data({
    this.idUser,
    this.username,
    this.email,
    this.nama,
    this.noHp,
    this.dataPemilik,
    this.isSudahAdaLapangan,
    this.totalNotifikasi,
  });

  int idUser;
  String username;
  String email;
  String nama;
  String noHp;
  DataPemilik dataPemilik;
  bool isSudahAdaLapangan;
  int totalNotifikasi;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    idUser: json["id_user"] == null ? null : json["id_user"],
    username: json["username"] == null ? null : json["username"],
    email: json["email"] == null ? null : json["email"],
    nama: json["nama"] == null ? null : json["nama"],
    noHp: json["no_hp"] == null ? null : json["no_hp"],
    dataPemilik: json["data_pemilik"] == null ? null : DataPemilik.fromJson(json["data_pemilik"]),
    isSudahAdaLapangan: json["is_sudah_ada_lapangan"] == null ? null : json["is_sudah_ada_lapangan"],
    totalNotifikasi: json["total_notifikasi"] == null ? null : json["total_notifikasi"],
  );

  Map<String, dynamic> toJson() => {
    "id_user": idUser == null ? null : idUser,
    "username": username == null ? null : username,
    "email": email == null ? null : email,
    "nama": nama == null ? null : nama,
    "no_hp": noHp == null ? null : noHp,
    "data_pemilik": dataPemilik == null ? null : dataPemilik.toJson(),
    "is_sudah_ada_lapangan": isSudahAdaLapangan == null ? null : isSudahAdaLapangan,
    "total_notifikasi": totalNotifikasi == null ? null : totalNotifikasi,
  };
}

class DataPemilik {
  DataPemilik({
    this.idPemilikLapangan,
    this.nama,
    this.alamat,
  });

  int idPemilikLapangan;
  String nama;
  String alamat;

  factory DataPemilik.fromJson(Map<String, dynamic> json) => DataPemilik(
    idPemilikLapangan: json["id_pemilik_lapangan"] == null ? null : json["id_pemilik_lapangan"],
    nama: json["nama"] == null ? null : json["nama"],
    alamat: json["alamat"] == null ? null : json["alamat"],
  );

  Map<String, dynamic> toJson() => {
    "id_pemilik_lapangan": idPemilikLapangan == null ? null : idPemilikLapangan,
    "nama": nama == null ? null : nama,
    "alamat": alamat == null ? null : alamat,
  };
}
