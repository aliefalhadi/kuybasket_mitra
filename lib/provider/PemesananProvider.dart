import 'dart:convert';
import 'dart:io';

import 'package:flutterstarter/Models/DaftarPemesananModel.dart';
import 'package:flutterstarter/Models/DetailPemesananModel.dart';
import 'package:flutterstarter/services/PemesananService.dart';
import '../locator.dart';
import '../shareds/ViewState.dart';
import 'BaseProvider.dart';

class PemesananProvider extends BaseProvider {
  DaftarPemesananModel daftarPemesananModel;
  DetailPemesananModel detailPemesananModel;
  PemesananService _pemesananService = locator<PemesananService>();
  String jamMain= '';

  Future getDaftarPemesanan({String status}) async {
    try {
      setState(ViewState.Fetching);
      daftarPemesananModel =
          await _pemesananService.getDaftarPemesanan(status: status);

      if (daftarPemesananModel.data.isEmpty ||
          daftarPemesananModel.data == []) {
        setState(ViewState.FetchNull);
      } else {
        setState(ViewState.Idle);
      }
    } on SocketException catch (e) {
      setState(ViewState.ErrConnection);
    } catch (e) {
      if (e == 404 || e == 502 || e == 503) {
        setState(ViewState.ErrConnection);
      } else {
        setState(ViewState.FetchNull);
      }
    }
  }

  Future getDetailPemesanan({String idPemesanan}) async {
    try {
      setState(ViewState.Fetching);
      detailPemesananModel =
          await _pemesananService.getDetailPemesanan(idPemesanan: idPemesanan);

      detailPemesananModel.data.detailPemesanan.forEach((element) {
        jamMain += element.jam.substring(0,5)+', ';
      });
      print(jamMain);

      setState(ViewState.Idle);
    } on SocketException catch (e) {
      setState(ViewState.ErrConnection);
    } catch (e) {
      if (e == 404 || e == 502 || e == 503) {
        setState(ViewState.ErrConnection);
      } else {
        setState(ViewState.FetchNull);
      }
    }
  }

  Future postKonfirmasiPemesanan({String idPemesanan, String status}) async {
    try {
      Map data = {
        'id_pemesanan' : idPemesanan,
        'status' : status
      };
      print(jsonEncode(data));
      await _pemesananService.postKonfirmasiPemesanan(jsonEncode(data));

      return true;

    } on SocketException catch (e) {
      return false;
    } catch (e) {
      if (e == 404 || e == 502 || e == 503) {
        return false;
      } else {
        return false;
      }
    }
  }
}
