import 'package:flutter/cupertino.dart';
import 'package:zeras/shared/textstyle.dart';

class TextStyleHomeModel extends StatelessWidget {
  final String title;
  TextStyleHomeModel({this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: Text(title, style: styleSizeColor(15.0, Color(0xff216353))),
    );
  }
}
