import 'package:flutter/material.dart';
import 'package:zeras/model/user/promo/promo_model.dart';

class BannerCashBackView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Color(0xff216353), title: Text('Cashback')),
      body: Column(
        children: <Widget>[
          PromoModel(
            image: Image.asset('assets/images/banner-cashback-view.png',
                cacheWidth: 360),
            infopromo: 'Info Cash Back',
            ketpromo:
                'Siapa yang mau cashback 20%?, Sekarang ZERAS lagi bagi-bagi cashback loh. Silahkan baca syarat dan ketentuan yang berlaku.',
            infosyarat: 'Syarat dan Ketentuan',
            ketsyarat: 'Promo Cashback hanya berlaku untuk pengguna baru ZERAS, untuk transaksi pertama kali di dalam aplikasi.',
          )
        ],
      ),
    );
  }
}
