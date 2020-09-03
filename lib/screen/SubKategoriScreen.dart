import 'package:apps/providers/DataProvider.dart';
import 'package:apps/widget/SubKategori/WidgetSubKategori.dart';
import 'package:flutter/material.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';

class SubKategoriScreen extends StatelessWidget {
  final String namaKategori;
  final String flag;

  SubKategoriScreen({Key key, this.namaKategori, this.flag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(this.namaKategori),
      ),
      body: dataProvider.isLoading
          ? SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: PKCardListSkeleton(),
              ),
            )
          : WidgetSubKategori(
              flag: this.flag,
            ),
    );
  }
}
