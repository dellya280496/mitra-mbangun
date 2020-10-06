import 'dart:io';

import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/Utils/SnacbarLauncher.dart';
import 'package:apps/models/Categories.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:flutter/material.dart';
import 'package:html_editor/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';

class WidgetUpdateProduk extends StatefulWidget {
  WidgetUpdateProduk({Key key}) : super(key: key);

  @override
  _WidgetUpdateProdukState createState() => _WidgetUpdateProdukState();
}

class _WidgetUpdateProdukState extends State<WidgetUpdateProduk> {
  GlobalKey<HtmlEditorState> keyEditor = GlobalKey();
  String nama, berat, harga, minimal_pesanan, stok, panjang, deskripsi;
  String id_kategori = null;
  String kondisi = null;
  String jenis_ongkir = null;
  File foto;
  File foto1;
  File foto2;
  bool success = false;
  bool error = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      id_kategori = null;
      success = false;
      error = false;
      kondisi = null;
      jenis_ongkir = null;
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    BlocProduk blocProduk = Provider.of<BlocProduk>(context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    BlocProduk blocProduk = Provider.of<BlocProduk>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    // TODO: implement build
    AppBar appBar = AppBar(
      elevation: 0,
      title: Text('Update Produk'),
      actions: [
        IconButton(
          icon: Icon(
            Icons.save,
            color: Colors.cyan,
          ),
          onPressed: () {
            _simpan();
          },
        )
      ],
    );
    return WillPopScope(
      onWillPop: _onWillPop,
      child: ModalProgressHUD(
        inAsyncCall: blocProduk.isLoading,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: appBar,
          body: blocProduk.detailProduct.isEmpty
              ? Center(child: PKCardListSkeleton())
              : SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
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
                            height: 70,
                            child: TextFormField(
                              initialValue: blocProduk.detailProduct[0].nama,
                              onSaved: (value) {
                                setState(() {
                                  nama = value;
                                });
                              },
                              keyboardType: TextInputType.text,
                              validator: (String arg) {
                                if (arg.length < 1)
                                  return 'Nama Produk Harus di isi';
                                else
                                  return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Nama Produk',
                                labelText: 'Nama Produk',
                                labelStyle: TextStyle(fontSize: 16),
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ),
                          ),
                          Container(
                            height: 70,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  child: TextFormField(
                                    initialValue: blocProduk.detailProduct[0].berat,
                                    onSaved: (value) {
                                      setState(() {
                                        berat = value;
                                      });
                                    },
                                    keyboardType: TextInputType.number,
                                    validator: (String arg) {
                                      if (arg.length < 1)
                                        return 'Berat Produk Harus di isi';
                                      else
                                        return null;
                                    },
                                    decoration: InputDecoration(
                                      suffixText: 'gram',
                                      hintText: 'Berat',
                                      labelText: 'Berat',
                                      labelStyle: TextStyle(fontSize: 16),
                                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 70,
                                  width: MediaQuery.of(context).size.width * 0.6,
                                  child: TextFormField(
                                    initialValue: blocProduk.detailProduct[0].harga,
                                    onSaved: (value) {
                                      setState(() {
                                        harga = value;
                                      });
                                    },
                                    keyboardType: TextInputType.number,
                                    validator: (String arg) {
                                      if (arg.length < 1)
                                        return 'Harga Produk Harus di isi';
                                      else
                                        return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Harga Produk',
                                      labelText: 'Harga Produk',
                                      prefixText: 'Rp ',
                                      labelStyle: TextStyle(fontSize: 16),
                                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 70,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width * 0.6,
                                  child: TextFormField(
                                    initialValue: blocProduk.detailProduct[0].panjang,
                                    onSaved: (value) {
                                      setState(() {
                                        panjang = value;
                                      });
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      suffixText: 'cm',
                                      hintText: 'Panjang',
                                      labelText: 'Panjang',
                                      labelStyle: TextStyle(fontSize: 16),
                                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 70,
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  child: TextFormField(
                                    initialValue: blocProduk.detailProduct[0].stok,
                                    onSaved: (value) {
                                      setState(() {
                                        stok = value;
                                      });
                                    },
                                    keyboardType: TextInputType.number,
                                    validator: (String arg) {
                                      if (arg.length < 1)
                                        return 'Stok Produk Harus di isi';
                                      else
                                        return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Stok',
                                      labelText: 'Stok',
                                      labelStyle: TextStyle(fontSize: 16),
                                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 70,
                            child: TextFormField(
                              initialValue: blocProduk.detailProduct[0].minimalPesanan,
                              onSaved: (value) {
                                setState(() {
                                  minimal_pesanan = value;
                                });
                              },
                              keyboardType: TextInputType.number,
                              validator: (String arg) {
                                if (arg.length < 1)
                                  return 'Minimal pemesanan Produk Harus di isi';
                                else
                                  return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Minimal pemesanan',
                                labelText: 'Minimal pemesanan',
                                labelStyle: TextStyle(fontSize: 16),
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 10,
                            child: DropdownButtonFormField<String>(
                              isDense: true,
                              hint: new Text(
                                "Pilih Kategori",
                                style: TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                              value: blocProduk.detailProduct[0].idKategori,
                              validator: (String arg) {
                                if (arg == null)
                                  return 'Harus di isi';
                                else
                                  return null;
                              },
                              onChanged: (String value) {
                                setState(() {
                                  id_kategori = value;
                                });
                              },
                              items: blocProduk.listCategory.isEmpty
                                  ? null
                                  : blocProduk.listCategory.map((Categories item) {
                                      return new DropdownMenuItem<String>(
                                        value: item.id,
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/kategori/' + item.icon,
                                              height: 30,
                                              width: 30,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            new Text(
                                              item.nama.toString(),
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
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
                                  "Pilih Kondisi",
                                  style: TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                                value: blocProduk.detailProduct[0].kondisi,
                                validator: (String arg) {
                                  if (arg == null)
                                    return 'Harus di isi';
                                  else
                                    return null;
                                },
                                onChanged: (String value) {
                                  setState(() {
                                    kondisi = value;
                                  });
                                },
                                items: [
                                  {'label': 'baru'},
                                  {'label': 'bekas'}
                                ].map((e) {
                                  return DropdownMenuItem<String>(
                                    value: e['label'],
                                    child: new Text(
                                      e['label'].toString(),
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  );
                                }).toList()),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 10,
                            child: DropdownButtonFormField<String>(
                                isDense: true,
                                hint: new Text(
                                  "Pilih Pengiriman",
                                  style: TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                                value: blocProduk.detailProduct[0].jenisOngkir,
                                validator: (String arg) {
                                  if (arg == null)
                                    return 'Harus di isi';
                                  else
                                    return null;
                                },
                                onChanged: (String value) {
                                  setState(() {
                                    jenis_ongkir = value;
                                  });
                                },
                                items: [
                                  {'label': 'expedisi', 'value': 'raja_ongkir'},
                                  {'label': 'free ongkir seluruh kota', 'value': 'include'},
                                  {'label': 'free ongkir dalam kota', 'value': 'include_dalam_kota'},
                                ].map((e) {
                                  return DropdownMenuItem<String>(
                                    value: e['value'],
                                    child: new Text(
                                      e['label'].toString(),
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  );
                                }).toList()),
                          ),
                          SizedBox(
                            height: 15,
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
                                        'Foto',
                                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.grey),
                                      ),
                                      Container(
                                        height: 20,
                                      ),
                                      foto != null
                                          ? Image.file(
                                              foto,
                                              fit: BoxFit.fitHeight,
                                              alignment: Alignment.topCenter,
                                              width: 80,
                                              height: 80,
                                            )
                                          : blocProduk.detailProduct[0].foto == null
                                              ? Container()
                                              : Image.network(
                                                  baseURL+ '/api-v2/assets/toko/' + blocProduk.detailProduct[0].foto,
                                                ),
                                      Container(
                                        height: 20,
                                      ),
                                      Container(
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
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      new Text(
                                        'Foto 2',
                                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.grey),
                                      ),
                                      Container(
                                        height: 20,
                                      ),
                                      foto1 != null
                                          ? Image.file(
                                              foto1,
                                              fit: BoxFit.fitHeight,
                                              alignment: Alignment.topCenter,
                                              width: 80,
                                              height: 80,
                                            )
                                          : blocProduk.detailProduct[0].foto1 == null
                                              ? Container()
                                              : Image.network(
                                                  baseURL+ '/api-v2/assets/toko/' + blocProduk.detailProduct[0].foto1,
                                                ),
                                      Container(
                                        height: 20,
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        child: IconButton(
                                          icon: Icon(Icons.camera_alt),
                                          onPressed: () {
                                            _openImagePickerModal(context, 'foto1');
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
                                        'Foto 2',
                                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.grey),
                                      ),
                                      Container(
                                        height: 20,
                                      ),
                                      foto2 != null
                                          ? Image.file(
                                              foto2,
                                              fit: BoxFit.fitHeight,
                                              alignment: Alignment.topCenter,
                                              width: 80,
                                              height: 80,
                                            )
                                          : blocProduk.detailProduct[0].foto2 == null
                                              ? Container()
                                              : Image.network(
                                                  baseURL+ '/api-v2/assets/toko/' + blocProduk.detailProduct[0].foto2,
                                                ),
                                      Container(
                                        height: 20,
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        child: IconButton(
                                          icon: Icon(Icons.camera_alt),
                                          onPressed: () {
                                            _openImagePickerModal(context, 'foto2');
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
                          HtmlEditor(
                            value: blocProduk.detailProduct[0].deskripsi.toString(),
                            key: keyEditor,
                            showBottomToolbar: true,
                            useBottomSheet: false,
                            widthImage: '50%',
                            height: 400,
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
      ),
    );
  }

  Future<void> _simpan() async {
    BlocProduk blocProduk = Provider.of<BlocProduk>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);

    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      String fileNameFoto;
      String fileNameFoto1;
      String fileNameFoto2;
      if (foto != null) {
        fileNameFoto = foto.path.split('/').last;
      } else {
        fileNameFoto = blocProduk.detailProduct[0].foto;
      }
      if (foto1 != null) {
        fileNameFoto1 = foto1.path
            .split('/')
            .last;
      } else {
        fileNameFoto1 = blocProduk.detailProduct[0].foto1;
      }
      if (foto2 != null) {
        fileNameFoto2 = foto2.path
            .split('/')
            .last;
      } else {
        fileNameFoto2 = blocProduk.detailProduct[0].foto2;
      }
      final deskripsi = await keyEditor.currentState.getText();
      var body = {
        'id': blocProduk.detailProduct[0].id.toString(),
        'nama': nama.toString(),
        'berat': berat.toString(),
        'foto': fileNameFoto.toString(),
        'foto1': fileNameFoto1.toString(),
        'foto2': fileNameFoto2.toString(),
        'jenis_ongkir': jenis_ongkir == null ? blocProduk.detailProduct[0].jenisOngkir : jenis_ongkir.toString(),
        'deskripsi': deskripsi.toString(),
        'id_kategori': id_kategori == null ? blocProduk.detailProduct[0].idKategori : id_kategori.toString(),
        'id_toko': blocAuth.idToko.toString(),
        'kondisi': kondisi == null ? blocProduk.detailProduct[0].kondisi : kondisi.toString(),
        'minimal_pesanan': minimal_pesanan.toString(),
        'harga': harga.toString(),
        'panjang': panjang.toString(),
        'stok': stok.toString(),
      };
      List<File> files = [foto, foto1, foto2];
      print(body);
      var result = await blocProduk.updateProduk(files, body);
      if (result['meta']['success']) {
        setState(() {
          success = true;
        });
        await Future.delayed(Duration(seconds: 1), () {
          Navigator.pop(context);
        });
      } else {
        setState(() {
          error = true;
        });
        await Future.delayed(Duration(seconds: 1), () {
          setState(() {
            error = false;
          });
        });
      }
    }
  }

  Future<bool> _onWillPop() {
    BlocProduk blocProduk = Provider.of<BlocProduk>(context);
    if (blocProduk.isLoading) {
      return showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              backgroundColor: Colors.amber,
              title: Text('Produk sedang di upload'),
              content: Text('Proses upload sedang berlangsng silahkan tunggu'),
            ),
      ) ??
          false;
    } else {
      Navigator.pop(context);
    }
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
    File image = await ImagePicker.pickImage(source: source, maxHeight: 640, maxWidth: 640, imageQuality: 50);
    if (param == 'foto') {
      setState(() {
        foto = image;
      });
    } else if (param == 'foto1') {
      setState(() {
        foto1 = image;
      });
    } else if (param == 'foto2') {
      setState(() {
        foto2 = image;
      });
    }
    Navigator.pop(context);
  }
}
