import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutterstarter/core/route/StringsRouterApp.dart';
import 'package:flutterstarter/core/themes/AppThemes.dart';
import 'package:flutterstarter/provider/DaftarProvider.dart';
import 'package:flutterstarter/utils/Validations.dart';
import 'package:flutterstarter/views/BaseView.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:toast/toast.dart';

class DaftarView extends StatefulWidget {
  const DaftarView({Key key}) : super(key: key);

  @override
  _DaftarViewState createState() => _DaftarViewState();
}

class _DaftarViewState extends State<DaftarView> {
  final formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  File image;
  final picker = ImagePicker();
  getImageFile(ImageSource source) async {
    var imagePath = await picker.getImage(
        source: source, imageQuality: 70, maxHeight: 640, maxWidth: 640);
    //  simpan gambar dari kamera di shared supaya ketika keluar aplikasi gambar tidak hilang


    setState(() {
      image = File(imagePath.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<DaftarProvider>(
      builder: (context, provider, child){
        return  Scaffold(
          key: _globalKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: Container(
            padding: EdgeInsets.all(16),
            child: ListView(
              children: [
                Text("Daftar Mitra Kuybasket", style: Theme.of(context).textTheme.headline5,),
                SizedBox(height: 8,),
                Text("Silahkan lengkapi data dibawah ini"),

                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextLabelInput(label: "NIK",),
                      TextFormField(
                        validator: (value)=>Validations.stringValidation(value),
                        onChanged: (value) => provider.dataDaftarChanged(field: 'nik', value: value),
                      ),

                      TextLabelInput(label: "Nama",),
                      TextFormField(
                        validator: (value)=>Validations.stringValidation(value),
                        onChanged: (value) => provider.dataDaftarChanged(field: 'nama', value: value),
                      ),

                      TextLabelInput(label: "Nomor HP",),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value)=>Validations.stringValidation(value),
                        decoration: InputDecoration(
                            hintText: "Cth: 082280229930"
                        ),
                        onChanged: (value) => provider.dataDaftarChanged(field: 'no_hp', value: value),
                      ),

                      TextLabelInput(label: "Alamat",),
                      TextFormField(
                        validator: (value)=>Validations.stringValidation(value),
                        onChanged: (value) => provider.dataDaftarChanged(field: 'alamat', value: value),
                      ),

                      TextLabelInput(label: "Nama Lapangan",),
                      TextFormField(
                        validator: (value)=>Validations.stringValidation(value),
                        onChanged: (value) => provider.dataDaftarChanged(field: 'nama_lapangan', value: value),
                      ),

                      TextLabelInput(label: "Alamat Lapangan",),
                      TextFormField(
                        validator: (value)=>Validations.stringValidation(value),
                        onChanged: (value) => provider.dataDaftarChanged(field: 'alamat_lapangan', value: value),
                      ),

                      TextLabelInput(label: "Foto Selfie dengan KTP",),
                      SizedBox(height: 8,),
                      InkWell(
                        onTap: (){
                          getImageFile(ImageSource.camera);
                        },
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: image == null ? Container(
                            color: Colors.grey,
                            child: Center(
                              child: Icon(
                                Icons.image,
                                size: 48,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                          ): Image(
                            image: FileImage(image),
                            fit: BoxFit.cover,
                          )
                        ),
                      ) ,

                      SizedBox(height: 16,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          color: Colors.blueAccent,
                          child: Text("Simpan", style: TextStyle(color: Colors.white),),
                          onPressed: () async{
                            FocusScope.of(context).unfocus();
                            if(formKey.currentState.validate()){
                             if(image == null){
                               EasyLoading.showToast('foto tidak boleh kosong');
                             }else{
                               showDialog(
                                   context: _globalKey.currentContext,
                                   builder: (context) {
                                     return AlertDialog(
                                       title: Text("Pendaftaran jadi mitra kuybasket?"),
                                       actions: [
                                         FlatButton(
                                             onPressed: () {
                                               Navigator.pop(_globalKey.currentContext);
                                             },
                                             child: Text("Tidak")),
                                         FlatButton(
                                           child: Text("Ya"),
                                           onPressed: () async {
                                             Navigator.pop(_globalKey.currentContext);
                                             EasyLoading.show(status: "Loading...");
                                             var res = await provider
                                                 .postDaftarMitra(image);
                                             EasyLoading.dismiss();
                                             if(res){
                                               Alert(
                                                 context: _globalKey.currentContext,
                                                 type: AlertType.none,
                                                 title: "",
                                                 content: Column(
                                                   children: [
                                                     vSpace(16),
                                                     Text("Pendaftaran Mitra Kuybasket Berhasil", style: TextStyle(fontWeight: FontWeight.normal),),
                                                     vSpace(8),
                                                     Text("Selanjutnya anda akan dihubungi oleh tim Kuybasket untuk verifikasi data pendaftaran.", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,),

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
                                                       Navigator.pop(_globalKey.currentContext);
                                                     },
                                                     width: 120,
                                                   )
                                                 ],
                                               ).show();
                                             }else{
                                               EasyLoading.showToast('Gagal');
                                             }
                                           },
                                         )
                                       ],
                                     );
                                   });
                             }
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
  vSpace(int i) {
    return SizedBox(height: i.toDouble(),);
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
