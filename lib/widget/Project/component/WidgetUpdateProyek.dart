import 'dart:io';

import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/models/Proyek.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocProyek.dart';
import 'package:apps/widget/Project/component/WidgetListPembayaran.dart';
import 'package:flutter/material.dart';
import 'package:html_editor/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class WidgetUpdateProyek extends StatefulWidget {
  WidgetUpdateProyek({
    Key key,
  }) : super(key: key);

  @override
  _WidgetUpdateProyekState createState() {
    return _WidgetUpdateProyekState();
  }
}

class _WidgetUpdateProyekState extends State<WidgetUpdateProyek> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyTermin = GlobalKey<FormState>();
  GlobalKey<HtmlEditorState> keyEditor = GlobalKey();
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
  String waktuPenawaran, catatan, budget, status, termin1, termin2, termin3, retensi;
  String percentase, nama;
  File foto;
  File foto1;
  File foto2;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1)).then((_) async {
      BlocProyek blocProyek = Provider.of<BlocProyek>(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    BlocProyek blocProyek = Provider.of<BlocProyek>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              color: Colors.cyan[600],
              onPressed: () {
                updateData();
              })
        ],
        title: Text('Ubah data'),
      ),
      body: blocProyek.detailProyek.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidate: false,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.95,
                  padding: EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Divider(),
                        blocAuth.survey
                            ? Container(
                                padding: EdgeInsets.all(8),
                                child: Text('Isi data jika ada perubahan'),
                              )
                            : Container(),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new TextFormField(
                              validator: (String arg) {
                                if (arg.length < 1)
                                  return 'Harus di isi';
                                else
                                  return null;
                              },
                              initialValue: blocProyek.detailProyek.isEmpty ? '0' : blocProyek.detailProyek[0].budget,
                              onChanged: (value) {
                                setState(() {
                                  budget = value;
                                });
                              },
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(
                                  hintText: '100.000',
                                  labelText: 'Budget',
                                  labelStyle: TextStyle(fontSize: 16, color: Colors.black),
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
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Jumlah Termin'),
                              IconButton(
                                  icon: Icon(
                                    Icons.add_circle,
                                    color: Colors.cyan[800],
                                    size: 40,
                                  ),
                                  onPressed: () {
                                    showDialogAddTermin();
                                  })
                            ],
                          ),
                        ),
                        Container(
                          height: 10,
                        ),
                        Container(
                          child: WidgetListPembayaran(),
                        ),
                        Container(
                          height: 10,
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new Text('Spesifikasi Pekerjaan'),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new HtmlEditor(
                              value: blocProyek.detailProyek.isEmpty ? '0' : blocProyek.detailProyek[0].deskripsi,
                              key: keyEditor,
                              showBottomToolbar: true,
                              useBottomSheet: false,
                              widthImage: '50%',
                              height: 300,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 10,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: DropdownButtonFormField<String>(
                                isDense: true,
                                hint: new Text(
                                  "Pilih Kategori",
                                  style: TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                                value: blocProyek.detailProyek.isEmpty ? 'setuju' : blocProyek.detailProyek[0].status,
                                validator: (String arg) {
                                  if (arg == null)
                                    return 'Harus di isi';
                                  else
                                    return null;
                                },
                                onChanged: (String value) {
                                  setState(() {
                                    status = value;
                                  });
                                },
                                items: [
                                  {'label': 'Terbitkan', 'value': 'setuju'},
                                  {'label': 'Survey', "value": 'survey'},
                                  {'label': 'Proses', "value": 'proses'}
                                ].map((item) {
                                  return new DropdownMenuItem<String>(
                                    value: item['value'],
                                    child: Row(
                                      children: [
                                        new Text(
                                          item['label'],
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            Container(
                              height: 10,
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
                                            : blocProyek.detailProyek[0].foto1 == null
                                                ? Container()
                                                : Image.network(
                                                    baseURL + '/api-v2/assets/toko/' + blocProyek.detailProyek[0].foto1,
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
                                            : blocProyek.detailProyek[0].foto2 == null
                                                ? Container()
                                                : Image.network(
                                                    baseURL + '/api-v2/assets/toko/' + blocProyek.detailProyek[0].foto2,
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
                                          'Foto 3',
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
                                            : blocProyek.detailProyek[0].foto3 == null
                                                ? Container()
                                                : Image.network(
                                                    baseURL + '/api-v2/assets/toko/' + blocProyek.detailProyek[0].foto3,
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
//                            Container(
//                              height: 10,
//                            ),
//                            RoundedLoadingButton(
//                              child: Text('Simpan & Terbitkan', style: TextStyle(color: Colors.white)),
//                              color: Colors.red,
//                              controller: _btnController,
//                              onPressed: () => updateData(),
//                            ),
                            Container(
                              height: 40,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
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

  updateData() async {
    BlocProyek blocProyek = Provider.of<BlocProyek>(context);
    final deskripsi = await keyEditor.currentState.getText();
    String fileNameFoto;
    String fileNameFoto1;
    String fileNameFoto2;
    if (foto != null) {
      fileNameFoto = foto.path.split('/').last;
    } else {
      fileNameFoto = blocProyek.detailProyek[0].foto1;
    }
    if (foto1 != null) {
      fileNameFoto1 = foto1.path.split('/').last;
    } else {
      fileNameFoto1 = blocProyek.detailProyek[0].foto2;
    }
    if (foto2 != null) {
      fileNameFoto2 = foto2.path.split('/').last;
    } else {
      fileNameFoto2 = blocProyek.detailProyek[0].foto3;
    }
    var body = {
      'id': blocProyek.detailProyek[0].id.toString(),
      'foto1': fileNameFoto.toString(),
      'foto2': fileNameFoto1.toString(),
      'foto3': fileNameFoto2.toString(),
      'budget': budget == null ? blocProyek.detailProyek[0].budget.toString() : budget.toString(),
      'deskripsi': deskripsi.toString(),
      'status': status == null ? blocProyek.detailProyek[0].status.toString() : status.toString(),
    };
    List<File> files = [foto, foto1, foto2];
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      var result = blocProyek.updateProyek(files, body);
      result.then((value) {
        if (value['meta']['success']) {
          blocProyek.getDetailProyekByParam({'id': blocProyek.detailProyek[0].id, 'aktif': '1'});
          _scaffoldKey.currentState.showSnackBar(const SnackBar(
            content: const Text('Berhasil disimpan'),
            backgroundColor: Colors.green,
          ));
        } else {
          _scaffoldKey.currentState.showSnackBar(const SnackBar(content: const Text('Tidak ada perubahan'), backgroundColor: Colors.grey));
        }
      });
    }
  }

  void showDialogAddTermin() {
    BlocProyek blocProyek = Provider.of<BlocProyek>(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Tambah Termin"),
                IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            ),
            content: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Scaffold(
                backgroundColor: Colors.white,
                body: Form(
                  key: _formKeyTermin,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: new TextFormField(
                          validator: (String arg) {
                            if (arg.length < 1)
                              return 'Harus di isi';
                            else
                              return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              nama = value;
                            });
                          },
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.start,
                          decoration: const InputDecoration(
                              hintText: 'Termin 1',
                              labelText: 'Nama Tagihan ',
                              labelStyle: TextStyle(fontSize: 16, color: Colors.black),
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
                        width: MediaQuery.of(context).size.width,
                        child: new TextFormField(
                          validator: (String arg) {
                            if (arg.length < 1)
                              return 'Harus di isi';
                            else
                              return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              percentase = value;
                            });
                          },
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.start,
                          decoration: const InputDecoration(
                              suffix: Text('%'),
                              hintText: '30%',
                              labelText: 'Percentase',
                              labelStyle: TextStyle(fontSize: 16, color: Colors.black),
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
                    ],
                  ),
                ),
                persistentFooterButtons: [
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Text(
                        'Simpan',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _formKeyTermin.currentState.save();
                        Navigator.pop(context);
                        if (_formKeyTermin.currentState.validate()) {
                          var body = {'id_proyek': blocProyek.detailProyek[0].id, 'nama': nama.toString(), 'percentase': percentase.toString()};
                          var result = blocProyek.insertTermin(body);
                          result.then((value){
                            if(value){
                              blocProyek.getTagihanByParam({'id_proyek': blocProyek.detailProyek[0].id.toString()});
                            }
                          });
                        }
                      },
                      color: Colors.cyan[800],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
