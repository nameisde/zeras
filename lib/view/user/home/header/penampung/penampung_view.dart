import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zeras/Shared/loading.dart';

class PenampungHeaderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff216353),
          title: Text('Penampung'),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 30.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection("users")
                .where('role', isEqualTo: 'admin')
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> querySnapshot) {
              if (querySnapshot.hasError) {
                return Text('Something error');
              }
              if (querySnapshot.connectionState == ConnectionState.waiting) {
                return Loading();
              } else {
                final list = querySnapshot.data.documents;
                return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 0.0),
                              child: ListTile(
                                  onTap: () {},
                                  leading: CircleAvatar(
                                      backgroundColor: Color(0xff216353),
                                      child: ClipOval(
                                          child: Image.network(
                                              list[index]['photoUrl']))),
                                  title: Text(list[index]['firstname'] +
                                      ' ' +
                                      list[index]['lastname']),
                                  subtitle: Text(list[index]['alamat']))),
                        ],
                      );
                    });
              }
            },
          ),
        ));
  }
}
