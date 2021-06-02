import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterstarter/provider/TambahLapanganProvider.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TambahFotoLapangan extends StatefulWidget {
  final TambahLapanganProvider provider;
  TambahFotoLapangan({this.provider});

  @override
  _TambahFotoLapanganState createState() => _TambahFotoLapanganState();
}

class _TambahFotoLapanganState extends State<TambahFotoLapangan> {
  List<File> image = [];
  final picker = ImagePicker();
  getImageFile(ImageSource source) async {
    var imagePath = await picker.getImage(
        source: source, imageQuality: 70, maxHeight: 640, maxWidth: 640);
    //  simpan gambar dari kamera di shared supaya ketika keluar aplikasi gambar tidak hilang
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('gambarPengaduan', imagePath.path);

    File croppedImage = await ImageCropper.cropImage(
      sourcePath: imagePath.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
    );
    setState(() {
      image.add(croppedImage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.camera_alt),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: new Text("Tambah foto pengaduan"),
                    content: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              Navigator.pop(context);

                              getImageFile(ImageSource.camera);
                            },
                            leading: Icon(Icons.camera_alt),
                            title: Text("Ambil dari Kamera"),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.pop(context);

                              getImageFile(ImageSource.gallery);
                            },
                            leading: Icon(Icons.image),
                            title: Text("Pilih dari Galeri"),
                          )
                        ],
                      ),
                    ));
              });
        },
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              "Tambahkan Foto Lapangan",
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(
              height: 8,
            ),
            Text("Silahkan tambahkan foto lapangan anda"),
            SizedBox(
              height: 16,
            ),
            AspectRatio(
              aspectRatio: 1 / 1,
              child: image.length < 1
                  ? Container(
                      color: Colors.grey,
                      child: Center(
                        child: Icon(
                          Icons.image,
                          size: 48,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    )
                  : image.length == 1
                      ? Image(
                          image: FileImage(image[0]),
                          fit: BoxFit.cover,
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: image.length,
                          itemBuilder: (context, index) {
                            int jumlah = image.length;
                            int nomor = index + 1;
                            return Stack(
                              children: <Widget>[
                                Image(image: FileImage(image[index])),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 40,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.6),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      nomor.toString() +
                                          '/' +
                                          jumlah.toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
            ),

            SizedBox(height: 24,),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                color: Colors.blueAccent,
                child: Text(
                  "Simpan",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
