import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:zeras/model/user/chat/chat_model.dart';
import 'package:zeras/view/user/chat/user_profile.dart';

// ignore: must_be_immutable
class ChatAdminView extends StatefulWidget {
  var uid;
  ChatAdminView(this.uid);

  @override
  _ChatAdminViewState createState() => _ChatAdminViewState();
}

class _ChatAdminViewState extends State<ChatAdminView> {
  var firebaseMessageRoot;
  var messageController = TextEditingController();
  var messageList = [];
  var scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // initUser();
    if (widget.uid == 'group') {
      firebaseMessageRoot = 'group';
    } else {
      if (UserProfile.currentUser.compareTo(widget.uid.toString()) >= 0) {
        firebaseMessageRoot =
            UserProfile.currentUser + '-' + widget.uid.toString();
      } else {
        firebaseMessageRoot =
            widget.uid.toString() + '-' + UserProfile.currentUser;
      }
    }

    _refreshMessageList();
    FirebaseDatabase.instance
        .reference()
        .child('message/' + firebaseMessageRoot)
        .onChildAdded
        .listen((event) {
      _refreshMessageList();
    });

    print('current uid' + UserProfile.currentUser);
  }

  void _refreshMessageList() {
    FirebaseDatabase.instance
        .reference()
        .child('message/' + firebaseMessageRoot)
        .once()
        .then((ds) {
      print(ds.value);
      var tmpList = [];
      ds.value.forEach((k, v) {
        //v['image'] ='yoururlimage';
        tmpList.add(v);
      });
      tmpList.sort((a, b) => a['timestamp'].compareTo(b['timestamp']));
      messageList = tmpList;
      setState(() {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
    }).catchError((error) {
      print('failed to load the message');
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
            child: Column(children: <Widget>[
          Expanded(
            child: ListView.builder(
                controller: scrollController,
                itemCount: messageList.length,
                itemBuilder: (BuildContext context, int index) {
                  return messageList[index]['useruid'] ==
                          UserProfile.currentUser
                      ? ChatModel(
                          circleavataruser: Text(''),
                          circleavataradmin:
                              CircleAvatar(backgroundColor: Color(0xff216353)),
                          indextext: messageList[index]['text'],
                          indextimemessage: messageList[index]['timemessage'],
                          mainaxis: MainAxisAlignment.end,
                          crossaxis: CrossAxisAlignment.end,
                        )
                      : ChatModel(
                          circleavataruser: Text(''),
                          circleavataradmin: Text(''),
                          indextext: messageList[index]['text'],
                          indextimemessage: messageList[index]['timemessage'],
                          mainaxis: MainAxisAlignment.start,
                          crossaxis: CrossAxisAlignment.start,
                        );
                }),
          ),
          ChatModelTexField(
              controller: messageController,
              onPressed: () async {
                var timemessage = DateFormat.jm().format(new DateTime.now());
                var timestamp = DateTime.now().millisecondsSinceEpoch;
                var messageRecord = {
                  'text': messageController.text,
                  'timestamp': timestamp,
                  'useruid': UserProfile.currentUser,
                  'timemessage': timemessage,
                };
                FirebaseDatabase.instance
                    .reference()
                    .child('message/' +
                        firebaseMessageRoot +
                        "/" +
                        timestamp.toString())
                    .set(messageRecord)
                    .then((value) {
                  messageController.text = '';
                  print('Added the message');
                }).catchError((error) {
                  messageController.text = '';
                  print('Failed to add the message');
                });
              })
        ])));
  }
}
