import 'package:apps/widget/konsultasi/WidgetKonsultasi.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Konsultasi'),
      ),
      body: WidgetKonsultasi(),
    );
  }
}
