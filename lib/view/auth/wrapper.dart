import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeras/service/authservice.dart';
import 'package:zeras/shared/loading.dart';
import 'package:zeras/model/wrapper_model.dart';
import 'package:zeras/shared/validator.dart';

enum AuthMode { LOGIN, SIGNUP }

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool loading = false;

  final _formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  String _firstName;
  String _lastName;

  AuthMode _authMode = AuthMode.LOGIN;

  @override
  Widget build(BuildContext context) {
    //Images
    final image = Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: WrapperImageModel(
            child: _authMode == AuthMode.LOGIN
                ? Image.asset('assets/images/signin.png',
                    height: 150.0, width: 150.0)
                : Image.asset('assets/images/signup.png',
                    height: 170.0, width: 170.0)));

    //Text Span Body
    final textbody = Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: WrapperTextModel(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            text: _authMode == AuthMode.LOGIN
                ? "Selamat Datang"
                : "Registrasi Akun"));

    //Text Span Subtitle
    final textsubtitle = Container(
        margin: EdgeInsets.only(bottom: 15.0),
        child: WrapperTextModel(
            fontSize: 13.0,
            text: _authMode == AuthMode.LOGIN
                ? "Untuk dapat menggunakan aplikasi,\n silahkan lakukan Login"
                : "Untuk dapat menggunakan aplikasi,\n silahkan lakukan Registrasi"));

    //Form FirstName
    final firstName = WrapperFormModel(
        obscureText: false,
        validator: Validator.validateName,
        onSaved: (value) => _firstName = value,
        keyboardType: TextInputType.text,
        labelText: 'First Name');

    //Form LastName
    final lastName = WrapperFormModel(
        obscureText: false,
        validator: Validator.validateName,
        onSaved: (value) => _lastName = value,
        keyboardType: TextInputType.text,
        labelText: 'Last Name');

    //Form Email
    final email = WrapperFormModel(
        obscureText: false,
        validator: Validator.validateEmail,
        onSaved: (value) => _email = value,
        keyboardType: TextInputType.emailAddress,
        labelText: 'Email Address');

    //Form Password
    final password = Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: WrapperFormModel(
            obscureText: true,
            validator: Validator.validatePassword,
            onSaved: (value) => _password = value,
            keyboardType: TextInputType.visiblePassword,
            labelText: 'Password'));

    //Button Login
    final login = Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: WrapperButtonModel(
            authmode: _authMode == AuthMode.LOGIN ? "Masuk" : "Daftar",
            onPressed: () async {
              final form = _formKey.currentState;
              form.save();
              if (form.validate()) {
                setState(() => loading = true);
                if (_authMode == AuthMode.LOGIN) {
                  try {
                    FirebaseUser result =
                        await Provider.of<AuthService>(context, listen: false)
                            .loginUser(email: _email, password: _password);
                    print(result);
                  } catch (e) {
                    setState(() => loading = false);
                    String exception = AuthService.getExceptionText(e);
                    Flushbar(
                        title: 'Sign In Error',
                        message: exception,
                        icon: Icon(EvaIcons.alertCircleOutline,
                            color: Colors.white),
                        duration: Duration(seconds: 3))
                      ..show(context);
                  }
                } else {
                  setState(() => loading = true);
                  await Provider.of<AuthService>(context, listen: false)
                      .createUser(
                          firstName: _firstName,
                          lastName: _lastName,
                          email: _email,
                          password: _password);
                }
              }
            }));

    //Text Span Auth
    final authSwitch = Center(
        child: Container(
            margin: EdgeInsets.only(bottom: 20.0),
            child: WrapperTextSpanModel(
                authmodelogin: _authMode == AuthMode.LOGIN
                    ? "Belum punya akun ?"
                    : "Sudah punya akun",
                authmoderegister: _authMode == AuthMode.SIGNUP
                    ? "  Masuk disini"
                    : "  Daftar disini",
                textstyle: TextStyle(fontWeight: FontWeight.bold),
                onTap: () {
                  setState(() {
                    _authMode != AuthMode.LOGIN
                        ? _authMode = AuthMode.LOGIN
                        : _authMode = AuthMode.SIGNUP;
                  });
                })));

    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: true,
            resizeToAvoidBottomPadding: false,
            backgroundColor: Color(0xffF6F6FB),
            body: Container(
                child: Center(
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Form(
                            key: _formKey,
                            child: ListView(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children: <Widget>[
                                  image,
                                  textbody,
                                  textsubtitle,
                                  if (_authMode == AuthMode.SIGNUP) firstName,
                                  if (_authMode == AuthMode.SIGNUP) lastName,
                                  email,
                                  password,
                                  login,
                                  authSwitch
                                ]))))));
  }
}
