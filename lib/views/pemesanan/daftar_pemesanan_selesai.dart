import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterstarter/provider/PemesananProvider.dart';
import 'package:flutterstarter/shareds/ViewState.dart';
import 'package:flutterstarter/views/BaseView.dart';
import 'package:intl/intl.dart';

class DaftarPemesananSelesai extends StatefulWidget {
  const DaftarPemesananSelesai({Key key}) : super(key: key);

  @override
  _DaftarPemesananSelesaiState createState() =>
      _DaftarPemesananSelesaiState();
}

class _DaftarPemesananSelesaiState
    extends State<DaftarPemesananSelesai> {
  @override
  Widget build(BuildContext context) {
    return BaseView<PemesananProvider>(
      onModelReady: (model)=>model.getDaftarPemesanan(status: 'selesai'),
      builder: (context, provider, child) {
        return provider.state == ViewState.Fetching
            ? Center(
                child: CircularProgressIndicator(),
              )
            : provider.state == ViewState.FetchNull
                ? Center(
                    child: Text("Belum ada pemesanan lapangan"),
                  )
                : RefreshIndicator(
                  onRefresh: () => provider.getDaftarPemesanan(status: 'selesai'),
                  child: Container(
                      child: ListView.builder(
                          itemCount: provider.daftarPemesananModel.data.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, 'pemesanan/detail', arguments: provider.daftarPemesananModel.data[index].data.idPemesananLapangan.toString()).then((value) => provider.getDaftarPemesanan(status: 'selesai'));
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 8),
                                padding: EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color:
                                                Colors.grey.withOpacity(0.2)))),
                                child: ListTile(

                                  title: Text(provider.daftarPemesananModel.data[index].dataPemesan.name),
                                  subtitle: Text(DateFormat('dd MMM yyyy, HH:mm').format(provider.daftarPemesananModel.data[index].data.createdAt)),
                                  trailing: Text(provider.daftarPemesananModel.data[index].data.status, style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ),
                            );
                          })),
                );
      },
    );
  }
}
