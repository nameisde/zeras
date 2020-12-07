import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zeras/shared/loading.dart';
import 'package:intl/intl.dart';
import 'package:zeras/model/user/homepage/appbar_model.dart';
import 'package:zeras/model/user/homepage/header_model.dart';
import 'package:zeras/model/user/homepage/infopromo_model.dart';
import 'package:zeras/shared/sizedbox.dart';
import 'package:zeras/model/user/homepage/sampah_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        backgroundColor: Colors.white,
        appBar: appBarHomePageModel(context),
        body: user != null
            ? StreamBuilder<DocumentSnapshot>(
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
                      ? SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                              Stack(children: <Widget>[
                                HeaderHomePageModel(
                                    firstName: snapshot.data['firstname'],
                                    saldo: 'Rp. ' +
                                        money.format(int.parse(snapshot
                                            .data['saldo']
                                            .toString()))),
                                HeaderMenuBoxDecorationModel(),
                              ]),
                              SampahHomePageModel(),
                              SizedBoxModel(),
                              InfoPromoHomePageModel(),
                            ]))
                      : Text('');
                })
            : Center(child: Loading()));
  }
}
