import 'package:flutter/material.dart';

class UbahProfileModel extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String alamat;
  final String textjudul;
  final String hintText;
  final String labelText;
  final Function validator;
  final Function onChanged;

  UbahProfileModel({
    this.firstName,
    this.lastName,
    this.email,
    this.alamat,
    this.password,
    this.textjudul,
    this.labelText,
    this.hintText,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        child: Column(children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[Text(textjudul)]),
          TextFormField(
              onChanged: onChanged,
              validator: validator,
              autofocus: false,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: labelText,
                  hintText: hintText,
                  labelStyle: TextStyle(
                      color: Color(0xff216353),
                      fontFamily: 'Poppins',
                      fontSize: 15),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white))))
        ]));
  }
}
