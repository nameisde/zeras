import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zeras/shared/loading.dart';

class TransaksiJualSampah extends StatefulWidget {
  @override
  _TransaksiJualSampahState createState() => _TransaksiJualSampahState();
}

class _TransaksiJualSampahState extends State<TransaksiJualSampah> {
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
      appBar:
          AppBar(backgroundColor: Color(0xff216353), title: Text('Jual Sampah')),
      body: user != null
          ? Container(
              child: StreamBuilder(
                stream: Firestore.instance
                    .collection('transaksi')
                    .document('jualsampah')
                    .collection(user.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? Text('Please wait')
                      : ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot transaksi =
                                snapshot.data.documents[index];
                            return ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Rp. ' +
                                    transaksi['jualsampah'].toString(),
                                  ),
                                  Text(
                                    transaksi['time'].toString(),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                },
              ),
            )
          : Loading(),
    );
  }
}
