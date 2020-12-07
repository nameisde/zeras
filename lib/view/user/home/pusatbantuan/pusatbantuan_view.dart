import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class PusatBantuanView extends StatefulWidget {
  @override
  _PusatBantuanViewState createState() => _PusatBantuanViewState();
}

class _PusatBantuanViewState extends State<PusatBantuanView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xff216353), title: Text('Pusat Bantuan')),
        body: ListView.builder(
            itemBuilder: (BuildContext context, int index) =>
                EntryItem(data[index]),
            itemCount: data.length));
  }
}

// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

// The entire multilevel list displayed by this app.
final List<Entry> data = <Entry>[
  Entry('Apa itu aplikasi Zeras?', <Entry>[
    Entry(
        'Aplikasi Zeras adalah Aplikasi yang bergerak di bidang lingkungan untuk memudahkan pengguna menjual sampah menjadi uang.')
  ]),
  Entry('Ada apa saja di aplikasi Zeras?', <Entry>[
    Entry(
        'Saat ini fitur yang terdapat dalam layanan Zeras adalah Anda dapat menjual barang seperti kardus, kertas, dan botol.')
  ]),
  Entry('Apa yang dapat dilakukan setelah registrasi?', <Entry>[
    Entry(
        'Setelah melakukan registrasi, kamu dapat langsung menikmati layanan dan promo - promo menarik Zeras.')
  ]),
  Entry('Apa yang perlu diperhatikan saat registrasi?', <Entry>[
    Entry(
        'Kamu harus mengigat data yang diinput dan harus sesuai dengan data asli.')
  ]),
  Entry('Bagaimana cara mendapatkan aplikasi Zeras?', <Entry>[
    Entry(
        'Karena aplikasi ini masih dalam tahap perkembangan, aplikasi Zeras belum dapat diunduh di Apple App Store & Google Play Store.')
  ])
];

class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
        leading: Icon(EvaIcons.plusSquare),
        key: PageStorageKey<Entry>(root),
        title: Text(
          root.title,
          style: TextStyle(
            color: Color(0xff216353),
            fontFamily: 'Poppins',
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: root.children.map(_buildTiles).toList());
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
