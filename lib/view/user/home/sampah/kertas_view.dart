import 'package:flutter/material.dart';
import 'package:zeras/model/user/homepage/pilihsampah_model.dart';

class KertasView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff216353), title: Text('Jual Kertas')),
      body: PilihSampahModel(
        namasampah: 'Kertas',
        image:
            Image.asset('assets/images/kertas-original.png', cacheHeight: 160),
      ),
    );
  }
}
