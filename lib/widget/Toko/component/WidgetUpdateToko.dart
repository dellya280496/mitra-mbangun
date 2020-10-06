import 'dart:io';

import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/Utils/SnacbarLauncher.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/widget/Toko/component/UpdateAlamatToko.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';

class WidgetUpdateToko extends StatefulWidget {
  WidgetUpdateToko({Key key}) : super(key: key);

  @override
  _WidgetUpdateTokoState createState() => _WidgetUpdateTokoState();
}

class _WidgetUpdateTokoState extends State<WidgetUpdateToko> {
  String namaBank, noRekening, namaPemilikRekening;
  File foto;
  File foto1;
  bool success = false;
  bool error = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    BlocProduk blocProduk = Provider.of<BlocProduk>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Ubah Toko'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.cyan,
            ),
            onPressed: () {
              _formKey.currentState.save();
              if (_formKey.currentState.validate()) {
                _simpan();
              }
            },
          )
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: blocProduk.isLoading,
        child: blocProfile.isLoading
            ? Center(child: PKCardListSkeleton())
            : SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        success
                            ? SnackBarLauncher(
                                error: 'Berhasil ditambahkan',
                                color: Colors.green,
                              )
                            : Container(),
                        error
                            ? SnackBarLauncher(
                                error: 'Tidak ada perubahan',
                                color: Colors.red,
                              )
                            : Container(),
                        Container(
                          height: 80,
                          child: TextFormField(
                            initialValue: blocProfile.dataToko['nama_bank'],
                            onSaved: (value) {
                              setState(() {
                                namaBank = value;
                              });
                            },
                            keyboardType: TextInputType.text,
                            validator: (String arg) {
                              if (arg.length < 1)
                                return 'Nama Bank';
                              else
                                return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Nama Bank',
                              labelText: 'Nama Bank',
                              errorStyle: TextStyle(fontSize: 9),
                              labelStyle: TextStyle(fontSize: 16),
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ),
                        ),
                        Container(
                          height: 80,
                          child: TextFormField(
                            initialValue: blocProfile.dataToko['no_rekening'],
                            onSaved: (value) {
                              setState(() {
                                noRekening = value;
                              });
                            },
                            keyboardType: TextInputType.number,
                            validator: (String arg) {
                              if (arg.length < 1)
                                return 'No.Rekening';
                              else
                                return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'No.Rekening',
                              labelText: 'No.Rekening',
                              errorStyle: TextStyle(fontSize: 9),
                              labelStyle: TextStyle(fontSize: 16),
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ),
                        ),
                        Container(
                          height: 80,
                          child: TextFormField(
                            initialValue: blocProfile.dataToko['nama_pemilik_rekening'],
                            onSaved: (value) {
                              setState(() {
                                namaPemilikRekening = value;
                              });
                            },
                            keyboardType: TextInputType.text,
                            validator: (String arg) {
                              if (arg.length < 1)
                                return 'Nama Pemilik Rekening';
                              else
                                return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Nama Pemilik Rekening',
                              labelText: 'Nama Pemilik Rekening',
                              errorStyle: TextStyle(fontSize: 9),
                              labelStyle: TextStyle(fontSize: 16),
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Alamat Toko'),
                        SizedBox(
                          height: 5,
                        ),
                        UpdateAlamatToko(),
                        SizedBox(
                          height: 30,
                        ),
                        new Text(
                          'Foto',
                          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.black),
                        ),
                        Container(
                          height: 220,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 20,
                                ),
                                foto != null
                                    ? Image.file(
                                        foto,
//                                            fit: BoxFit.fitHeight,
                                        alignment: Alignment.topCenter,
//                                            width: 80,
                                        height: 100,
                                      )
                                    : blocProfile.dataToko['foto'] == null
                                        ? Container()
                                        : Container(
                                            width: 100.0,
                                            height: 100.0,
                                            child: ClipOval(
                                              child: Image.network(baseURL+ '/api-v2/assets/toko/' + blocProfile.dataToko['foto'], fit: BoxFit.contain,
                                                  errorBuilder: (context, urlImage, error) {
                                                print(error.hashCode);
                                                return Image.asset('assets/logo.png');
                                              }),
                                            ),
                                          ),
                                Container(
                                  height: 20,
                                ),
                                Container(
                                  color: Colors.white,
                                  width: MediaQuery.of(context).size.width,
                                  child: IconButton(
                                    highlightColor: Colors.green,
                                    icon: Icon(Icons.camera_alt),
                                    onPressed: () {
                                      _openImagePickerModal(context, 'foto');
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 20,
                        ),
                        new Text(
                          'Sampul',
                          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.black),
                        ),
                        Container(
                          height: 300,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 20,
                                ),
                                foto1 != null
                                    ? Image.file(
                                        foto1,
                                        fit: BoxFit.fitHeight,
                                        alignment: Alignment.topCenter,
                                        height: 200,
                                      )
                                    : blocProfile.dataToko['foto_sampul'] == null
                                        ? Container()
                                        : Image.network(
                                            baseURL+ '/api-v2/assets/toko/' + blocProfile.dataToko['foto_sampul'],
                                            height: 200,
                                          ),
                                Container(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          child: IconButton(
                            icon: Icon(Icons.camera_alt),
                            onPressed: () {
                              _openImagePickerModal(context, 'foto1');
                            },
                          ),
                        ),
                  Container(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _simpan() async {
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    String fileNameFoto;
    String fileNameFoto1;
    if (foto != null) {
      fileNameFoto = foto.path.split('/').last;
    } else {
      fileNameFoto = blocProfile.dataToko['foto'];
    }
    if (foto1 != null) {
      fileNameFoto1 = foto1.path.split('/').last;
    } else {
      fileNameFoto1 = blocProfile.dataToko['foto_sampul'];
    }
    var body = {
      'id': blocProfile.dataToko['id'].toString(),
      'foto': fileNameFoto,
      'foto_sampul': fileNameFoto1,
      'nama_bank': namaBank.toString(),
      'no_rekening': noRekening.toString(),
      'nama_pemilik_rekening': namaPemilikRekening.toString(),
      'id_kecamatan': blocProfile.id_subdistrict,
      'id_kota': blocProfile.id_city,
      'id_provinsi': blocProfile.id_provice,
    };
    List<File> files = [foto, foto1];
//    var result = await blocProfile.updateToko(files, body);
//    if (result['meta']['success']) {
//      setState(() {
//        success = true;
//      });
//      await Future.delayed(Duration(seconds: 1), () {
//        Navigator.pop(context);
//      });
//    } else {
//      setState(() {
//        error = true;
//      });
//      await Future.delayed(Duration(seconds: 1), () {
//        setState(() {
//          error = false;
//        });
//      });
//    }
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
    File image = await ImagePicker.pickImage(
      source: source,
      maxHeight: 640, maxWidth: 640,
      imageQuality: 50,
    );
    if (param == 'foto') {
      setState(() {
        foto = image;
      });
    } else if (param == 'foto1') {
      setState(() {
        foto1 = image;
      });
    }
    Navigator.pop(context);
  }
}
