import 'package:flutter/material.dart';

class PromoHomeModel extends StatelessWidget {
  final Image image;
  final Function onTap;
  PromoHomeModel({this.image, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(children: <Widget>[
        Material(child: InkWell(onTap: onTap, child: image))
      ]),
    );
  }
}
