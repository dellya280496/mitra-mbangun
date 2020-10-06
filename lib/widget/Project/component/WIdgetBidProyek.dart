import 'dart:io';

import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocProyek.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class WidgetBidProyek extends StatefulWidget {
  WidgetBidProyek({Key key}) : super(key: key);

  @override
  _WidgetBidProyekState createState() => _WidgetBidProyekState();
}

class _WidgetBidProyekState extends State<WidgetBidProyek> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String waktuPenawaran, catatan, harga;
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
  File foto;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    BlocProyek blocProyek = Provider.of<BlocProyek>(context);
    final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
    var budget = blocProyek.detailProyek.isEmpty ? '0' : Money.fromInt(int.parse(blocProyek.detailProyek[0].budget.toString()), IDR).toString();
    // TODO: implement build
    return ModalProgressHUD(
      inAsyncCall: blocProyek.isLoading,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          title: Text('Bid Proyek'),
          actions: [
            IconButton(
                icon: Icon(Icons.upload_file),
                color: Colors.cyan[600],
                onPressed: () {
                  bidding();
                })
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidate: false,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              padding: EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      color: Colors.yellow,
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text('Budget Proyek'),
                          ),
                          Container(
                            child: Text(budget.toString()),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: new TextFormField(
                          validator: (String arg) {
                            if (arg.length < 1)
                              return 'Harus di isi';
                            else
                              return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              harga = value;
                            });
                          },
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.right,
                          inputFormatters: [MoneyInputFormatter(useSymbolPadding: true, mantissaLength: 0, leadingSymbol: 'Rp')],
                          decoration: const InputDecoration(
                              hintText: '100.000',
                              labelText: 'Penawaran anda',
                              labelStyle: TextStyle(fontSize: 15),
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
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: new TextFormField(
                          validator: (String arg) {
                            if (arg.length < 1)
                              return 'Harus di isi';
                            else
                              return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              waktuPenawaran = value;
                            });
                          },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              hintText: '15',
                              labelText: 'Ajukan Waktu Pengerjaan',
                              suffix: Text('Hari'),
                              labelStyle: TextStyle(fontSize: 15),
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
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: new TextFormField(
                          validator: (String arg) {
                            if (arg.length < 1)
                              return 'Harus di isi';
                            else
                              return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              catatan = value;
                            });
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: 2,
                          decoration: const InputDecoration(
                              labelText: "Catatan",
                              hintText: 'Catatan',
                              labelStyle: TextStyle(fontSize: 15),
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
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text('Foto/Desain'),
                    ),
                    Container(
                      height: 300,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 20,
                            ),
                            foto != null
                                ? Image.file(
                                    foto,
                                    fit: BoxFit.fitHeight,
                                    alignment: Alignment.topCenter,
                                    width: 150,
                                    height: 150,
                                  )
                                : Container(),
                            Container(
                              height: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              color: Colors.white,
                              child: IconButton(
                                highlightColor: Colors.white,
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
                    SizedBox(
                      height: 5,
                    ),
//                  RoundedLoadingButton(
//                    child: Text(blocAuth.survey ? 'Terbitkan sekarang' : 'Apply', style: TextStyle(color: Colors.white)),
//                    color: Colors.red,
//                    controller: _btnController,
//                    onPressed: () => bidding(),
//                  )
                  ],
                ),
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
    File image = await ImagePicker.pickImage(source: source, maxHeight: 640, maxWidth: 640,imageQuality: 0);
    if (param == 'foto') {
      setState(() {
        foto = image;
      });
    }
    Navigator.pop(context);
  }

  bidding() {
    BlocProyek blocProyek = Provider.of<BlocProyek>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    String fileNameFoto;
    _formKey.currentState.save();
    if (foto == null) {
      _scaffoldKey.currentState.showSnackBar(const SnackBar(
        content: const Text('Foto tidak boleh kosong'),
        backgroundColor: Colors.red,
      ));
    } else {
      fileNameFoto = foto.path.split('/').last;
      var budget = harga.replaceAll('Rp', '');
      var saveBudget = budget.replaceAll(',', '');
      var body = {
        'id_projek': blocProyek.detailProyek[0].id.toString(),
        'id_user': blocProyek.detailProyek[0].idUserLogin.toString(),
        'foto': fileNameFoto.toString(),
        'id_mitra': blocAuth.idUser.toString(),
        'deskripsi': catatan.toString(),
        'harga': saveBudget.toString(),
        'waktu_pengerjaan': waktuPenawaran.toString(),
        'status': '0'
      };
      List<File> files = [foto];
      print(body);
      if (_formKey.currentState.validate()) {
        var result = blocProyek.addBidding(files, body);
        result.then((value) {
          if (value) {
            blocProyek.getBidsByParam({'id_mitra': blocAuth.idUser, 'id_projek': blocProyek.detailProyek[0].id});
            blocProyek.getListPekerja({'id_projek': blocProyek.detailProyek[0].id.toString(), 'status_proyek': 'setuju'});
            Navigator.pop(context);
          }
        });
      }
    }
  }
}
