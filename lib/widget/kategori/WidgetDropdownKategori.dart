import 'dart:convert';

import 'package:apps/Api/Api.dart';
import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/models/SubKategoriM.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetDropDownKategori extends StatefulWidget {
  WidgetDropDownKategori({Key key}) : super(key: key);

  @override
  _WidgetDropDownKategoriState createState() {
    return _WidgetDropDownKategoriState();
  }
}

class _WidgetDropDownKategoriState extends State<WidgetDropDownKategori> {
  @override
  void initState() {
    super.initState();
//    _getAllKategori();
  }

//  void _getAllKategori() async {
//    String token = await LocalStorage.sharedInstance.readValue('token');
//    Api.getAllKategori(token).then((value) {
//      Provider.of<DataProvider>(context).setSelectedKategori(null);
//      Provider.of<DataProvider>(context).setSelectedSubKategori(null);
//      Provider.of<DataProvider>(context).setDataSubKategori([]);
//      Iterable list = json.decode(value.body)['data'];
//      Provider.of<DataProvider>(context).setDataKategori(list.map((e) => KategoriM.fromMap(e)).toList());
//    });
//  }

  void getSubKategoriByIdKatgori(newValue) async {
    String tokenValid = await LocalStorage.sharedInstance.readValue('token');
    Api.getAllSubKategoriByIdKategori(tokenValid, newValue).then((response) {
      Iterable list = json.decode(response.body)['data'];
      Provider.of<DataProvider>(context).setDataSubKategori(list.map((e) => SubKategoriM.fromMap(e)).toList());
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    // TODO: implement build
    print(dataProvider.getSelectedKategori);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width - 10,
          child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffb16a085),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffb16a085),
                  ),
                ),
              ),
              isDense: true,
              validator: (String arg) {
                if (arg == null)
                  return 'Jenis Penyedia jasa';
                else
                  return null;
              },
              hint: new Text(
                "Jenis Penyedia jasa",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              value: dataProvider.getSelectedKategori,
              onChanged: (String newValue) {
                dataProvider.setSelectedKategori(newValue);
                getSubKategoriByIdKatgori(newValue);
                Provider.of<DataProvider>(context).setSelectedSubKategori(null);
              },
              items: dataProvider.getDataKategori
                  .map((kategori) => DropdownMenuItem<String>(
                value: kategori.kategoriId.toString(),
                        child: new Text(
                          kategori.kategoriNama.toString(),
                          style: TextStyle(fontSize: 12),
                        ),
                      ))
                  .toList()),
        ),
      ],
    );
  }
}
