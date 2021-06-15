import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutterstarter/core/constants/strings.dart';
import 'package:flutterstarter/provider/PemesananProvider.dart';
import 'package:flutterstarter/shareds/ViewState.dart';
import 'package:flutterstarter/views/BaseView.dart';
import 'package:intl/intl.dart';

class DetailPemesanan extends StatefulWidget {
  final String idPemesanan;
  const DetailPemesanan({this.idPemesanan});

  @override
  _DetailPemesananState createState() => _DetailPemesananState();
}

class _DetailPemesananState extends State<DetailPemesanan> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BaseView<PemesananProvider>(
      onModelReady: (model) =>
          model.getDetailPemesanan(idPemesanan: widget.idPemesanan),
      builder: (context, provider, child) {
        return Scaffold(
          key: _globalKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("Detail Pemesanan"),
          ),
          body: provider.state == ViewState.Fetching
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 32),
                      padding: EdgeInsets.only(bottom: 32),
                      child: ListView(
                        children: [
                          _ContainerInfo(
                            title: "Status Pemesanan",
                            subtitle: provider
                                .detailPemesananModel.data.dataPemesanan.status,
                          ),
                          _ContainerInfo(
                            title: "Pemesan",
                            subtitle: provider
                                .detailPemesananModel.data.dataUserPemesan.name,
                          ),
                          _ContainerInfo(
                            title: "No Hp",
                            subtitle: provider
                                .detailPemesananModel.data.dataUserPemesan.noHp
                                .toString(),
                          ),
                          _ContainerInfo(
                            title: "Tanggal Main",
                            subtitle: DateFormat('dd MMM yyyy').format(provider
                                .detailPemesananModel
                                .data
                                .dataPemesanan
                                .tanggalPemesanan),
                          ),
                          _ContainerInfo(
                            title: "Jam Main",
                            subtitle: provider.jamMain,
                          ),
                          _ContainerInfo(
                            title: "Total Bayar",
                            subtitle: provider
                                .detailPemesananModel.data.dataPemesanan.totalBaya
                                .toString(),
                          ),
                          _ContainerInfo(
                            title: "Tanggal Pemesanan",
                            subtitle: DateFormat('dd MMM yyyy, HH:mm').format(
                                provider.detailPemesananModel.data.dataPemesanan
                                    .createdAt),
                          ),
                          provider.detailPemesananModel.data.fotoPembayaran == null
                              ? Container()
                              :  Container(
                            child: ListTile(
                              title: Text("Bukti bayar"),
                              subtitle: Image.network(baseImageUrl +
                                  provider.detailPemesananModel.data
                                      .fotoPembayaran.foto),
                            ),
                          ),

                          provider.detailPemesananModel.data.dataPemesanan.status == "Menunggu Konfirmasi" ?
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: RaisedButton(
                                    child: Text(
                                      "Konfirmasi",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.blueAccent,
                                    onPressed: () async {
                                      showDialog(
                                          context: _globalKey.currentContext,
                                          builder: (context) {
                                            return AlertDialog(
                                              title:
                                              Text("Apakah anda yakin?"),
                                              actions: [
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.pop(_globalKey.currentContext);
                                                    },
                                                    child: Text(
                                                      "Tidak",
                                                      style: TextStyle(
                                                          color:
                                                          Colors.black),
                                                    )),
                                                FlatButton(
                                                  child: Text("Ya"),
                                                  onPressed: () async {
                                                    Navigator.pop(_globalKey.currentContext);
                                                    EasyLoading.show(
                                                        status: "Loading...");
                                                    bool res = await provider
                                                        .postKonfirmasiPemesanan(
                                                        idPemesanan: widget
                                                            .idPemesanan,
                                                        status:
                                                        'konfirmasi');
                                                    EasyLoading.dismiss();
                                                    if (res) {
                                                      Navigator.pop(_globalKey.currentContext);
                                                      EasyLoading.showToast(
                                                          "Berhasil");
                                                    } else {
                                                      EasyLoading.showToast(
                                                          "Gagal, silahkan coba lagi");
                                                    }
                                                  },
                                                )
                                              ],
                                            );
                                          });
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: OutlineButton(
                                    borderSide: BorderSide(color: Colors.red),
                                    child: Text(
                                      "Tolak Pemesanan",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                          context: _globalKey.currentContext,
                                          builder: (context) {
                                            return AlertDialog(
                                              title:
                                              Text("Apakah anda yakin?"),
                                              actions: [
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.pop(_globalKey.currentContext);
                                                    },
                                                    child: Text(
                                                      "Tidak",
                                                      style: TextStyle(
                                                          color:
                                                          Colors.black),
                                                    )),
                                                FlatButton(
                                                  child: Text("Ya"),
                                                  onPressed: () async {
                                                    Navigator.pop(_globalKey.currentContext);
                                                    EasyLoading.show(
                                                        status: "Loading...");
                                                    bool res = await provider
                                                        .postKonfirmasiPemesanan(
                                                        idPemesanan: widget
                                                            .idPemesanan,
                                                        status:
                                                        'Pemesanan Gagal');
                                                    EasyLoading.dismiss();
                                                    if (res) {
                                                      Navigator.pop(_globalKey.currentContext);
                                                      EasyLoading.showToast(
                                                          "Berhasil");
                                                    } else {
                                                      EasyLoading.showToast(
                                                          "Gagal, silahkan coba lagi");
                                                    }
                                                  },
                                                )
                                              ],
                                            );
                                          });
                                    },
                                  ),
                                ),
                              )
                            ],
                          )
                              : Container()
                        ],
                      ),
                    ),

                 provider.detailPemesananModel.data.dataPemesanan.status == "Berhasil" ? Positioned(
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(8),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          color: Colors.blueAccent,
                          child: Text("SELESAI", style: TextStyle(color: Colors.white),),
                          onPressed: () async{
                            showDialog(
                                context: _globalKey.currentContext,
                                builder: (context) {
                                  return AlertDialog(
                                    title:
                                    Text("Apakah anda yakin?"),
                                    actions: [
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.pop(_globalKey.currentContext);
                                          },
                                          child: Text(
                                            "Tidak",
                                            style: TextStyle(
                                                color:
                                                Colors.black),
                                          )),
                                      FlatButton(
                                        child: Text("Ya"),
                                        onPressed: () async {
                                          Navigator.pop(_globalKey.currentContext);
                                          EasyLoading.show(
                                              status: "Loading...");
                                          bool res = await provider
                                              .postKonfirmasiPemesanan(
                                              idPemesanan: widget
                                                  .idPemesanan,
                                              status:
                                              'selesai');
                                          EasyLoading.dismiss();
                                          if (res) {
                                            Navigator.pop(_globalKey.currentContext);
                                            EasyLoading.showToast(
                                                "Berhasil");
                                          } else {
                                            EasyLoading.showToast(
                                                "Gagal, silahkan coba lagi");
                                          }
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                        ),
                      ),
                    ),
                  ) : Container()
                ],
              ),
        );
      },
    );
  }
}

class _ContainerInfo extends StatelessWidget {
  final String title;
  final String subtitle;

  _ContainerInfo({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.2)))),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle,),
      ),
    );
  }
}
