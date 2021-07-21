import 'dart:io';

import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterstarter/core/themes/AppThemes.dart';
import 'package:flutterstarter/provider/UbahLapanganProvider.dart';
import 'package:flutterstarter/utils/Validations.dart';
import 'package:flutterstarter/views/BaseView.dart';
import 'package:flutterstarter/views/lapangan/tambah_lapangan/TambahInfoLapangan.dart';

class UbahInfoLapangan extends StatefulWidget {
  const UbahInfoLapangan({Key key}) : super(key: key);

  @override
  _UbahInfoLapanganState createState() => _UbahInfoLapanganState();
}

class _UbahInfoLapanganState extends State<UbahInfoLapangan> {
  TextEditingController teJamBuka = TextEditingController();
  TextEditingController teJamTutup = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<File> image = [];
  List listFasilitasLapangan = [
    {'nama': 'Ruang Ganti', 'isSelected': false},
    {'nama': 'Loker', 'isSelected': false},
    {'nama': 'Kantin', 'isSelected': false},
    {'nama': 'Kamar Mandi', 'isSelected': false},
  ];

  @override
  Widget build(BuildContext context) {
    return BaseView<UbahLapanganProvider>(
      builder: (context, provider, child){
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: Container(
            padding: EdgeInsets.all(16),
            child: ListView(
              children: [
                Text("Ubah Info Lapangan", style: Theme.of(context).textTheme.headline5,),
                SizedBox(height: 8,),

                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextLabelInput(label: "Foto Lapangan",),
                      Padding(padding: EdgeInsets.all(10)),
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

                      TextLabelInput(label: "Nama Lapangan",),
                      TextFormField(
                        validator: (value)=>Validations.stringValidation(value),
                        decoration: InputDecoration(
                            hintText: "Cth: GOR Panam Raya"
                        ),
                        // onChanged: (value) => provider.dataInfoLapanganChanged(field: 'nama_lapangan', value: value),
                      ),

                      TextLabelInput(label: "Alamat Lapangan",),
                      TextFormField(
                        validator: (value)=>Validations.stringValidation(value),
                        decoration: InputDecoration(
                            hintText: "Cth: Jalan Soebrantas nomor 42"
                        ),
                        // onChanged: (value) => provider.dataInfoLapanganChanged(field: 'alamat_lapangan', value: value),
                      ),

                      TextLabelInput(label: "Jam Buka",),
                      TextFormField(
                        readOnly: true,
                        controller: teJamBuka,
                        validator: (value)=>Validations.stringValidation(value),
                        decoration: InputDecoration(
                            hintText: "Cth: 08:00"
                        ),
                        onTap: (){
                          Navigator.of(context).push(
                            showPicker(
                              is24HrFormat: true,
                              context: context,
                              value: TimeOfDay.now(),
                              onChange: (time){
                                print(time.hour.toString()+":"+time.minute.toString());
                                setState(() {
                                  teJamBuka.text = time.hour.toString()+":"+time.minute.toString();
                                  // provider.dataInfoLapanganChanged(field: 'jam_buka', value: teJamBuka.text);
                                });
                              },
                            ),
                          );
                        },
                      ),

                      TextLabelInput(label: "Jam Tutup",),
                      TextFormField(
                        readOnly: true,
                        controller: teJamTutup,
                        validator: (value)=>Validations.stringValidation(value),
                        decoration: InputDecoration(
                            hintText: "Cth: 08:00"
                        ),
                        onTap: (){
                          Navigator.of(context).push(
                            showPicker(
                              is24HrFormat: true,
                              context: context,
                              value: TimeOfDay.now(),
                              onChange: (time){
                                print(time.hour.toString()+":"+time.minute.toString());
                                setState(() {
                                  teJamTutup.text = time.hour.toString()+":"+time.minute.toString();
                                  // provider.dataInfoLapanganChanged(field: 'jam_tutup', value: teJamTutup.text);
                                });
                              },
                            ),
                          );
                        },
                      ),

                      TextLabelInput(label: "Biaya per Jam",),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value)=>Validations.stringValidation(value),
                        decoration: InputDecoration(
                            hintText: "Cth: 40.000"
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          // Fit the validating format.
                          //fazer o formater para dinheiro
                          CurrencyInputFormatter()
                        ],
                        onChanged: (value) {
                          // repalce format currency
                          String valueFinal =
                          value.replaceAll('.', '');
                          // provider.dataInfoLapanganChanged(field: 'biaya_per_jam', value: valueFinal);
                        },
                      ),

                      TextLabelInput(label: "Kontak Admin",),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value)=>Validations.stringValidation(value),
                        decoration: InputDecoration(
                            hintText: "Cth: 082280229930"
                        ),
                        // onChanged: (value) => provider.dataInfoLapanganChanged(field: 'kontak_admin', value: value),
                      ),

                      TextLabelInput(label: "Deskripsi Lapangan",),
                      TextFormField(
                        maxLength: null,
                        validator: (value)=>Validations.stringValidation(value),
                        decoration: InputDecoration(
                            hintText: "Cth: GOR ini merupakan gor yang telah dibangun sejak lama, menyediakan berbagai fasilitas"
                        ),
                        // onChanged: (value) => provider.dataInfoLapanganChanged(field: 'deskripsi', value: value),
                      ),

                      TextLabelInput(label: "Fasilitas Lapangan",),
                      Padding(padding: EdgeInsets.all(10)),
                      Wrap(
                          spacing: 8,
                          runSpacing: 16,
                          children: List.generate(listFasilitasLapangan.length, (index) {
                            return InkWell(
                              onTap: (){
                                setState(() {
                                  listFasilitasLapangan[index]['isSelected'] = !listFasilitasLapangan[index]['isSelected'];
                                  // if(listFasilitasLapangan[index]['isSelected']){
                                  //   widget.provider.addFasilitaslapangan(listFasilitasLapangan[index]['nama']);
                                  // }else{
                                  //   widget.provider.removeFasilitaslapangan(listFasilitasLapangan[index]['nama']);
                                  // }
                                });
                              },
                              child: _PilihanFasilitasLapangan(
                                label: listFasilitasLapangan[index]['nama'],
                                isSelected: listFasilitasLapangan[index]['isSelected'],
                              ),
                            );
                          })),

                      SizedBox(height: 16,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          color: Colors.blueAccent,
                          child: Text("Simpan", style: TextStyle(color: Colors.white),),
                          onPressed: () async{
                            FocusScope.of(context).unfocus();
                            if(formKey.currentState.validate()){
                              // print(jsonEncode(provider.dataInfoLapangan));
                              // Navigator.pushNamed(context, StringsRouterApp.tambahFasilitasLapangan, arguments: provider);
                              // bool res = await provider.postTambahLapangan();
                            }
                          },
                        ),
                      )
                    ],
                  ),
                )

              ],
            ),
          ),
        );
      },

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

