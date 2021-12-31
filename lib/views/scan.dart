import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutterstarter/Models/DetailPemesananModel.dart';
import 'package:flutterstarter/locator.dart';
import 'package:flutterstarter/provider/PemesananProvider.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ScanView extends StatefulWidget {
  const ScanView({Key key}) : super(key: key);

  @override
  _ScanViewState createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text("Scan Pemesanan"),
      ),
    body: Column(
      children: <Widget>[
        Expanded(flex: 4, child: _buildQrView(context)),
      ],
    ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async{
      String result = scanData.code; //'29 MPP'
      print(result);
      if(result.split(' ').length == 2){
        controller.stopCamera();
        EasyLoading.show(status: "Loading...", dismissOnTap: false,maskType: EasyLoadingMaskType.black);
        DetailPemesananModel detailPemesananModel = await locator<PemesananProvider>().getDetailPemesananScan(idPemesanan: result.split(' ')[0].toString());
        String jamMain= '';
        detailPemesananModel.data.detailPemesanan.forEach((element) {
          jamMain += element.jam.substring(0,5)+', ';
        });
        EasyLoading.dismiss();
        if(detailPemesananModel != null){
          Alert(
            context: _globalKey.currentContext,
            type: AlertType.none,
            title: "",
            content: Column(
              children: [
                vSpace(16),
                Text("Detail Pemesanan", style: TextStyle(fontWeight: FontWeight.normal),),
                vSpace(8),
                Text("No Pemesanan "+detailPemesananModel.data.dataPemesanan.idPemesananLapangan.toString(), style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                vSpace(8),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text("Nama Pemesan", style: TextStyle(fontSize: 14, color: Colors.grey),),
                  subtitle: Text(detailPemesananModel.data.dataUserPemesan.name, style: TextStyle(fontSize: 16,color: Colors.black)),
                ),

                vSpace(8),

                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text("Tanggal Main", style: TextStyle(fontSize: 14, color: Colors.grey),),
                  subtitle: Text(DateFormat('dd MMM yyyy').format(detailPemesananModel
                      .data
                      .dataPemesanan
                      .tanggalPemesanan), style: TextStyle(fontSize: 16,color: Colors.black)),
                ),
                vSpace(8),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text("Jam Main", style: TextStyle(fontSize: 14, color: Colors.grey),),
                  subtitle: Text(jamMain, style: TextStyle(fontSize: 16,color: Colors.black)),
                ),
                vSpace(8),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text("Status Pemesanan", style: TextStyle(fontSize: 14, color: Colors.grey),),
                  subtitle: Text(detailPemesananModel.data.dataPemesanan.status, style: TextStyle(fontSize: 16,color: Colors.black)),
                ),
                vSpace(8),
              ],
            ),
            buttons: [
              DialogButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: (){
                  Navigator.pop(_globalKey.currentContext);
                  controller.resumeCamera();
                },
                width: 120,
              )
            ],
          ).show();
        }else{
          EasyLoading.showToast('data tidak ditemukan');
          controller.resumeCamera();
        }
      }
    });
  }

  vSpace(int i) {
    return SizedBox(height: i.toDouble(),);
  }
}
