import 'package:flutter/material.dart';
import 'package:zeras/model/user/homepage/textstylehome_model.dart';
import 'package:zeras/view/user/home/infopromo/banner/bannercashback_view.dart';
import 'package:zeras/view/user/home/infopromo/banner/bannerhadiah_view.dart';
import 'package:zeras/view/user/home/infopromo/banner/bannerjadwal_view.dart';

class InfoPromoHomePageModel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextStyleHomeModel(title: 'Info dan Promo Spesial'),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: <Widget>[
                  InfoAndPromoBanner(
                      image: Image.asset('assets/images/banner-cashback.png',
                          cacheWidth: 300),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BannerCashBackView()));
                      }),
                  SizedBox(width: 10.0),
                  InfoAndPromoBanner(
                      image: Image.asset('assets/images/banner-hadiah.png',
                          cacheWidth: 300),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BannerHadiahView()));
                      }),
                  SizedBox(width: 10.0),
                  InfoAndPromoBanner(
                      image: Image.asset('assets/images/banner-jadwal.png',
                          cacheWidth: 300),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BannerJadwalView()));
                      }),
                ]),
              )
            ]));
  }
}

class InfoAndPromoBanner extends StatelessWidget {
  final Image image;
  final Function onTap;
  InfoAndPromoBanner({this.image, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Material(child: InkWell(onTap: onTap, child: image))
    ]);
  }
}
