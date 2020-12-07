import 'package:flutter/material.dart';
import 'package:zeras/model/user/homepage/pilihsampah_model.dart';

class BotolView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff216353), title: Text('Jual Botol')),
      body: PilihSampahModel(
        namasampah: 'Botol',
        image:
            Image.asset('assets/images/botol-original.png', cacheHeight: 160),
      ),
    );
  }
}
