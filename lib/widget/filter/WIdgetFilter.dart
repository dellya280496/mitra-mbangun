import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'WidgetFilterLokasi.dart';

class WidgetFilter extends StatelessWidget {
  WidgetFilter({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.clear,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [WidgetFilterLokasi()],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          BlocProfile blocProfile = Provider.of<BlocProfile>(context);
          LocalStorage.sharedInstance.writeValue(key: 'idProvinsi', value: blocProfile.id_provice);
          LocalStorage.sharedInstance.writeValue(key: 'idKota', value: blocProfile.id_city == null ? 'null' : blocProfile.id_city);
          LocalStorage.sharedInstance.writeValue(key: 'idKecamatan', value: blocProfile.id_subdistrict == null ? 'null' : blocProfile.id_subdistrict);
          print('simpan');
          Navigator.pop(context);
        },
        backgroundColor: Color(0xffb16a085),
        tooltip: 'Filter',
        icon: Icon(Icons.done_all),
        label: Text("Terapkan", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, letterSpacing: 1)),
      ),
    );
  }
}
