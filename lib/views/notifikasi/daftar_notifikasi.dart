import 'package:flutter/material.dart';
import 'package:flutterstarter/provider/NotifikasiProvider.dart';
import 'package:flutterstarter/shareds/ViewState.dart';
import 'package:flutterstarter/views/BaseView.dart';
import 'package:timeago/timeago.dart' as timeago;

class DaftarNotifikasi extends StatefulWidget {
  const DaftarNotifikasi({Key key}) : super(key: key);

  @override
  _DaftarNotifikasiState createState() => _DaftarNotifikasiState();
}

class _DaftarNotifikasiState extends State<DaftarNotifikasi> {
  @override
  Widget build(BuildContext context) {
    return BaseView<NotifikasiProvider>(
      onModelReady: (model) => model.getDaftarNotifikasi(),
      builder: (context, provider, child){
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("Daftar Notifikasi"),
          ),
          body:
              provider.state == ViewState.FetchNull ?
                  Center(child: Text("belum ada notifikasi"),)
                  :
          provider.state == ViewState.Fetching ?
              Center(child: CircularProgressIndicator(),)
              :
          Container(
            child: ListView.builder(
              itemCount: provider.daftarNotifikasiModel.data.length,
              itemBuilder: (context, index){
                return  InkWell(
                  onTap: ()async{
                    await provider.bacaNotif(provider.daftarNotifikasiModel.data[index].id.toString());
                    Navigator.pushNamed(context, 'pemesanan/detail', arguments: provider.daftarNotifikasiModel.data[index].keterangan.toString()).then((value) => provider.getDaftarNotifikasi());
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey.withOpacity(0.2))
                        )
                    ),
                    child: ListTile(
                      leading: Icon(Icons.notifications_none, color: Colors.blueAccent,),
                      title: Text(provider.daftarNotifikasiModel.data[index].notifikasi),
                      subtitle: Text(timeago.format(provider.daftarNotifikasiModel.data[index].createdAt)),
                    ),
                  ),
                );
              },
            )
          ),
        );
      },
    );
  }
}
