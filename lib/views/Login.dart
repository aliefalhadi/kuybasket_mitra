import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutterstarter/core/route/StringsRouterApp.dart';
import 'package:flutterstarter/provider/LoginProvider.dart';
import 'package:flutterstarter/views/BaseView.dart';
import 'package:flutterstarter/views/DaftarView.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return BaseView<LoginProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              "KUYBASKET MITRA",
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 6,
                ),
                Center(
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          "Login",
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text("Silahkan login",
                            style: Theme.of(context).textTheme.bodyText1)
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 80),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nomor Hp",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefixText: "+62", hintText: "Cth: 8228021"),
                        onChanged: (noHp) => provider.noHoChaged(noHp),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                            color: Colors.blueAccent,
                            child: Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async{
                              if(provider.dataLogin['no_hp'] == '' || provider.dataLogin['no_hp'] == '+62'){
                                EasyLoading.showToast('nomor hp tidak boleh kosong');
                              }

                              EasyLoading.show(status: 'Loading...');
                              String res = await provider.login();
                              EasyLoading.dismiss();
                              if(res == 'home'){
                                Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
                              }else if(res == 'tambah-lapangan'){
                                //tambah lapangan
                                Navigator.pushNamedAndRemoveUntil(context, StringsRouterApp.tambahInfoLapangan, (route) => false);
                              }else{
                                EasyLoading.showToast(provider.errMessage);
                              }
                            }),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: OutlineButton(
                            color: Colors.blueAccent,
                            child: Text(
                              "Daftar Mitra",
                            ),
                            onPressed: () {
                                Navigator.push(context,MaterialPageRoute(builder: (_)=>DaftarView()));
                            }),
                      ),
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
