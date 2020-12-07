import 'package:flutter/material.dart';
import 'package:zeras/view/user/home/header/transaksi/transaksi_jualsampah.dart';
import 'package:zeras/view/user/home/header/transaksi/transaksi_tariksaldo.dart';

class TransaksiHeaderView extends StatefulWidget {
  @override
  _TransaksiHeaderViewState createState() => _TransaksiHeaderViewState();
}

class _TransaksiHeaderViewState extends State<TransaksiHeaderView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff216353),
        title: Text('Transaksi'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
        child: Column(
          children: <Widget>[
            InkWell(
                onTap: () {
                  Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TransaksiJualSampah()));
                },
                child: Image.asset(
                  'assets/images/banner-jual-sampah.png',
                  cacheWidth: 400,
                )),
            SizedBox(height: 20.0),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TransaksiTarikSaldo()));
                },
                child: Image.asset(
                  'assets/images/banner-tarik-saldo.png',
                  cacheWidth: 400,
                )),
          ],
        ),
      ),
    );
  }
}
