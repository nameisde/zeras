import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeras/service/authservice.dart';
import 'package:zeras/shared/textstyle.dart';
import 'package:zeras/view/user/profile/keuntungan_view.dart';
import 'package:zeras/view/user/profile/panduan_view.dart';
import 'package:zeras/view/user/profile/pusatbantuan_view.dart';
import 'package:zeras/view/user/profile/ubahprofile_view.dart';

class ProfileModel extends StatelessWidget {
  final File fileimage;
  final Image image;
  final String name;
  final String alamat;
  ProfileModel({this.fileimage, this.image, this.name, this.alamat});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(children: <Widget>[
          CircleAvatar(
              backgroundColor: Color(0xff216353),
              radius: 40.0,
              child: ClipOval(
                  child: SizedBox(
                      width: 75,
                      height: 75,
                      child: fileimage != null
                          ? Container(
                              child: CircleAvatar(
                                  radius: 40.0,
                                  backgroundColor: Color(0xff216353),
                                  child: ClipOval(
                                      child: SizedBox(width: 75, height: 75))))
                          : image))),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(name, style: styleSizeColor(15.0, Colors.black)),
                    Text(alamat,
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 12.0))
                  ]))
        ]));
  }
}

class ProfileUbahAkunModel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ProfileListModel(
            icon: EvaIcons.person,
            title: 'Ubah Profile',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UbahProfileView()));
            }));
  }
}

class ProfileTentang extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ProfileListModel(
              icon: EvaIcons.award,
              title: 'Keuntungan Pakai Zeras',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => KeuntunganView()));
              }),
          ProfileListModel(
              icon: EvaIcons.alertCircle,
              title: 'Panduan Zeras',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PanduanProfileView()));
              }),
          ProfileListModel(
              icon: EvaIcons.questionMarkCircle,
              title: 'Pusat Bantuan',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PusatBantuanProfileView()));
              }),
        ],
      ),
    );
  }
}

class ProfileBottomModel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      SingleChildScrollView(
          child: Container(
              alignment: Alignment.topCenter,
              height: 120.0,
              color: Colors.grey.withOpacity(0.1),
              child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                  child: Column(children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Version 1.0'),
                        Text('#zerasaja')
                      ],
                    ),
                    Row(children: <Widget>[
                      Container(
                          height: 55.0,
                          width: MediaQuery.of(context).size.width - 50,
                          margin: EdgeInsets.only(top: 20.0),
                          child: RaisedButton(
                              child: Text('Logout',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold)),
                              color: Color(0xff216353),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                            title: Text('Log Out'),
                                            content: Text(
                                                'Are you sure, want to logout?'),
                                            actions: <Widget>[
                                              FlatButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop('Cancel');
                                                  },
                                                  child: Text('Cancel')),
                                              FlatButton(
                                                  onPressed: () async {
                                                    await Provider.of<
                                                                AuthService>(
                                                            context,
                                                            listen: false)
                                                        .logout()
                                                        .then((value) {
                                                      Navigator.of(context)
                                                          .pop('Logout');
                                                    });
                                                  },
                                                  child: Text('Accept'))
                                            ]));
                              }))
                    ])
                  ]))))
    ]);
  }
}

class ProfileListModel extends StatelessWidget {
  final String title;
  final IconData icon, trailing;
  final Function onTap;

  ProfileListModel({this.title, this.icon, this.trailing, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Material(
        child: InkWell(
            child: Container(
                color: Colors.white.withOpacity(0.9),
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: ListTile(
                    leading: Icon(icon, color: Color(0xff216353)),
                    title: Text(title, style: TextStyle(fontSize: 15.0)),
                    trailing: Icon(EvaIcons.arrowIosForwardOutline),
                    onTap: onTap))));
  }
}
