import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zeras/model/user/homepage/cart_model.dart';
import 'package:zeras/model/user/homepage/price_model.dart';
import 'package:zeras/shared/textstyle.dart';

Random random = new Random();
int itemCount = 1;

class PilihSampahModel extends StatelessWidget {
  final String namasampah;
  final Image image;
  final Widget widget;
  final Widget raisedbutton;
  final Widget hargasampah;
  final Function onPressedJual;
  PilihSampahModel(
      {this.namasampah,
      this.image,
      this.widget,
      this.hargasampah,
      this.onPressedJual,
      this.raisedbutton});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartModel>(create: (context) => CartModel()),
        ChangeNotifierProvider<PriceModel>(create: (context) => PriceModel())
      ],
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    height: 350,
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xff216353).withOpacity(0.1),
                              offset: Offset(0.0, 4.0),
                              blurRadius: 20.0,
                              spreadRadius: 1.0)
                        ],
                        color: Colors.white),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text('Berat (kg)',
                              style: styleSizeColor(20.0, Color(0xff216353))),
                          Consumer<PriceModel>(
                              builder: (context, pricemodel, _) => Consumer<
                                      CartModel>(
                                  builder: (context, cartmodel, _) => Container(
                                      child: IncDecButtonModel(
                                          onPressedMinus: () {
                                            if (pricemodel.price >= 3000) {
                                              cartmodel.quantity -= 1;
                                              pricemodel.price -= 1500;
                                              itemCount--;
                                            }
                                          },
                                          title: itemCount.toString(),
                                          onPressedPlus: () {
                                            cartmodel.quantity += 1;
                                            pricemodel.price += 1500;
                                            itemCount++;
                                          })))),
                          Container(
                              child: Column(children: <Widget>[
                            Container(child: image),
                            Text(namasampah,
                                style: styleSizeColor(15.0, Color(0xff216353)))
                          ]))
                        ])),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    height: 80,
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xff216353).withOpacity(0.1),
                              offset: Offset(0.0, 4.0),
                              blurRadius: 20.0,
                              spreadRadius: 1.0)
                        ],
                        color: Colors.white),
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.symmetric(vertical: 15.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Harga',
                                            style: styleSizeColor(
                                                12.0, Colors.grey)),
                                        Container(
                                            child: Consumer<PriceModel>(
                                                builder: (context, pricemodel,
                                                        _) =>
                                                    Text(
                                                        'Rp.  ' +
                                                            pricemodel.price
                                                                .toString(),
                                                        style: styleSizeColor(
                                                            20.0,
                                                            Color(
                                                                0xff216353)))))
                                      ])),
                              Container(
                                  height: 40.0,
                                  width: 125.0,
                                  child: Consumer<PriceModel>(
                                      builder: (context, pricemodel, _) =>
                                          RaisedButton(
                                              color: Color(0xff216353),
                                              child: Text('Jual',
                                                  style: styleSizeColor(
                                                      18.0, Colors.white)),
                                              onPressed: () async {
                                                var user = await FirebaseAuth
                                                    .instance
                                                    .currentUser();
                                                Firestore.instance
                                                    .collection('users')
                                                    .document(user.uid)
                                                    .updateData({
                                                      'saldo':
                                                          FieldValue.increment(
                                                              pricemodel.price)
                                                    })
                                                    .then(
                                                      (value) async => Firestore
                                                          .instance
                                                          .collection(
                                                              'transaksi')
                                                          .document(
                                                              'jualsampah')
                                                          .collection(user.uid)
                                                          .document(random
                                                              .nextInt(1000000)
                                                              .toString())
                                                          .setData(
                                                        {
                                                          'jualsampah':
                                                              pricemodel.price,
                                                          'useruid': user.uid,
                                                          'time': DateFormat.yMMMd().add_jm().format(new DateTime.now())
                                                        },
                                                      ),
                                                    )
                                                    .then((value) => Flushbar(
                                                        title:
                                                            'Jual Kardus Berhasil',
                                                        message:
                                                            'Saldo Anda Berhasil Bertambah Rp.${pricemodel.price}',
                                                        duration: Duration(
                                                            seconds: 2))
                                                      ..show(context));
                                              })))
                            ])))
              ])),
    );
  }
}

class IncDecButtonModel extends StatelessWidget {
  final String title;
  final Function onPressedMinus;
  final Function onPressedPlus;
  IncDecButtonModel({this.title, this.onPressedMinus, this.onPressedPlus});
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
        GFIconButton(
            color: Color(0xffCF4328),
            onPressed: onPressedMinus,
            icon: Icon(EvaIcons.minusOutline)),
        Text(title, style: styleSizeColor(20.0, Color(0xff216353))),
        GFIconButton(
            color: Color(0xff216353),
            onPressed: onPressedPlus,
            icon: Icon(EvaIcons.plusOutline))
      ])
    ]);
  }
}
