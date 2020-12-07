import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zeras/shared/textstyle.dart';
import 'package:zeras/shared/validator.dart';
import 'package:zeras/view/user/home/header/tariksaldo/tariksaldopage/dana.dart';
import 'package:zeras/view/user/home/header/tariksaldo/tariksaldopage/gopay.dart';
import 'package:zeras/view/user/home/header/tariksaldo/tariksaldopage/ovo.dart';

var id = [OVO(), GOPAY(), DANA()];

class TarikSaldoModel {
  String name;
  String estimation;
  String walletLogo;

  TarikSaldoModel(
    this.name,
    this.estimation,
    this.walletLogo,
  );
}

List<TarikSaldoModel> tariksaldo = tariksaldoData
    .map((item) => TarikSaldoModel(
          item['name'],
          item['estimation'],
          item['walletLogo'],
        ))
    .toList();

var tariksaldoData = [
  {
    "name": "OVO",
    "estimation": "Instant",
    "walletLogo": 'assets/images/ovo_logo.png',
  },
  {
    "name": "GOPAY",
    "estimation": "Instant",
    "walletLogo": 'assets/images/gopay_logo.png',
  },
  {
    "name": "DANA",
    "estimation": "Instant",
    "walletLogo": 'assets/images/dana_logo.png',
  }
];

class TarikSaldoListViewModel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: tariksaldo.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => id[index]));
            },
            child: Container(
                margin: EdgeInsets.only(bottom: 8),
                height: 68,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x04000000),
                          blurRadius: 10,
                          spreadRadius: 10,
                          offset: Offset(0.0, 8.0))
                    ],
                    color: Colors.white),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(children: <Widget>[
                        SizedBox(width: 12),
                        Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                                image: DecorationImage(
                                    image: AssetImage(
                                        tariksaldo[index].walletLogo)))),
                        SizedBox(width: 12),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(tariksaldo[index].name,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold)),
                              Text(tariksaldo[index].estimation,
                                  style: TextStyle(color: Color(0xff216353)))
                            ])
                      ])
                    ])),
          );
        });
  }
}

class TarikSaldoODGModel extends StatefulWidget {
  final Function validator;
  final String textjudul;
  final Function onChanged;

  TarikSaldoODGModel({
    this.validator,
    this.textjudul,
    this.onChanged,
  });

  @override
  _TarikSaldoODGModelState createState() => _TarikSaldoODGModelState();
}

class _TarikSaldoODGModelState extends State<TarikSaldoODGModel> {
  Random random = new Random();
  String saldo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(bottom: 50.0),
              child: Image.asset('assets/images/tarik-saldo.png',
                  cacheHeight: 150, cacheWidth: 250)),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Text('Jumlah Tarik Saldo:  ',
                style: styleSizeColor(14.0, Colors.black))
          ]),
          TextFormField(
              validator: Validator.validateNumber,
              onChanged: (value) {
                this.saldo = value;
              },
              autofocus: false,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelStyle: TextStyle(
                      color: Color(0xff216353),
                      fontFamily: 'Poppins',
                      fontSize: 15),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)))),
          Container(
            height: 55.0,
            width: MediaQuery.of(context).size.width - 50,
            child: RaisedButton(
                child: Text('Tarik Saldo',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold)),
                color: Color(0xff216353),
                onPressed: () async {
                  var user = await FirebaseAuth.instance.currentUser();
                  Firestore.instance
                      .collection('users')
                      .document(user.uid)
                      .updateData(
                          {'saldo': FieldValue.increment(-int.parse(saldo))})
                      .then(
                        (value) async => Firestore.instance
                            .collection('transaksi')
                            .document('tariksaldo')
                            .collection(user.uid)
                            .document(random.nextInt(1000000).toString())
                            .setData(
                          {
                            'tariksaldo': saldo,
                            'useruid': user.uid,
                            'time': DateFormat.yMMMd()
                                .add_jm()
                                .format(new DateTime.now())
                          },
                        ),
                      )
                      .then((value) => Flushbar(
                          title: 'Tarik Saldo Berhasil',
                          message: 'Saldo Anda Berkurang Rp.$saldo',
                          duration: Duration(seconds: 3))
                        ..show(context));
                }),
          )
        ],
      ),
    );
  }
}
