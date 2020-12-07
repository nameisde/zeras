import 'package:flutter/material.dart';
import 'package:zeras/model/user/homepage/textstylehome_model.dart';
import 'package:zeras/view/user/home/sampah/botol_view.dart';
import 'package:zeras/view/user/home/sampah/kardus_view.dart';
import 'package:zeras/view/user/home/sampah/kertas_view.dart';

class SampahHomePageModel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: Column(children: <Widget>[
          Row(children: <Widget>[TextStyleHomeModel(title: 'Pilih Sampah')]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
              Widget>[
            SampahImageHomePageModel(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => KardusView()));
                },
                image: Image.asset('assets/images/kardus.png',
                    height: 100.0, width: 100.0)),
            SampahImageHomePageModel(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => KertasView()));
                },
                image: Image.asset('assets/images/kertas.png',
                    height: 100.0, width: 100.0)),
            SampahImageHomePageModel(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BotolView()));
                },
                image: Image.asset('assets/images/botol.png',
                    height: 100.0, width: 100.0))
          ])
        ]));
  }
}

class SampahImageHomePageModel extends StatelessWidget {
  final Image image;
  final Function onTap;
  SampahImageHomePageModel({this.image, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Material(child: InkWell(onTap: onTap, child: image))
    ]);
  }
}
