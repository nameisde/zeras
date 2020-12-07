import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class PanduanProfileView extends StatefulWidget {
  @override
  _PanduanProfileViewState createState() => _PanduanProfileViewState();
}

class _PanduanProfileViewState extends State<PanduanProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xff216353), title: Text('Panduan Zeras')),
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
  Entry('Cara Ubah Profile?', <Entry>[
    Entry(
        '1. Klik menu Akun\n2. Pilih Ubah Profile\n3. Isi semua form dan klik Update Profile ')
  ]),
  Entry('Cara Upload Foto', <Entry>[
    Entry(
        '1. Klik menu Akun\n2. Klik Circle Avatar\n3. Pilih Photo Dari Gallery\n4. Klik Upload Photo')
  ]),
  Entry('Cara Jual Sampah?', <Entry>[
    Entry(
        '1. Pilih Sampah Yang Ingin Dijual\n2. Tentukan Berat Sampah\n3. Klik Jual Sampah')
  ]),
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
