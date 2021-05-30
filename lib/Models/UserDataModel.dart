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
    this.id,
    this.name,
    this.noHp,
    this.username,
    this.email,
    this.userDetailId,
    this.role,
    this.dataPemilik,
    this.isSudahAdaLapangan,
  });

  int id;
  String name;
  String noHp;
  String username;
  String email;
  String userDetailId;
  String role;
  DataPemilik dataPemilik;
  bool isSudahAdaLapangan;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    noHp: json["no_hp"] == null ? null : json["no_hp"],
    username: json["username"] == null ? null : json["username"],
    email: json["email"] == null ? null : json["email"],
    userDetailId: json["user_detail_id"] == null ? null : json["user_detail_id"],
    role: json["role"] == null ? null : json["role"],
    dataPemilik: json["data_pemilik"] == null ? null : DataPemilik.fromJson(json["data_pemilik"]),
    isSudahAdaLapangan: json["is_sudah_ada_lapangan"] == null ? null : json["is_sudah_ada_lapangan"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "no_hp": noHp == null ? null : noHp,
    "username": username == null ? null : username,
    "email": email == null ? null : email,
    "user_detail_id": userDetailId == null ? null : userDetailId,
    "role": role == null ? null : role,
    "data_pemilik": dataPemilik == null ? null : dataPemilik.toJson(),
    "is_sudah_ada_lapangan": isSudahAdaLapangan == null ? null : isSudahAdaLapangan,
  };
}

class DataPemilik {
  DataPemilik({
    this.idPemilikLapangan,
    this.nik,
    this.nama,
    this.noHp,
    this.alamat,
  });

  int idPemilikLapangan;
  String nik;
  String nama;
  String noHp;
  String alamat;

  factory DataPemilik.fromJson(Map<String, dynamic> json) => DataPemilik(
    idPemilikLapangan: json["id_pemilik_lapangan"] == null ? null : json["id_pemilik_lapangan"],
    nik: json["nik"] == null ? null : json["nik"],
    nama: json["nama"] == null ? null : json["nama"],
    noHp: json["no_hp"] == null ? null : json["no_hp"],
    alamat: json["alamat"] == null ? null : json["alamat"],
  );

  Map<String, dynamic> toJson() => {
    "id_pemilik_lapangan": idPemilikLapangan == null ? null : idPemilikLapangan,
    "nik": nik == null ? null : nik,
    "nama": nama == null ? null : nama,
    "no_hp": noHp == null ? null : noHp,
    "alamat": alamat == null ? null : alamat,
  };
}
