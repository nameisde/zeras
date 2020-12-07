import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:zeras/shared/logout.dart';
import 'package:zeras/shared/textstyle.dart';

Widget appBarHomePageModel(BuildContext context) {
  return AppBar(
    backgroundColor: Color(0xff216353),
    centerTitle: true,
    leading: Icon(EvaIcons.cube),
    title: Text('ZERAS', style: styleSizeColor(25.0, Colors.orange[300])),
    actions: <Widget>[Logout(), SizedBox(width: 10)],
  );
}
