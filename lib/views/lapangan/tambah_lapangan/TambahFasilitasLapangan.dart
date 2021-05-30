import 'package:flutter/material.dart';

class TambahFasilitasLapangan extends StatefulWidget {
  const TambahFasilitasLapangan({Key key}) : super(key: key);

  @override
  _TambahFasilitasLapanganState createState() => _TambahFasilitasLapanganState();
}

class _TambahFasilitasLapanganState extends State<TambahFasilitasLapangan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
          backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            Text("Tambahkan Fasilitas Lapangan", style: Theme.of(context).textTheme.headline5,),
            SizedBox(height: 8,),
            Text("Silahkan pilih fasilitas yang tersedia di lapangan anda"),
            SizedBox(height: 16,),
            Wrap(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Text("Ruang Ganti"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
