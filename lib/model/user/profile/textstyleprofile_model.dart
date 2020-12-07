import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeras/shared/textstyle.dart';

class TextStyleProfileModel extends StatelessWidget {
  final String title;
  TextStyleProfileModel({this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(title, style: styleSizeColor(20.0, Colors.black)),
    );
  }
}
