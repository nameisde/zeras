import 'package:flutter/material.dart';
import 'package:zeras/shared/textstyle.dart';
import 'package:zeras/view/user/home/header/penampung/penampung_view.dart';
import 'package:zeras/view/user/home/header/transaksi/transaksi_view.dart';
import 'package:zeras/view/user/home/header/tariksaldo/tariksaldo_view.dart';

class HeaderHomePageModel extends StatelessWidget {
  final String firstName;
  final String saldo;
  HeaderHomePageModel({this.firstName, this.saldo});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(children: <Widget>[
      Container(color: Color(0xff216353), height: 180),
      Container(
          margin: EdgeInsets.only(left: 20.0, top: 50.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(firstName, style: styleSizeColor(25.0, Colors.white)),
                Text(saldo,
                    style: styleSizeColorWeight(
                        14.0, Colors.white, FontWeight.normal))
              ])),
    ]));
  }
}

class HeaderMenuBoxDecorationModel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(20, 135, 20, 30),
        height: 90.0,
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  color: Color(0xff216353).withOpacity(0.5),
                  offset: Offset(0.0, 4.0),
                  blurRadius: 20.0,
                  spreadRadius: 1.0)
            ],
            color: Colors.white),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              HeaderMenuImageHomePageModel(
                  title: 'Transaksi',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TransaksiHeaderView()));
                  },
                  image: Image.asset('assets/images/transaksi.png',
                      height: 50, width: 100)),
              HeaderMenuImageHomePageModel(
                  title: 'Tarik Saldo',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TarikSaldoHeaderView()));
                  },
                  image: Image.asset('assets/images/tarik-saldo.png',
                      height: 50, width: 100)),
              HeaderMenuImageHomePageModel(
                  title: 'Penampung',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PenampungHeaderView()));
                  },
                  image: Image.asset('assets/images/penampung.png',
                      height: 50, width: 100)),
            ]));
  }
}

class HeaderMenuImageHomePageModel extends StatelessWidget {
  final Function onTap;
  final Image image;
  final String title;
  HeaderMenuImageHomePageModel({this.onTap, this.image, this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
          vertical: 12.0,
        ),
        child: Column(children: <Widget>[
          Material(child: InkWell(onTap: onTap, child: image)),
          Container(
              child:
                  Text(title, style: styleSizeColor(10.0, Color(0xff216353))))
        ]));
  }
}
