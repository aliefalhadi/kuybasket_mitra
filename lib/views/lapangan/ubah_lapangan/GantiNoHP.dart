import 'package:flutter/material.dart';
import 'package:flutterstarter/core/themes/AppThemes.dart';
import 'package:flutterstarter/provider/LoginProvider.dart';
import 'package:flutterstarter/utils/Validations.dart';
import 'package:flutterstarter/views/BaseView.dart';

class GantiNoHP extends StatefulWidget {
  const GantiNoHP({Key key}) : super(key: key);

  @override
  _GantiNoHPState createState() => _GantiNoHPState();
}

class _GantiNoHPState extends State<GantiNoHP> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginProvider>(
      builder: (context, provider, child){
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: Container(
                padding: EdgeInsets.all(16),
                child: ListView(children: [
                  Text(
                    "Ubah Nomor HP",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                  ),
                  Form(key: formKey,
                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextLabelInput(label: "No HP lama"),
                        TextFormField(
                          validator: (value) => Validations.stringValidation(value),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                        ),
                        TextLabelInput(label: "No HP baru"),
                        TextFormField(
                          validator: (value) => Validations.stringValidation(value),
                          decoration: InputDecoration(hintText: "Cth: 08278289172"),
                          onChanged: ((val){
                            setState(() {
                              provider.noHP = val;
                            });
                          }),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: RaisedButton(
                            color: Colors.blueAccent,
                            child: Text(
                              "Simpan",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              if (formKey.currentState.validate()) {
                                provider.ubahNoHP();
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ])));}

    );
  }
}
