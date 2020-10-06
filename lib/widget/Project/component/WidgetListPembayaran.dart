import 'dart:io';
import 'package:apps/Utils/PreviewFoto.dart';
import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/models/TagihanM.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocProyek.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:money2/money2.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';

class WidgetListPembayaran extends StatefulWidget {
  WidgetListPembayaran({Key key, this.param, this.foto}) : super(key: key);
  final Map<String, String> param;
  File foto;

  @override
  _WidgetListPembayaranState createState() => _WidgetListPembayaranState();
}

class _WidgetListPembayaranState extends State<WidgetListPembayaran> {
  final GlobalKey<FormState> _formKeyTermin = GlobalKey<FormState>();
  String percentase, nama;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BlocProyek blocProyek = Provider.of<BlocProyek>(context);
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
    var totalTagihan = '';
    blocProyek.listBids.forEach((element) => {
          if (element.status == '1') {totalTagihan = element.harga}
        });
    return blocProyek.isLoading
        ? Container(
            height: 250,
            child: SingleChildScrollView(
              child: Container(
                  height: 100,
                  child: Center(
                    child: PKCardListSkeleton(
                      length: 3,
                    ),
                  )),
            ),
          )
        : ExpansionTileCard(
            elevation: 2,
            colorCurve: Curves.ease,
            initiallyExpanded: true,
            leading: Icon(
              Icons.payment,
              color: Colors.green,
            ),
            title: Text('Pembayaran '),
            subtitle: Text(
              totalTagihan == '' ? '0' : Money.fromInt(int.parse(totalTagihan), IDR).toString(),
              style: TextStyle(color: Colors.green),
            ),
            children: <Widget>[
              Divider(
                thickness: 1.0,
                height: 1.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    child: ListView.builder(
                        itemCount: blocProyek.listTagihan.length,
                        itemBuilder: (context, index) {
                          var foto = baseURL + pathUrl + 'assets/tagihan/' + blocProyek.listTagihan[index].foto.toString();
                          var termin = (int.parse(totalTagihan == '' ? '0' : totalTagihan) / 100 * int.parse(blocProyek.listTagihan[index].percentase));
                          return ListTile(
                            leading: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageRouteTransition(
                                      animationType: AnimationType.slide_down,
                                      builder: (context) => PreviewFoto(urlFoto: foto == null ? dataProvider.fotoNull : foto),
                                    ));
                              },
                              child: Image.network(
                                baseURL + pathUrl + 'assets/tagihan/' + blocProyek.listTagihan[index].foto.toString(),
                                height: 45,
                                width: 45,
                                errorBuilder: (context, urlImage, error) {
                                  return Image.network(
                                    dataProvider.fotoNull,
                                    height: 45,
                                    width: 45,
                                  );
                                },
                              ),
                            ),
                            title: Text(blocProyek.listTagihan[index].nama),
                            subtitle: Text(blocProyek.listTagihan[index].percentase + '% = ' + Money.fromInt(termin.round(), IDR).toString()),
                            trailing: blocAuth.survey
                                ? Container(
                                    height: 30,
                                    width: 100,
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () {
                                            showDialogEditTermin(blocProyek.listTagihan[index]);
                                            setState(() {
                                              nama = blocProyek.listTagihan[index].nama;
                                              percentase = blocProyek.listTagihan[index].percentase;
                                            });
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () {
                                            showDeleteTermin(blocProyek.listTagihan[index]);
                                          },
                                        )
                                      ],
                                    ),
                                  )
                                : Container(
                                    child: Text('-'),
                                  ),
                          );
                        }),
                  ),
                ],
              )
            ],
          );
  }

  void _chooseImage(context, TagihanM param) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    openImagePickerModal(context, param);
  }

  void openImagePickerModal(BuildContext context, TagihanM param) {
    var file;
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
    return file;
  }

  void _getImage(BuildContext context, ImageSource source, TagihanM param) async {
    File image = await ImagePicker.pickImage(source: source, maxHeight: 1000, maxWidth: 1000, imageQuality: 50);
    Navigator.pop(context);
    _cropImage(image, context, param);
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

  void showDialogEditTermin(TagihanM listTagihan) {
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
                          initialValue: listTagihan.nama,
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
                          initialValue: listTagihan.percentase,
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
                          var body = {'id': listTagihan.id, 'nama': nama.toString(), 'percentase': percentase.toString()};
                          print(body);
                          var result = blocProyek.updateTermin(body);
                          result.then((value) {
                            if (value) {
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

  void showDeleteTermin(TagihanM listTagihan) {
    BlocProyek blocProyek = Provider.of<BlocProyek>(context);
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        var nama = listTagihan.nama;
        return AlertDialog(
          title: Text('Hapus $nama'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Apakah anda yakin ingin menghapus data?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Tidak'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Iya'),
              onPressed: () {
                var body = {'id': listTagihan.id.toString()};
                var result = blocProyek.deleteTermin(body);
                result.then((value) {
                  if (value) {
                    blocProyek.getTagihanByParam({'id_proyek': blocProyek.detailProyek[0].id.toString()});
                    Navigator.of(context).pop();
                  }
                });
              },
            ),
          ],
        );
      },
    );
  }
}
