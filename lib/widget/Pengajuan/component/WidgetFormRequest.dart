import 'dart:convert';
import 'dart:io';

import 'package:apps/Api/Api.dart';
import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/models/KecamatanM.dart';
import 'package:apps/models/KotaM.dart';
import 'package:apps/models/ProvinsiM.dart';
import 'package:apps/models/SubKategoriM.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/widget/alamat/WidgetAlamat.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class WidgetFormRequest extends StatefulWidget {
  WidgetFormRequest({Key key}) : super(key: key);

  @override
  _WidgetFormRequestState createState() {
    return _WidgetFormRequestState();
  }
}

class _WidgetFormRequestState extends State<WidgetFormRequest> {
  var dataSubKategori = new List<SubKategoriM>();
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

  final FocusNode myFocusNodePanjang = FocusNode();
  TextEditingController panjangController = new TextEditingController();

  final FocusNode myFocusNodeLebar = FocusNode();
  TextEditingController lebarController = new TextEditingController();

  final FocusNode myFocusNodeTinggi = FocusNode();
  TextEditingController tinggiController = new TextEditingController();

  final FocusNode myFocusNodeBahan = FocusNode();
  TextEditingController bahanController = new TextEditingController();

  final FocusNode myFocusNodeJenisPekerjaan = FocusNode();
  TextEditingController jenisPekerjaanController = new TextEditingController();

  final FocusNode myFocusNodeBudget = FocusNode();
  TextEditingController budgetController = new TextEditingController();

  final FocusNode myFocusNodeNama = FocusNode();
  TextEditingController namaController = new TextEditingController();

  final FocusNode myFocusNodeAlamatLengkap = FocusNode();
  TextEditingController alamatLengkapController = new TextEditingController();

  final FocusNode myFocusNodeWaktuPengerjaan = FocusNode();
  TextEditingController waktuPengerjaanController = new TextEditingController();

  @override
  File produkthumbnail;
  File produkfoto1;
  File produkfoto2;
  File produkfoto3;
  File produkfoto4;

  void initState() {
    super.initState();
    getAllProvinsi();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getAllProvinsi() async {
    String tokenValid = await LocalStorage.sharedInstance.readValue('token');
    Api.getAllProvinsi(tokenValid).then((value) {
      var result = json.decode(value.body);
//      print(result);
      Iterable list = result['data'];
      setState(() {
        dataProvinsi = list.map((model) => ProvinsiM.fromMap(model)).toList();
      });
    });
  }

  void _openImagePickerModal(BuildContext context, param) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Pick an image',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                FlatButton(
                  textColor: Colors.red,
                  child: Text('Use Camera'),
                  onPressed: () {
                    _getImage(context, ImageSource.camera, param);
                  },
                ),
                FlatButton(
                  textColor: Colors.red,
                  child: Text('Use Gallery'),
                  onPressed: () {
                    _getImage(context, ImageSource.gallery, param);
                  },
                ),
              ],
            ),
          );
        });
  }

  void _getImage(BuildContext context, ImageSource source, param) async {
    File image = await ImagePicker.pickImage(source: source, maxHeight: 1000, maxWidth: 1000);
    if (param == 'produkthumbnail') {
      setState(() {
        produkthumbnail = image;
      });
    } else if (param == 'produkfoto1') {
      setState(() {
        produkfoto1 = image;
      });
    } else if (param == 'produkfoto2') {
      setState(() {
        produkfoto2 = image;
      });
    } else if (param == 'produkfoto3') {
      setState(() {
        produkfoto3 = image;
      });
    } else if (param == 'produkfoto4') {
      setState(() {
        produkfoto4 = image;
      });
    }
    Navigator.pop(context);
  }

  void simpanFormRqt() async {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    String dataSession = await LocalStorage.sharedInstance.readValue('session');
    var userId = json.decode(dataSession)['data']['data_user']['userid'];
    if (_formKey.currentState.validate() && produkthumbnail != null && produkfoto1 != null && produkfoto2 != null && produkfoto3 != null && produkfoto4 != null) {
      dataProvider.setLoading(true);
      var budget = budgetController.text.replaceAll('Rp', '');
      var saveBudget = budget.replaceAll(',', '');
      Api.pengajuanRqt(
              produkthumbnail,
              produkfoto1,
              produkfoto2,
              produkfoto3,
              produkfoto4,
              dataProvider.getSelectedProvinsi,
              dataProvider.getSelectedKota,
              dataProvider.getSelectedKecamatan,
              dataProvider.getAlamatLengkap,
              namaController.text,
              panjangController.text,
              lebarController.text,
              tinggiController.text,
              bahanController.text,
              waktuPengerjaanController.text,
              saveBudget,
              userId,
              dataProvider.getTokenData)
          .then((value) {
        print(value.body);
        var data = json.decode(value.body);
        if (data['status'] == true) {
          dataProvider.setLoading(false);
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
          dataProvider.setLoading(false);
          FocusScope.of(context).requestFocus(FocusNode());
          Flushbar(
            title: "Gagal",
            message: 'Periksa koneksi internet anda',
            duration: Duration(seconds: 5),
            backgroundColor: Colors.red,
            flushbarPosition: FlushbarPosition.TOP,
            icon: Icon(
              Icons.warning,
              color: Colors.white,
            ),
          )..show(context);
        }
      });
    } else {
      Flushbar(
        title: "Kesalahan",
        message: 'Silahkan lengkapi form yang sudah tersedia',
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        flushbarPosition: FlushbarPosition.TOP,
        icon: Icon(
          Icons.warning,
          color: Colors.white,
        ),
      )..show(context);
      setState(() {
        _saving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
      key: _formKey,
      autovalidate: false,
      child: Container(
          child: Column(
            children: [
              WidgetAlamat(),
              Container(
                height: 20,
              ),
              _buildFormRqt(),
            ],
          )),
    );
  }

  Widget _buildFormRqt() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Nama Pekerjaan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: new TextFormField(
            focusNode: myFocusNodeNama,
            controller: namaController,
            validator: (String arg) {
              if (arg.length < 1)
                return 'Harus di isi';
              else
                return null;
            },
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
                hintText: 'Pengajuan perbaikan rumah',
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
        Container(
          height: 10,
        ),
        Text(
          'Dimensi (cm)',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          height: 10,
        ),
        Row(
          children: <Widget>[
            Expanded(
              // width: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(
                  focusNode: myFocusNodePanjang,
                  controller: panjangController,
                  validator: (String arg) {
                    if (arg.length < 1)
                      return 'Harus di isi';
                    else
                      return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: "Panjang",
                      hintText: '50',
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
            Expanded(
              // width: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(
                  focusNode: myFocusNodeLebar,
                  controller: lebarController,
                  validator: (String arg) {
                    if (arg.length < 1)
                      return 'Harus di isi';
                    else
                      return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: "Lebar",
                      hintText: '20',
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
            Expanded(
              // width: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(
                  focusNode: myFocusNodeTinggi,
                  controller: tinggiController,
                  validator: (String arg) {
                    if (arg.length < 1)
                      return 'Harus di isi';
                    else
                      return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: "Tinggi",
                      hintText: '60',
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
        ),
        Container(
          height: 20,
        ),
        Text(
          'Deskripsi singkat dan bahan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new TextFormField(
              focusNode: myFocusNodeBahan,
              controller: bahanController,
              validator: (String arg) {
                if (arg.length < 1)
                  return 'Harus di isi';
                else
                  return null;
              },
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              decoration: const InputDecoration(
//                  labelText: "Deskripsi Singkat & Bahan",
                  hintText: 'Hanya perbaikan, \n\nbahan : Kayu, Besi, dll',
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
          height: 20,
        ),
        Text(
          'Budget',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new TextFormField(
              inputFormatters: [MoneyInputFormatter(useSymbolPadding: true, mantissaLength: 0, leadingSymbol: 'Rp')],
              focusNode: myFocusNodeBudget,
              controller: budgetController,
              validator: (String arg) {
                if (arg.length < 1)
                  return 'Harus di isi';
                else
                  return null;
              },
              textAlign: TextAlign.right,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: 'Rp 100,000',
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
          height: 20,
        ),
        Text(
          'Waktu Pengerjaan',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(
                  focusNode: myFocusNodeWaktuPengerjaan,
                  controller: waktuPengerjaanController,
                  validator: (String arg) {
                    if (arg.length < 1)
                      return 'Harus di isi';
                    else
                      return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: '15',
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
              width: MediaQuery.of(context).size.width * 0.1,
              child: Text('Hari'),
            )
          ],
        ),
        Container(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      'Foto Depan',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.grey),
                    ),
                    Container(
                      height: 20,
                    ),
                    produkthumbnail != null
                        ? Image.file(
                            produkthumbnail,
                            fit: BoxFit.fitHeight,
                            alignment: Alignment.topCenter,
                            width: 80,
                            height: 80,
                          )
                        : Container(),
                    Container(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: IconButton(
                        highlightColor: Colors.green,
                        icon: Icon(Icons.camera_alt),
                        onPressed: () {
                          _openImagePickerModal(context, 'produkthumbnail');
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      'Foto Kanan',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.grey),
                    ),
                    Container(
                      height: 20,
                    ),
                    produkfoto1 != null
                        ? Image.file(
                            produkfoto1,
                            fit: BoxFit.fitHeight,
                            alignment: Alignment.topCenter,
                            width: 80,
                            height: 80,
                          )
                        : Container(),
                    Container(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: () {
                          _openImagePickerModal(context, 'produkfoto1');
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      'Foto Kiri',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.grey),
                    ),
                    Container(
                      height: 20,
                    ),
                    produkfoto2 != null
                        ? Image.file(
                            produkfoto2,
                            fit: BoxFit.fitHeight,
                            alignment: Alignment.topCenter,
                            width: 80,
                            height: 80,
                          )
                        : Container(),
                    Container(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: () {
                          _openImagePickerModal(context, 'produkfoto2');
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      'Foto Belakang',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.grey),
                    ),
                    Container(
                      height: 20,
                    ),
                    produkfoto3 != null
                        ? Image.file(
                            produkfoto3,
                            fit: BoxFit.fitHeight,
                            alignment: Alignment.topCenter,
                            width: 80,
                            height: 80,
                          )
                        : Container(),
                    Container(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: IconButton(
                        highlightColor: Colors.green,
                        icon: Icon(Icons.camera_alt),
                        onPressed: () {
                          _openImagePickerModal(context, 'produkfoto3');
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      'Foto Bebas',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.grey),
                    ),
                    Container(
                      height: 20,
                    ),
                    produkfoto4 != null
                        ? Image.file(
                            produkfoto4,
                            fit: BoxFit.fitHeight,
                            alignment: Alignment.topCenter,
                            width: 80,
                            height: 80,
                          )
                        : Container(),
                    Container(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: () {
                          _openImagePickerModal(context, 'produkfoto4');
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 20,
        ),
        SizedBox(
          width: double.infinity,
          child: RaisedButton(
            child: Text("Kirim Pengajuan"),
            color: Color(0xffb16a085),
            textColor: Colors.white,
            padding: EdgeInsets.only(left: 11, right: 11, top: 15, bottom: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            onPressed: () {
              simpanFormRqt();
            },
          ),
        )
      ],
    );
  }
}
