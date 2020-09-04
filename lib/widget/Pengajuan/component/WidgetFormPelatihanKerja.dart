import 'dart:convert';
import 'dart:io';

import 'package:apps/Api/Api.dart';
import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/models/KecamatanM.dart';
import 'package:apps/models/KotaM.dart';
import 'package:apps/models/ProvinsiM.dart';
import 'package:apps/models/jenis_pengajuan.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class WidgetFormPelatihanKerja extends StatefulWidget {
  WidgetFormPelatihanKerja({Key key}) : super(key: key);

  @override
  _WidgetFormPelatihanKerjaState createState() {
    return _WidgetFormPelatihanKerjaState();
  }
}

class _WidgetFormPelatihanKerjaState extends State<WidgetFormPelatihanKerja> {
  var dataJenisPengajuan = new List<JenisPengajuan>();
  String idSubKategori;
  bool _saving = false;
  String idKota;
  String idProvinsi;
  String idKecamatan;
  String namaProvinsi, namaKota, namaKecamatan;
  var dataKota = List<KotaM>();
  var dataProvinsi = List<ProvinsiM>();
  var dataKecamatan = List<KecamatanM>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String jenispengajuanid;

  final FocusNode myFocusNodeUniversitas = FocusNode();
  TextEditingController universitasController = new TextEditingController();

  final FocusNode myFocusNodeFakultas = FocusNode();
  TextEditingController fakultasController = new TextEditingController();

  final FocusNode myFocusNodeJurusan = FocusNode();
  TextEditingController jurusanController = new TextEditingController();

  final FocusNode myFocusNodeAlamat = FocusNode();
  TextEditingController alamatController = new TextEditingController();

  @override
  File produkthumbnail;
  File produkfoto1;
  File produkfoto2;
  File produkfoto3;
  File produkfoto4;

  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
      key: _formKey,
      autovalidate: false,
      child: Container(
        height: MediaQuery.of(context).size.height - 200,
        child: ModalProgressHUD(
          inAsyncCall: _saving,
          child: Column(
            children: [
              Expanded(child: _buildFormPelatihanKerja()),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  child: Text("Kirim Formulir"),
                  color: Color(0xffb16a085),
                  textColor: Colors.white,
                  padding: EdgeInsets.only(left: 11, right: 11, top: 15, bottom: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  onPressed: () {
                    simpanData();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormPelatihanKerja() {
    return Column(
      children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new TextFormField(
              focusNode: myFocusNodeUniversitas,
              controller: universitasController,
              validator: (String arg) {
                if (arg.length < 1)
                  return 'Harus di isi';
                else
                  return null;
              },
              decoration: const InputDecoration(
                  labelText: "Universitas",
                  hintText: 'Universitas',
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
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new TextFormField(
              focusNode: myFocusNodeFakultas,
              controller: fakultasController,
              validator: (String arg) {
                if (arg.length < 1)
                  return 'Harus di isi';
                else
                  return null;
              },
              decoration: const InputDecoration(
                  labelText: "Fakultas",
                  hintText: 'Fakultas',
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
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new TextFormField(
              focusNode: myFocusNodeJurusan,
              controller: jurusanController,
              validator: (String arg) {
                if (arg.length < 1)
                  return 'Harus di isi';
                else
                  return null;
              },
              decoration: const InputDecoration(
                  labelText: "Jurusan",
                  hintText: 'Jurusan',
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
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new TextFormField(
              focusNode: myFocusNodeAlamat,
              controller: alamatController,
              validator: (String arg) {
                if (arg.length < 1)
                  return 'Harus di isi';
                else
                  return null;
              },
              decoration: const InputDecoration(
                  labelText: "Alamat",
                  hintText: 'Alamat',
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
          ),
        ),
      ],
    );
  }

  void simpanData() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _saving = true;
      });
      String dataSession = await LocalStorage.sharedInstance.readValue('session');
      String token = await LocalStorage.sharedInstance.readValue('token');
      var userId = json.decode(dataSession)['data']['data_user']['userid'];
      var map = new Map<String, dynamic>();
      map['pkuniversitas'] = universitasController.text;
      map['pkfakultas'] = fakultasController.text;
      map['pkjurusan'] = jurusanController.text;
      map['pkalamat'] = alamatController.text;
      map['userid'] = userId;
      Api.insertPelatihanKerja(token, map).then((value) {
        var result = json.decode(value.body);
        if (result['status'] == true) {
          setState(() {
            _saving = false;
          });
          Navigator.pop(context);
          Flushbar(
            title: "Sukses",
            message: 'Pengajuan berhasil',
            duration: Duration(seconds: 5),
            backgroundColor: Colors.green,
            flushbarPosition: FlushbarPosition.TOP,
            icon: Icon(
              Icons.assignment_turned_in,
              color: Colors.white,
            ),
          )..show(context);
        } else {
          setState(() {
            _saving = false;
          });
          Flushbar(
            title: "Gagal",
            message: 'Periksa koneksi internet anda',
            duration: Duration(seconds: 5),
            backgroundColor: Colors.red,
            flushbarPosition: FlushbarPosition.TOP,
            icon: Icon(
              Icons.assignment_turned_in,
              color: Colors.white,
            ),
          )..show(context);
        }
      });
    }
  }
}
