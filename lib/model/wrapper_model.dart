import 'package:flutter/material.dart';

class WrapperFormModel extends StatelessWidget {
  final bool obscureText;
  final String hintText;
  final String labelText;
  final Function validator;
  final Function onSaved;
  final TextInputType keyboardType;
  WrapperFormModel(
      {this.obscureText,
      this.labelText,
      this.hintText,
      this.validator,
      this.onSaved,
      this.keyboardType});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 7.0),
        child: TextFormField(
            obscureText: obscureText,
            keyboardType: keyboardType,
            onSaved: onSaved,
            validator: validator,
            autofocus: false,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: labelText,
                hintText: hintText,
                labelStyle: TextStyle(color: Color(0xff216353), fontSize: 15.0),
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)))));
  }
}

class WrapperTextModel extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  WrapperTextModel({this.text, this.fontSize, this.fontWeight});
  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: TextStyle(
                    color: Color(0xff216353),
                    fontSize: fontSize,
                    fontWeight: fontWeight),
                children: [new TextSpan(text: text)])));
  }
}

class WrapperButtonModel extends StatelessWidget {
  final String authmode;
  final double height;
  final double width;
  final Function onPressed;
  WrapperButtonModel({this.authmode, this.onPressed, this.height, this.width});
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50.0,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40),
        child: RaisedButton(
            onPressed: onPressed,
            color: Color(0xff216353),
            child: Text(authmode,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0))));
  }
}

class WrapperTextSpanModel extends StatelessWidget {
  final String authmodelogin;
  final String authmoderegister;
  final Function onTap;
  final TextStyle textstyle;
  WrapperTextSpanModel(
      {this.authmodelogin, this.authmoderegister, this.onTap, this.textstyle});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: RichText(
          text: TextSpan(
              style: TextStyle(color: Color(0xff216353), fontSize: 13.0),
              children: <TextSpan>[
            new TextSpan(text: authmodelogin),
            new TextSpan(text: authmoderegister, style: textstyle),
          ])),
      onTap: onTap,
    );
  }
}

class WrapperImageModel extends StatelessWidget {
  final Widget child;
  WrapperImageModel({this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
    );
  }
}
