import 'dart:convert';

import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterstarter/core/route/StringsRouterApp.dart';
import 'package:flutterstarter/core/themes/AppThemes.dart';
import 'package:flutterstarter/provider/TambahLapanganProvider.dart';
import 'package:flutterstarter/utils/Validations.dart';
import 'package:flutterstarter/views/BaseView.dart';
import 'package:intl/intl.dart';

class TambahInfoLapangan extends StatefulWidget {
  const TambahInfoLapangan({Key key}) : super(key: key);

  @override
  _TambahInfoLapanganState createState() => _TambahInfoLapanganState();
}

class _TambahInfoLapanganState extends State<TambahInfoLapangan> {
  TextEditingController teJamBuka = TextEditingController();
  TextEditingController teJamTutup = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<TambahLapanganProvider>(
      builder: (context, provider, child){
        return  Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: Container(
            padding: EdgeInsets.all(16),
            child: ListView(
              children: [
                Text("Tambah Lapangan", style: Theme.of(context).textTheme.headline5,),
                SizedBox(height: 8,),
                Text("Anda belum memiliki lapangan, silahkan ditambahkan"),

                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextLabelInput(label: "Nama Lapangan",),
                      TextFormField(
                        validator: (value)=>Validations.stringValidation(value),
                        decoration: InputDecoration(
                            hintText: "Cth: GOR Panam Raya"
                        ),
                        onChanged: (value) => provider.dataInfoLapanganChanged(field: 'nama_lapangan', value: value),
                      ),

                      TextLabelInput(label: "Alamat Lapangan",),
                      TextFormField(
                        validator: (value)=>Validations.stringValidation(value),
                        decoration: InputDecoration(
                            hintText: "Cth: Jalan Soebrantas nomor 42"
                        ),
                        onChanged: (value) => provider.dataInfoLapanganChanged(field: 'alamat_lapangan', value: value),
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
                                 provider.dataInfoLapanganChanged(field: 'jam_buka', value: teJamBuka.text);
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
                                  provider.dataInfoLapanganChanged(field: 'jam_tutup', value: teJamTutup.text);
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
                          provider.dataInfoLapanganChanged(field: 'biaya_per_jam', value: valueFinal);
                        },
                      ),

                      TextLabelInput(label: "Kontak Admin",),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value)=>Validations.stringValidation(value),
                        decoration: InputDecoration(
                            hintText: "Cth: 082280229930"
                        ),
                        onChanged: (value) => provider.dataInfoLapanganChanged(field: 'kontak_admin', value: value),
                      ),

                      TextLabelInput(label: "Deskripsi Lapangan",),
                      TextFormField(
                        maxLength: null,
                        validator: (value)=>Validations.stringValidation(value),
                        decoration: InputDecoration(
                            hintText: "Cth: GOR ini merupakan gor yang telah dibangun sejak lama, menyediakan berbagai fasilitas"
                        ),
                        onChanged: (value) => provider.dataInfoLapanganChanged(field: 'deskripsi', value: value),
                      ),

                      SizedBox(height: 16,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          color: Colors.blueAccent,
                          child: Text("Simpan", style: TextStyle(color: Colors.white),),
                          onPressed: (){
                            FocusScope.of(context).unfocus();
                            if(formKey.currentState.validate()){
                              print(jsonEncode(provider.dataInfoLapangan));
                              Navigator.pushNamed(context, StringsRouterApp.tambahFasilitasLapangan, arguments: provider);
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

class CurrencyInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    int value = int.parse(newValue.text);

    String newText =
    NumberFormat.currency(locale: 'id', symbol: '', decimalDigits: 0)
        .format(value);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}
