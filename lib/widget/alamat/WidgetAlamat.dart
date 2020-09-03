import 'dart:convert';

import 'package:apps/Api/Api.dart';
import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/models/KecamatanM.dart';
import 'package:apps/models/KotaM.dart';
import 'package:apps/models/ProvinsiM.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetAlamat extends StatefulWidget {
  WidgetAlamat({Key key}) : super(key: key);

  @override
  _WidgetAlamatState createState() {
    return _WidgetAlamatState();
  }
}

class _WidgetAlamatState extends State<WidgetAlamat> {
  String idKota;
  String idProvinsi;
  String idKecamatan;
  String namaProvinsi, namaKota, namaKecamatan;
  var dataKota = List<KotaM>();
  var dataProvinsi = List<ProvinsiM>();
  var dataKecamatan = List<KecamatanM>();

  @override
  void initState() {
    super.initState();
    _getAllProvinsi();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getAllProvinsi() async {
    String token = await LocalStorage.sharedInstance.readValue('token');
    Provider.of<DataProvider>(context).setDataKota([]);
    Provider.of<DataProvider>(context).setDataKecamatan([]);
    Api.getAllProvinsi(token).then((value) {
      var result = json.decode(value.body);
      print(result);
      Iterable list = result['data'];
      Provider.of<DataProvider>(context).setDataProvinsi(list.map((model) => ProvinsiM.fromMap(model)).toList());
    });
  }

  void _onchangeProvinsi(String newValue) async {
    String token = await LocalStorage.sharedInstance.readValue('token');
    Api.getAllKotaByIdProvinsi(token, idProvinsi).then((value) {
      var result = json.decode(value.body);
      print(result);
      Iterable list = result['data'];
      Provider.of<DataProvider>(context).setDataKota(list.map((model) => KotaM.fromMap(model)).toList());
    });
  }

  void _onchangeKota(String newValue) async {
    String token = await LocalStorage.sharedInstance.readValue('token');
    Api.getAllKecamatanByIdKota(token, idKota).then((value) {
      var result = json.decode(value.body);
      Iterable list = result['data'];
      Provider.of<DataProvider>(context).setDataKecamatan(list.map((model) => KecamatanM.fromMap(model)).toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);

    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lokasi Pekerjaan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 10,
                child: DropdownButtonFormField<String>(
                  isDense: true,
                  hint: new Text(
                    "Pilih Provinsi",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  value: idProvinsi,
                  validator: (String arg) {
                    if (arg == null)
                      return 'Harus di isi';
                    else
                      return null;
                  },
                  onChanged: (String newValue) {
                    dataProvider.setSelectedKota(null);
                    setState(() {
                      idProvinsi = newValue;
                      dataKota = [];
                      idKota = null;
                    });
                    dataProvider.setSelectedProvinsi(newValue);
                    _onchangeProvinsi(newValue);
                  },
                  items: dataProvider.getDataProvinsi.map((ProvinsiM item) {
                    return new DropdownMenuItem<String>(
                      value: item.idPropinsi.toString(),
                      child: new Text(
                        item.namaPropinsi.toString(),
                        style: TextStyle(fontSize: 12),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 10,
                child: DropdownButtonFormField<String>(
                  isDense: true,
                  hint: new Text(
                    "Pilih Kota",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  value: idKota,
                  validator: (String arg) {
                    if (arg == null)
                      return 'Harus di isi';
                    else
                      return null;
                  },
                  onChanged: (String newValue) {
                    setState(() {
                      idKota = newValue;
                      dataKecamatan = [];
                      idKecamatan = null;
                    });
                    dataProvider.setSelectedKota(newValue);
                    _onchangeKota(newValue);
                  },
                  items: dataProvider.getDataKota.map((KotaM item) {
                    return new DropdownMenuItem<String>(
                      value: item.idKabkota.toString(),
                      child: new Text(
                        item.namaKabkota.toString(),
                        style: TextStyle(fontSize: 12),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 10,
                child: DropdownButtonFormField<String>(
                  isDense: true,
                  hint: new Text(
                    "Pilih Kecamatan",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  value: idKecamatan,
                  validator: (String arg) {
                    if (arg == null)
                      return 'Harus di isi';
                    else
                      return null;
                  },
                  onChanged: (String newValue) {
                    setState(() {
                      idKecamatan = newValue;
                    });
                    dataProvider.setSelectedKecamatan(newValue);
                  },
                  items: dataProvider.getDataKecamatan.map((KecamatanM item) {
                    return new DropdownMenuItem<String>(
                      value: item.idKecamatan.toString(),
                      child: new Text(
                        item.namaKecamatan.toString(),
                        style: TextStyle(fontSize: 12),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Container(
                height: 10,
              ),
              new TextFormField(
                validator: (String arg) {
                  if (arg.length < 1)
                    return 'Harus di isi';
                  else
                    return null;
                },
                onChanged: (value) {
//                  dataProvider.setKecamatan(null);
                  dataProvider.setAlamatLengkap(value);
//                  dataProvider.setSelectedKota(null);
//                  dataProvider.setSelectedProvinsi(null);
                },
                keyboardType: TextInputType.multiline,
                maxLines: 2,
                decoration: const InputDecoration(
                    hintText: 'Jl. Ir Soekarno no 1 A',
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
                    hasFloatingPlaceholder: true),
              ),
            ],
          ),
        )
      ],
    );
  }
}
