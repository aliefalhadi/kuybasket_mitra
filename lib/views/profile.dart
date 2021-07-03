import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body:Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey.withOpacity(0.2))
                      )
                  ),
                  child: ListTile(
                    leading: Icon(Icons.edit),
                    title: Text("Status Lapangan"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Buka", style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(width: 8,),
                        Icon(Icons.arrow_forward_ios_sharp, size: 18,),
                      ],
                    ),
                  ),
                ),
                _Container(),
                _Container(),
                _Container(),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.grey.withOpacity(0.2))
                  )
              ),
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text("Keluar"),
                trailing: Icon(Icons.arrow_forward_ios_sharp, size: 18,),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Container extends StatelessWidget {
  const _Container({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.grey.withOpacity(0.2))
          )
      ),
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text("Ganti Nomor HP"),
        trailing: Icon(Icons.arrow_forward_ios_sharp, size: 18,),
      ),
    );
  }
}
