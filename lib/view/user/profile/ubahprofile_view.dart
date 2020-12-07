import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zeras/model/user/profile/ubahprofile/ubahprofile_model.dart';
import 'package:zeras/shared/loading.dart';
import 'package:zeras/shared/validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UbahProfileView extends StatefulWidget {
  @override
  _UbahProfileViewState createState() => _UbahProfileViewState();
}

class _UbahProfileViewState extends State<UbahProfileView> {
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

  final _formKey = GlobalKey<FormState>();

  String firstName;
  String lastName;
  String email;
  String password;
  String alamat;

  File _image;

  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        print('Image Path $_image');
      });
    }

    Future uploadPic(BuildContext context) async {
      String fileName = basename(_image.path);
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      // StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      String docUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      Firestore.instance
          .collection('users')
          .document(user.uid)
          .updateData({'photoUrl': docUrl});
      setState(() {
        print("Profile Picture uploaded");
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
      });
    }

    return Scaffold(
        appBar: AppBar(
            title: Text('Ubah Profile'), backgroundColor: Color(0xff216353)),
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
                        return Text('Error : ${snapshot.hasError}');
                      }
                      if (snapshot.hasData) {
                        return Container(
                            child: SingleChildScrollView(
                                child: Form(
                                    key: _formKey,
                                    child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 30.0, vertical: 20.0),
                                        child: Column(children: <Widget>[
                                          GestureDetector(
                                              onTap: () {
                                                getImage();
                                              },
                                              child: CircleAvatar(
                                                backgroundColor: Color(0xff216353),
                                                  radius: 60.0,
                                                  child: ClipOval(
                                                      child: SizedBox(
                                                          width: 115,
                                                          height: 115,
                                                          child: _image != null
                                                              ? Container(
                                                                  child: CircleAvatar(
                                                                      radius:
                                                                          60.0,
                                                                      backgroundColor:
                                                                          Color(
                                                                              0xff216353),
                                                                      child: ClipOval(
                                                                          child: SizedBox(
                                                                              width:
                                                                                  115,
                                                                              height:
                                                                                  115,
                                                                              child: Icon(EvaIcons.camera,
                                                                                  size:
                                                                                      30.0)))))
                                                              : Image.network(
                                                                  snapshot.data[
                                                                      'photoUrl'],
                                                                  fit: BoxFit
                                                                      .cover))))),
                                          SizedBox(height: 20.0),
                                          GestureDetector(
                                              child: Text('Upload Foto'),
                                              onTap: () {
                                                uploadPic(context);
                                              }),
                                          SizedBox(height: 20.0),
                                          UbahProfileModel(
                                              textjudul: 'Firstname :',
                                              validator: Validator.validateName,
                                              hintText:
                                                  snapshot.data['firstname'],
                                              onChanged: (value) {
                                                this.firstName = value;
                                              }),
                                          UbahProfileModel(
                                              textjudul: 'Lastname :',
                                              validator: Validator.validateName,
                                              hintText:
                                                  snapshot.data['lastname'],
                                              onChanged: (value) {
                                                this.lastName = value;
                                              }),
                                          UbahProfileModel(
                                              textjudul: 'Email :',
                                              validator:
                                                  Validator.validateEmail,
                                              hintText: snapshot.data['email'],
                                              onChanged: (value) {
                                                this.email = value;
                                              }),
                                          UbahProfileModel(
                                              textjudul: 'Password :',
                                              validator: Validator.validateName,
                                              hintText:
                                                  snapshot.data['password'],
                                              onChanged: (value) {
                                                this.password = value;
                                              }),
                                          UbahProfileModel(
                                              textjudul: 'Alamat :',
                                              validator: Validator.validateName,
                                              hintText: snapshot.data['alamat'],
                                              onChanged: (value) {
                                                this.alamat = value;
                                              }),
                                          Row(children: <Widget>[
                                            Container(
                                                height: 55.0,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    60,
                                                margin:
                                                    EdgeInsets.only(top: 20.0),
                                                child: RaisedButton(
                                                    child: Text(
                                                        'Update Profile',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18.0,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    color: Color(0xff216353),
                                                    onPressed: () async {
                                                      FocusScope.of(context)
                                                          .requestFocus(
                                                              FocusNode());
                                                      var user =
                                                          await FirebaseAuth
                                                              .instance
                                                              .currentUser();
                                                      Firestore.instance
                                                          .collection('users')
                                                          .document(user.uid)
                                                          .updateData({
                                                        'firstname': firstName,
                                                        'lastname': lastName,
                                                        'email': email,
                                                        'password': password,
                                                        'alamat': alamat
                                                      }).then((value) => Flushbar(
                                                              title:
                                                                  'Update Profile',
                                                              message:
                                                                  'Berhasil Memperbaharui Profile',
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          3))
                                                            ..show(context));
                                                    }))
                                          ])
                                        ])))));
                      } else {
                        return Loading();
                      }
                    }))
            : Loading());
  }
}
