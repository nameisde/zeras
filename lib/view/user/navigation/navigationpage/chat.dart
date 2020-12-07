import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:zeras/Shared/loading.dart';
import 'package:zeras/view/user/chat/chatuser_view.dart';
import 'package:zeras/view/user/chat/user_profile.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
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
    setState(() {
      FirebaseAuth.instance.currentUser().then((value) {
        print(value);
        var uid = value.uid;
        UserProfile.currentUser = uid;
        print("current user info uid : " + uid);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff216353),
          title: Text('Chat'),
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
                  if (querySnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Loading();
                  } else {
                    final list = querySnapshot.data.documents;
                    return ListView.builder(
                        itemCount: querySnapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      'Daftar Kontak',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    )),
                                Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 20.0),
                                    child: ListTile(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChatUserView(list[index]['uid'])));
                                          //  FlutterOpenWhatsapp.sendSingleMessage("918179015345", "Hello");
                                        },
                                        leading: CircleAvatar(
                                            backgroundColor: Color(0xff216353),
                                            child: ClipOval(
                                                child: Image.network(
                                                    list[index]['photoUrl']))),
                                        trailing:
                                            Icon(EvaIcons.messageSquareOutline),
                                        title: Text(list[index]['firstname'] +
                                            ' ' +
                                            list[index]['lastname']),
                                        subtitle: Text(list[index]['alamat']))),
                              ]);
                        });
                  }
                })));
  }
}
