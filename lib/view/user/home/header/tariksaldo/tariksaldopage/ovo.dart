import 'package:flutter/material.dart';
import 'package:zeras/model/user/homepage/tariksaldo_model.dart';

class OVO extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(backgroundColor: Color(0xff216353), title: Text('OVO')),
        body: Container(
            color: Colors.grey.withOpacity(0.1),
            height: MediaQuery.of(context).size.height,
            child: Container(
                margin: EdgeInsets.only(top: 150.0),
                child: Column(children: <Widget>[
                  Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: TarikSaldoODGModel())
                ]))));
  }
}
