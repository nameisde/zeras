import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zeras/shared/loading.dart';
import 'package:zeras/view/admin/navigation/admin_navigation.dart';
import 'package:zeras/view/user/navigation/user_navigation.dart';

class RoleCheck extends StatefulWidget {
  @override
  _RoleCheckState createState() => _RoleCheckState();
}

class _RoleCheckState extends State<RoleCheck> {
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
                        .collection('/users')
                        .document(user.uid)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.hasError}');
                      }
                      return snapshot.hasData
                          ? _checkRole(snapshot.data)
                          : Text('');
                    }))
            : Center(child: Loading()));
  }
}

_checkRole(DocumentSnapshot snapshot) {
  if (snapshot.data['role'] == 'admin') {
    return AdminNavigation();
  } else {
    return UserNavigation();
  }
}
