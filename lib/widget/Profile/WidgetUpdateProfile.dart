import 'dart:io';

import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/Utils/SnacbarLauncher.dart';
import 'package:apps/models/TagihanM.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/providers/BlocProyek.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';

class WidgetUpdateProfile extends StatefulWidget {
  WidgetUpdateProfile({Key key}) : super(key: key);

  @override
  _WidgetUpdateProfileState createState() => _WidgetUpdateProfileState();
}

class _WidgetUpdateProfileState extends State<WidgetUpdateProfile> {
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Data Rekening'),
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
        child:SingleChildScrollView(
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
                      initialValue: blocAuth.detailMitra[0].namaBank,
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
                      initialValue: blocAuth.detailMitra[0].noRekening,
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
                      initialValue: blocAuth.detailMitra[0].namaPemilikRekening,
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
                  Center(
                    child: Text('Silahkan lengkapi data rekening terlebih dahulu.',style: TextStyle(color: Colors.red),),
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
  void _simpan() async {
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    var body = {
      'id': blocAuth.detailMitra[0].idMitra.toString(),
      'nama_bank': namaBank.toString(),
      'no_rekening': noRekening.toString(),
      'nama_pemilik_rekening': namaPemilikRekening.toString()
    };
    var result = await blocProfile.updateProfil(body);
    if (result['meta']['success']) {
      setState(() {
        success = true;
      });
      await Future.delayed(Duration(seconds: 1), () {
        Navigator.pop(context);
      });
      blocAuth.checkSession();
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

  void _getImage(BuildContext context, ImageSource source, param) async {
    File image = await ImagePicker.pickImage(
      source: source,
      maxHeight: 1000, maxWidth: 1000,
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
  Future<Null> _cropImage(imageFile, context, TagihanM param) async {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    BlocProyek blocProyek = Provider.of<BlocProyek>(context);
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [CropAspectRatioPreset.square, CropAspectRatioPreset.ratio3x2, CropAspectRatioPreset.original, CropAspectRatioPreset.ratio4x3, CropAspectRatioPreset.ratio16x9]
            : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper', toolbarColor: Colors.deepOrange, toolbarWidgetColor: Colors.white, initAspectRatio: CropAspectRatioPreset.original, lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      dataProvider.setFile(croppedFile);
      var body = {'id': param.id, 'foto': croppedFile.path.split('/').last};
      List<File> files = [croppedFile];
      dataProvider.setUpload(true);
      var result = blocProyek.uploadTermin(files, body);
      result.then((value) {
        if (value['meta']['success']) {
          blocProyek.getProjectByOrder({'id': param.idProyek.toString()});
          blocProyek.getTagihanByParam({'id_proyek': param.idProyek.toString()});
        }
      });
    }
  }
}
