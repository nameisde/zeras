import 'package:flutter/material.dart';
import 'package:zeras/shared/sizedbox.dart';

class PromoModel extends StatelessWidget {
  final Image image;
  final String infopromo;
  final String ketpromo;
  final String infosyarat;
  final String ketsyarat;
  PromoModel(
      {this.image,
      this.infopromo,
      this.ketpromo,
      this.infosyarat,
      this.ketsyarat});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(child: image),
          Container(
              margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(infopromo,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            height: 1.5)),
                    Text(ketpromo,
                        style: TextStyle(
                            color: Colors.black, fontSize: 13.0, height: 1.5))
                  ])),
          SizedBoxModel(),
          Container(
              margin: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(infosyarat,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            height: 1.5)),
                    Text(ketsyarat,
                        style: TextStyle(
                            color: Colors.black, fontSize: 13.0, height: 1.5))
                  ])),
        ],
      ),
    );
  }
}
