import 'package:flutter/material.dart';

class SizedBoxModel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 30.0),
        height: 5.0,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey.withOpacity(0.2),
      ),
    );
  }
}

class SizedBoxProfileModel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 5.0,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey.withOpacity(0.2),
      ),
    );
  }
}
