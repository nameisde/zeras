import 'package:flutter/material.dart';
import 'package:zeras/model/user/promo/promo_model.dart';

class BannerHadiahView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Color(0xff216353), title: Text('Cashback')),
      body: Column(
        children: <Widget>[
          PromoModel(
            image: Image.asset('assets/images/banner-hadiah-view.png',
                cacheWidth: 360),
            infopromo: 'Info Hadiah',
            ketpromo:
                'Siapa yang mau Hadiah?, Sekarang ZERAS lagi bagi-bagi Hadiah loh. Silahkan baca syarat dan ketentuan yang berlaku.',
            infosyarat: 'Syarat dan Ketentuan',
            ketsyarat:
                'Hadiah hanya diberikan untuk pengguna baru ZERAS, untuk transaksi pertama kali di dalam aplikasi maka pengguna baru akan mendapatkan hadiah.',
          )
        ],
      ),
    );
  }
}
