import 'package:flutter/material.dart';
import 'package:flutterstarter/provider/LoginProvider.dart';
import 'package:flutterstarter/provider/UbahLapanganProvider.dart';
import 'package:flutterstarter/views/BaseView.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  LoginProvider loginProvider = LoginProvider();
  bool isSwitched = true;

  Widget build(BuildContext context) {
    return BaseView<UbahLapanganProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("Profile"),
          ),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                              BorderSide(color: Colors.grey.withOpacity(0.2)))),
                      child: ListTile(
                        leading: Icon(Icons.edit),
                        title: Text("Status Lapangan"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              isSwitched ? "Buka" : "Tutup",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Switch(
                              value: isSwitched,
                              onChanged: (value) {
                                setState(() {
                                  isSwitched = !isSwitched;
                                  print(isSwitched);
                                });
                              },
                              activeTrackColor: Colors.lightBlueAccent,
                              activeColor: Colors.blueAccent,
                            )
                            // SizedBox(
                            //   width: 8,
                            // ),
                            // Icon(
                            //   Icons.arrow_forward_ios_sharp,
                            //   size: 18,
                            // ),
                          ],
                        ),
                      ),
                    ),
                    _Container(),
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                              BorderSide(color: Colors.grey.withOpacity(0.2)))),
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, 'ubah-lapangan');
                        },
                        leading: Icon(Icons.edit),
                        title: Text("Ubah Data Lapangan"),
                        trailing: Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 18,
                        ),
                      ),
                    ),
                    _Container(),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.grey.withOpacity(0.2)))),
                  child: ListTile(
                    onTap: () {
                      // loginProvider.logOut();
                      print(loginProvider.dataLogin);
                    },
                    leading: Icon(Icons.logout),
                    title: Text("Keluar"),
                    trailing: Icon(
                      Icons.arrow_forward_ios_sharp,
                      size: 18,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      });
  }

}

// class showAlertDialogs extends StatefulWidget {
//   const showAlertDialogs({Key key}) : super(key: key);
//
//   @override
//   __showAlertDialogState createState() => __showAlertDialogState();
// }

// class __showAlertDialogState extends State<showAlertDialogs> {
//   bool isSwitched = true;
//
//   @override
//   Widget build(BuildContext context) async {
//     return await showDialog(
//       context: context,
//       builder: (context) {
//         return  AlertDialog(
//           title: Text("Ubah Status Lapangan"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Switch(
//                 value: isSwitched,
//                 onChanged: (value) {
//                   setState(() {
//                     isSwitched = !isSwitched;
//                     print(isSwitched);
//
//                   });
//                 },
//                 activeTrackColor: Colors.lightGreenAccent,
//                 activeColor: Colors.green,
//
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

class _Container extends StatelessWidget {
  const _Container({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.2)))),
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, 'ganti-nohp');
        },
        leading: Icon(Icons.person),
        title: Text("Ganti Nomor HP"),
        trailing: Icon(
          Icons.arrow_forward_ios_sharp,
          size: 18,
        ),
      ),
    );
  }
}
