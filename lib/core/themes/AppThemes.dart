import 'package:flutter/cupertino.dart';

class TextLabelInput extends StatelessWidget {
  final String label;
  TextLabelInput({this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Text(label, style: TextStyle(fontWeight: FontWeight.bold),),
    );
  }
}
