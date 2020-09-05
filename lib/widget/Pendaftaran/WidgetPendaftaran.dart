import 'dart:async';
import 'dart:convert';

import 'package:apps/Utils/BottomAnimation.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:provider/provider.dart';

class WidgetPendaftaran extends StatefulWidget {
  WidgetPendaftaran({Key key}) : super(key: key);

  @override
  _PendaftaranState createState() => _PendaftaranState();
}

class _PendaftaranState extends State<WidgetPendaftaran> {
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
//      appBar: AppBar(
//        elevation: 0,
//        title: Text('Buka Toko'),
//      ),
      body: Builder(
        builder: (BuildContext context) {
          return WebviewScaffold(
            url: 'https://mobile.m-bangun.com/pendaftaranmitra?email=' + blocAuth.currentUser.email.toString() + '&id=' + blocAuth.currentUser.id.toString(),
            withZoom: true,
            javascriptChannels: <JavascriptChannel>[
              JavascriptChannel(
                  name: 'Print',
                  onMessageReceived: (JavascriptMessage msg) {
                    print(msg.message);
                    var result = json.decode(msg.message);

                    if (result['meta']['success']) {
                      blocAuth.checkSession();
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
