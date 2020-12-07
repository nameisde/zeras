import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeras/service/authservice.dart';

class Logout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(EvaIcons.logOutOutline),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Log Out'),
            content: Text('Are you sure, want to logout?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop('Cancel');
                },
                child: Text('Cancel'),
              ),
              FlatButton(
                onPressed: () async {
                  await Provider.of<AuthService>(context, listen: false)
                      .logout()
                      .then((value) {
                    Navigator.of(context).pop('Logout');
                  });
                },
                child: Text('Accept'),
              ),
            ],
          ),
        );
      },
    );
  }
}
