import 'package:flutterstarter/provider/BaseProvider.dart';

class TambahLapanganProvider extends BaseProvider{
  Map dataInfoLapangan = {
    "nama_lapangan" : "",
    "alamat_lapangan": "",
    "jam_buka" : "",
    "jam_tutup" : "",
    "biaya_per_jam" : "",
    "kontak_admin" : "",
    "deskripsi" : ""
  };

  void dataInfoLapanganChanged({ String field, String value}){
      this.dataInfoLapangan[field] = value;
  }
}