import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocProyek.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/widget/Aktivity/Pengajuan/component/WidgetViewPdfPengajuan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:provider/provider.dart';

class WidgetSignature extends StatefulWidget {
  WidgetSignature({Key key, this.idProjek, this.signature}) : super(key: key);
  final String idProjek;
  final String signature;

  @override
  _WidgetSignatureState createState() => _WidgetSignatureState();
}

class _WidgetSignatureState extends State<WidgetSignature> {
  ByteData _img = ByteData(0);
  File _image;
  var color = Colors.black;
  var strokeWidth = 2.0;
  final _sign = GlobalKey<SignatureState>();
  String btn = 'Bersihkan';

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    BlocProyek blocProyek = Provider.of<BlocProyek>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Silahkan tanda tangan'),
      ),
      body: SafeArea(
        child: dataProvider.isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Signature(
                          color: color,
                          key: _sign,
                          onSign: () {
                            final sign = _sign.currentState;
                            debugPrint('${sign.points.length} points in the signature');
                          },
//                    backgroundPainter: _WatermarkPaint("2.0", "2.0"),
                          strokeWidth: strokeWidth,
                        ),
                      ),
                      color: Colors.black12,
                    ),
                  ),
                  _img.buffer.lengthInBytes == 0 ? Container() : LimitedBox(maxHeight: 200.0, child: Image.memory(_img.buffer.asUint8List())),
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          btn == 'Tanda tangan ulang'
                              ? InkWell(
                                  onTap: () {
                                    imageCache.clear();
                                    var url = baseURLMobile + '/kontrak?id=' + blocProyek.detailProyek[0].id;
                                    print(url);
                                    var title = 'Kontrak';
                                    Navigator.push(context, SlideRightRoute(page: WidgetViewPdfPengajuan(urlPdf: url, title: title)));
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.attach_file,
                                        color: Colors.blue,
                                      ),
                                      Text('Buka')
                                    ],
                                  ),
                                )
                              : MaterialButton(
                                  color: Colors.cyan[800],
                                  onPressed: () async {
                                    final sign = _sign.currentState;
                                    //retrieve image data, do whatever you want with it (send to server, save locally...)
                                    final image = await sign.getData();
                                    var data = await image.toByteData(format: ui.ImageByteFormat.png);
                                    sign.clear();
                                    final encoded = base64.encode(data.buffer.asUint8List());
                                    setState(() {
                                      _img = data;
                                    });
                                    var map = new Map<String, dynamic>();
                                    map['image_base64_string'] = encoded;
                                    map['id_projek'] = widget.idProjek;
                                    print(blocAuth.survey);
                                    if (blocAuth.survey) {
                                      map['user'] = 'survey';
                                    } else {
                                      map['user'] = 'mitra';
                                    }
                                    map['image_name'] = map['user'] + '_' + widget.idProjek + '_' + blocAuth.idUser.toString();
                                    print(map['user']);
                                    blocProyek.createSignature(map);
                                    setState(() {
                                      btn = 'Tanda tangan ulang';
                                    });
                                  },
                                  child: Text(
                                    'Simpan',
                                    style: TextStyle(color: Colors.white),
                                  )),
                          SizedBox(
                            width: 10,
                          ),
                          MaterialButton(
                              color: Colors.grey[500],
                              onPressed: () {
                                final sign = _sign.currentState;
                                sign.clear();
                                setState(() {
                                  _img = ByteData(0);
                                  btn = 'Bersihkan';
                                });
                                debugPrint("cleared");
                              },
                              child: Text(btn, style: TextStyle(color: Colors.white))),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
//                          MaterialButton(
//                              onPressed: () {
//                                setState(() {
//                                  color = color == Colors.black ? Colors.black : Colors.red;
//                                });
//                                debugPrint("change color");
//                              },
//                              child: Text("Change color")),
                          MaterialButton(
                              onPressed: () {
                                setState(() {
                                  int min = 1;
                                  int max = 10;
                                  int selection = min + (Random().nextInt(max - min));
                                  strokeWidth = selection.roundToDouble();
                                  debugPrint("Ubah pensil $selection");
                                });
                              },
                              child: Text("Ubah ukuran Pensil")),
                        ],
                      ),
                    ],
                  )
                ],
              ),
      ),
    );
  }
}

class _WatermarkPaint extends CustomPainter {
  final String price;
  final String watermark;

  _WatermarkPaint(this.price, this.watermark);

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 10.8, Paint()..color = Colors.blue.withOpacity(0.4));
  }

  @override
  bool shouldRepaint(_WatermarkPaint oldDelegate) {
    return oldDelegate != this;
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is _WatermarkPaint && runtimeType == other.runtimeType && price == other.price && watermark == other.watermark;

  @override
  int get hashCode => price.hashCode ^ watermark.hashCode;
}
