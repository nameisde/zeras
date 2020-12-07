import 'package:flutter/material.dart';
import 'package:zeras/model/user/promo/promonav/promonav_model.dart';

class Promo extends StatefulWidget {
  @override
  _PromoState createState() => _PromoState();
}

class _PromoState extends State<Promo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(backgroundColor: Color(0xff216353), title: Text('Promo')),
        body: Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[PromoNavModel()])));
  }
}
