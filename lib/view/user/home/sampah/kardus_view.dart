import 'package:flutter/material.dart';
import 'package:zeras/model/user/homepage/pilihsampah_model.dart';

class KardusView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff216353), title: Text('Jual Kardus')),
      body: PilihSampahModel(
        namasampah: 'Kardus',
        image:
            Image.asset('assets/images/kardus-original.png', cacheHeight: 160),
      ),
    );
  }
}
