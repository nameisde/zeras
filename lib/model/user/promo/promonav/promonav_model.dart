import 'package:flutter/material.dart';
import 'package:zeras/model/user/promo/promohome/promohome_model.dart';
import 'package:zeras/view/user/home/infopromo/banner/bannercashback_view.dart';
import 'package:zeras/view/user/home/infopromo/banner/bannerhadiah_view.dart';
import 'package:zeras/view/user/home/infopromo/banner/bannerjadwal_view.dart';

class PromoNavModel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
            child: Center(
                child: Container(
                    child: Column(children: <Widget>[
      PromoHomeModel(
          onTap: () {Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BannerJadwalView()));}, image: Image.asset('assets/images/banner-jadwal.png')),
      PromoHomeModel(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BannerCashBackView()));
          },
          image: Image.asset('assets/images/banner-cashback.png')),
      PromoHomeModel(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BannerHadiahView()));
          },
          image: Image.asset('assets/images/banner-hadiah.png'))
    ])))));
  }
}
