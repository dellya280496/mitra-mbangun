import 'package:apps/widget/kategori/WidgetKategoriVertical.dart';
import 'package:flutter/material.dart';

class KategoriScreen extends StatelessWidget {
  KategoriScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Semua Kategori'),
      ),
      body: WidgetKategoriVertical(),
    );
  }
}
