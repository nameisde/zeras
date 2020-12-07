import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zeras/shared/loading.dart';

class TransaksiTarikSaldo extends StatefulWidget {
  @override
  _TransaksiTarikSaldoState createState() => _TransaksiTarikSaldoState();
}

class _TransaksiTarikSaldoState extends State<TransaksiTarikSaldo> {
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
          AppBar(backgroundColor: Color(0xff216353), title: Text('Tarik Saldo')),
      body: user != null
          ? Container(
              child: StreamBuilder(
                stream: Firestore.instance
                    .collection('transaksi')
                    .document('tariksaldo')
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Rp. ' +
                                    transaksi['tariksaldo'].toString(),
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
