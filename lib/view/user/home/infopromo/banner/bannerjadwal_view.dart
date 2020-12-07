import 'package:flutter/material.dart';
import 'package:zeras/model/user/promo/promo_model.dart';

class BannerJadwalView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Color(0xff216353), title: Text('Cashback')),
      body: Column(
        children: <Widget>[
          PromoModel(
            image: Image.asset('assets/images/banner-jadwal-view.png',
                cacheWidth: 360),
            infopromo: 'Info Jadwal Operasional',
            ketpromo:
                'Jadwal operasional normal ZERAS senin - jumat pukul 10.00 - 15.00, hari sabtu dan minggu libur.',
            infosyarat: 'Butuh Bantuan ?',
            ketsyarat:
                'Apabila Anda mengalami kesulitan dalam menggunakan aplikasi, silahkan menghubungi admin pada bagian navigasi chat yang sudah disediakan dibagian bawah aplikasi.',
          )
        ],
      ),
    );
  }
}
