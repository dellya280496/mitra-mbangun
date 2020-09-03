import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:apps/providers/DataProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:provider/provider.dart';

class WidgetSignature extends StatefulWidget {
  WidgetSignature({Key key, this.produkId, this.kontrakId, this.signature}) : super(key: key);
  final String produkId;
  final String kontrakId;
  final String signature;

  @override
  _WidgetSignatureState createState() => _WidgetSignatureState();
}

class _WidgetSignatureState extends State<WidgetSignature> {
  ByteData _img = ByteData(0);
  File _image;
  var color = Colors.black;
  var strokeWidth = 5.0;
  final _sign = GlobalKey<SignatureState>();

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Signature'),
      ),
      body: SafeArea(
        child: dataProvider.isLoading ? Center(child: CircularProgressIndicator()) : Column(
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
                    MaterialButton(
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
                          map['kontrakid'] = widget.kontrakId;
                          if (widget.signature == 'owner') {
                            map['userid_owner'] = widget.signature;
                          }
                          if (widget.signature == 'worker') {
                            map['userid_worker'] = widget.signature;
                          }
                          map['image_name'] = widget.kontrakId + '_' + widget.produkId + '_' + dataProvider.userId_;
//                          print(widget.kontrakId + '_' + widget.produkId + '_' + dataProvider.userId_);
                          dataProvider.createSignature(map);
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        )),
                    MaterialButton(
                        color: Colors.grey,
                        onPressed: () {
                          final sign = _sign.currentState;
                          sign.clear();
                          setState(() {
                            _img = ByteData(0);
                          });
                          debugPrint("cleared");
                        },
                        child: Text("Clear", style: TextStyle(color: Colors.white))),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MaterialButton(
                        onPressed: () {
                          setState(() {
                            color = color == Colors.black ? Colors.black : Colors.red;
                          });
                          debugPrint("change color");
                        },
                        child: Text("Change color")),
                    MaterialButton(
                        onPressed: () {
                          setState(() {
                            int min = 1;
                            int max = 10;
                            int selection = min + (Random().nextInt(max - min));
                            strokeWidth = selection.roundToDouble();
                            debugPrint("change stroke width to $selection");
                          });
                        },
                        child: Text("Change stroke width")),
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
  bool operator ==(Object other) =>
      identical(this, other) || other is _WatermarkPaint && runtimeType == other.runtimeType && price == other.price && watermark == other.watermark;

  @override
  int get hashCode => price.hashCode ^ watermark.hashCode;
}
