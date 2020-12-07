import 'package:flutter/material.dart';

class ChatModel extends StatelessWidget {
  final String indextext;
  final String indextimemessage;
  final CrossAxisAlignment crossaxis;
  final MainAxisAlignment mainaxis;
  final Widget circleavataruser;
  final Widget circleavataradmin;
  ChatModel(
      {this.indextext,
      this.indextimemessage,
      this.crossaxis,
      this.mainaxis,
      this.circleavataruser, this.circleavataradmin});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Row(mainAxisAlignment: mainaxis, children: <Widget>[
          Column(crossAxisAlignment: crossaxis, children: <Widget>[
            Row(crossAxisAlignment: crossaxis, children: <Widget>[
              circleavataruser,
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Color(0xff216353),
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Text(indextext, style: TextStyle(color: Colors.white)))
            ]),
            Text(indextimemessage)
          ]),
          circleavataradmin
        ]));
  }
}

class ChatModelTexField extends StatelessWidget {
  final TextEditingController controller;
  final Function onPressed;
  ChatModelTexField({this.controller, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: TextField(
                controller: controller,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    prefixIcon: Icon(Icons.keyboard),
                    labelText: 'Type your message here'))),
        IconButton(
            icon: Icon(Icons.send, color: Color(0xff216353)),
            onPressed: onPressed)
      ],
    );
  }
}
