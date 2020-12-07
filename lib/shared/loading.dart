import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xffF6F6FB),
        child: Center(
            child:
                SpinKitWanderingCubes(color: Color(0xff216353), size: 50.0)));
  }
}
