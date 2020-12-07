import 'package:flutter/material.dart';
import 'package:zeras/shared/textstyle.dart';

class KeuntunganView extends StatefulWidget {
  @override
  _KeuntunganViewState createState() => _KeuntunganViewState();
}

class _KeuntunganViewState extends State<KeuntunganView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff216353),
        title: Text('Keuntungan Pakai Zeras'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 15.0),
          child: Column(
            children: <Widget>[
              KeuntunganViewModel(
                  textop: 'Tarik Saldo Lebih Mudah',
                  image: Image.asset('assets/images/tarik-saldo.png',
                      cacheWidth: 150, cacheHeight: 100),
                  textbtm:
                      'Tarik saldo dari ZERAS gratis dan banyak banget opsi untuk pemilihan dompet digital.'),
              KeuntunganViewModel(
                  textop: 'Bebas Transfer Ke Mana Aja',
                  image: Image.asset('assets/images/transfer.png',
                      cacheWidth: 150, cacheHeight: 100),
                  textbtm:
                      'Transfer mudah dan gratis ke semua dompet digital yang tersedia '),
              KeuntunganViewModel(
                  textop: 'Membantu Bumi Menjadi Asri',
                  image: Image.asset('assets/images/reboisasi.png',
                      cacheWidth: 150, cacheHeight: 100),
                  textbtm:
                      'Dengan menjual sampah di ZERAS, maka Anda telah membantu mengurangi sampah'),
            ],
          ),
        ),
      ),
    );
  }
}

class KeuntunganViewModel extends StatelessWidget {
  final String textop;
  final String textbtm;
  final Image image;
  KeuntunganViewModel({this.textop, this.textbtm, this.image});
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  color: Color(0xff216353).withOpacity(0.1),
                  offset: Offset(0.0, 4.0),
                  blurRadius: 20.0,
                  spreadRadius: 1.0)
            ],
            color: Colors.white),
        height: 230.0,
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(textop, style: styleSizeColor(15.0, Colors.black)),
              Container(child: image),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(textbtm,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey, fontSize: 13.0, height: 1.5)),
              )
            ]));
  }
}
