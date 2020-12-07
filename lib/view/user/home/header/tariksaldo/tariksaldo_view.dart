import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:zeras/model/user/homepage/tariksaldo_model.dart';
import 'package:zeras/shared/textstyle.dart';

class TarikSaldoHeaderView extends StatefulWidget {
  @override
  _TarikSaldoHeaderViewState createState() => _TarikSaldoHeaderViewState();
}

class _TarikSaldoHeaderViewState extends State<TarikSaldoHeaderView> {
  final money = NumberFormat("#,##0", "en_us");
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> getUser() {
    return _auth.currentUser();
  }

  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff216353),
        title: Text('Tarik Saldo'),
      ),
      body: user != null
          ? SingleChildScrollView(
              child: StreamBuilder<DocumentSnapshot>(
                  stream: Firestore.instance
                      .collection('users')
                      .document(user.uid)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error : ${snapshot.hasError}');
                    }
                    return snapshot.hasData
                        ? Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 50.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Saldo  :',
                                      style:
                                          styleSizeColor(14.0, Colors.black)),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                            height: 68.0,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color(0xff216353)
                                                          .withOpacity(0.1),
                                                      offset: Offset(0.0, 4.0),
                                                      blurRadius: 50.0,
                                                      spreadRadius: 1.0)
                                                ],
                                                color: Colors.white),
                                            child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 15.0),
                                                child: Row(children: <Widget>[
                                                  Text('Rp.   ',
                                                      style: styleSizeColor(
                                                          20.0, Colors.black)),
                                                  Text(
                                                      money.format(int.parse(
                                                          snapshot.data['saldo']
                                                              .toString())),
                                                      style: styleSizeColor(
                                                          20.0, Colors.black))
                                                ]))),
                                        Container(
                                            margin: EdgeInsets.only(top: 40.0),
                                            child: Column(children: <Widget>[
                                              Text('Metode  :',
                                                  style: styleSizeColor(
                                                      14.0, Colors.black))
                                            ]))
                                      ]),
                                  Container(
                                      height: 300.0,
                                      child: TarikSaldoListViewModel())
                                ]))
                        : Text('');
                  }))
          : Text(''),
    );
  }
}
