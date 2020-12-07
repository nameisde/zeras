import 'package:flutter/material.dart';
import 'package:zeras/view/auth/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:zeras/service/rolecheck.dart';
import 'package:zeras/service/authservice.dart';

void main() => runApp(
    ChangeNotifierProvider(create: (_) => AuthService(), child: MyApp()));

class MyApp extends StatelessWidget {
  final FirebaseUser currentUser;

  const MyApp({Key key, this.currentUser}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Zeras',
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
            future: Provider.of<AuthService>(context).getUser(),
            builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.error != null) {
                  print("Terdapat error");
                  return Text(snapshot.error.toString());
                }
                print(snapshot.hasData);
                return snapshot.hasData ? RoleCheck() : Wrapper();
              } else {
                return Center(child: Container(alignment: Alignment(0.0, 0.0)));
              }
            }));
  }
}
