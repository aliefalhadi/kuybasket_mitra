import 'package:flutter/material.dart';
import 'package:flutterstarter/core/route/StringsRouterApp.dart';
import 'package:flutterstarter/provider/TambahLapanganProvider.dart';

class TambahFasilitasLapangan extends StatefulWidget {
  final TambahLapanganProvider provider;
  TambahFasilitasLapangan({this.provider});

  @override
  _TambahFasilitasLapanganState createState() =>
      _TambahFasilitasLapanganState();
}

class _TambahFasilitasLapanganState extends State<TambahFasilitasLapangan> {
  List listFasilitasLapangan = [
    {'nama': 'Ruang Ganti', 'isSelected': false},
    {'nama': 'Loker', 'isSelected': false},
    {'nama': 'Kantin', 'isSelected': false},
    {'nama': 'Kamar Mandi', 'isSelected': false},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              "Tambahkan Fasilitas Lapangan",
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(
              height: 8,
            ),
            Text("Silahkan pilih fasilitas yang tersedia di lapangan anda"),
            SizedBox(
              height: 16,
            ),
            Wrap(
                spacing: 8,
                runSpacing: 16,
                children: List.generate(listFasilitasLapangan.length, (index) {
                  return InkWell(
                    onTap: (){
                      setState(() {
                        listFasilitasLapangan[index]['isSelected'] = !listFasilitasLapangan[index]['isSelected'];
                        if(listFasilitasLapangan[index]['isSelected']){
                          widget.provider.addFasilitaslapangan(listFasilitasLapangan[index]['nama']);
                        }else{
                          widget.provider.removeFasilitaslapangan(listFasilitasLapangan[index]['nama']);
                        }
                      });
                    },
                    child: _PilihanFasilitasLapangan(
                      label: listFasilitasLapangan[index]['nama'],
                      isSelected: listFasilitasLapangan[index]['isSelected'],
                    ),
                  );
                })),
            SizedBox(
              height: 24,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                color: Colors.blueAccent,
                child: Text(
                  "Simpan",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  print(widget.provider.dataFasilitasLapangan);
                  Navigator.pushNamed(context, StringsRouterApp.tambahFotoLapangan, arguments: widget.provider);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _PilihanFasilitasLapangan extends StatelessWidget {
  final String label;
  final bool isSelected;

  _PilihanFasilitasLapangan({this.label, this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blueAccent : Colors.white,
        border: Border.all(color: isSelected ? Colors.white : Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(color: isSelected ? Colors.white : Colors.black),
      ),
    );
  }
}
