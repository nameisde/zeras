import 'package:flutter/material.dart';
import 'package:zeras/model/user/homepage/textstylehome_model.dart';

class PusatBantuanHomePageModel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 20.0, bottom: 30.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextStyleHomeModel(title: 'Pusat Bantuan'),
              InkWell(
                  onTap: () {},
                  child: Container(
                      child: Image.asset('assets/images/pusat-bantuan.png',
                          cacheWidth: 100),
                      height: 100.0,
                      width: 125.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xff216353).withOpacity(0.3),
                                offset: Offset(0.0, 4.0),
                                blurRadius: 20.0,
                                spreadRadius: 1.0)
                          ],
                          color: Colors.white)))
            ]));
  }
}
