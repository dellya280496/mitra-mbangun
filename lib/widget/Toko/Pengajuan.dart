import 'dart:async';

import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:provider/provider.dart';

class Pengajuan extends StatefulWidget {
  Pengajuan({Key key}) : super(key: key);

  @override
  _PengajuanState createState() => _PengajuanState();
}

class _PengajuanState extends State<Pengajuan> {
  bool loading = true;
  Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    loading = true;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Buka Toko'),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return WebviewScaffold(
            url: baseURLMobile+'/welcome?email=' + 'email',
            withZoom: true,
            javascriptChannels: <JavascriptChannel>[
              JavascriptChannel(
                  name: 'Print',
                  onMessageReceived: (JavascriptMessage msg) {
                    if (msg.message == 'kelolaToko') {
                      Navigator.pop(context);
                    }
                  }),
            ].toSet(),
            scrollBar: true,
            allowFileURLs: true,
            withJavascript: true,
            withLocalStorage: true,
            hidden: true,
            initialChild: Container(
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      ),
    );
  }
}
