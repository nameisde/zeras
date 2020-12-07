import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zeras/model/user/profile/profile_model.dart';
import 'package:zeras/model/user/profile/textstyleprofile_model.dart';
import 'package:zeras/shared/sizedbox.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File _image;
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
      body: user != null
          ? Container(
              child: StreamBuilder<DocumentSnapshot>(
                stream: Firestore.instance
                    .collection('users')
                    .document(user.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error : ${snapshot.error}');
                  }
                  return snapshot.hasData
                      ? Container(
                          child: ListView(children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(left: 20.0, top: 25.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        margin: EdgeInsets.only(top: 30.0),
                                        child: TextStyleProfileModel(
                                            title: 'Profile')),
                                    ProfileModel(
                                        fileimage: _image,
                                        image: Image.network(
                                            snapshot.data['photoUrl'],
                                            fit: BoxFit.cover),
                                        name: snapshot.data['firstname'] +
                                            ' ' +
                                            snapshot.data['lastname'],
                                        alamat: snapshot.data['alamat'])
                                  ])),
                          SizedBoxProfileModel(),
                          Container(
                              margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 20.0, bottom: 10.0),
                                        child: TextStyleProfileModel(
                                            title: 'Ubah Profile')),
                                    ProfileUbahAkunModel()
                                  ])),
                          SizedBoxProfileModel(),
                          Container(
                              margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 20.0, bottom: 10.0),
                                        child: TextStyleProfileModel(
                                            title: 'Tentang')),
                                    ProfileTentang()
                                  ])),
                          ProfileBottomModel()
                        ]))
                      : Text('');
                },
              ),
            )
          : Text(''),
    );
  }
}
