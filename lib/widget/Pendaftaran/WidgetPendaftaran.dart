import 'dart:async';
import 'dart:convert';

import 'package:apps/Utils/BottomAnimation.dart';
import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_session/flutter_session.dart';
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
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    // TODO: implement initState
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
    return WebviewScaffold(
      url: baseURLMobile + '/pendaftaranmitra?no_hp=' + blocAuth.phoneNumber.toString(),
      withZoom: false,
      clearCache: true,
      javascriptChannels: <JavascriptChannel>[
        JavascriptChannel(
            name: 'Print',
            onMessageReceived: (JavascriptMessage msg) {
              print('respoonse');
              var result = json.decode(msg.message);
              print(result['meta']['id_mitra']);
              if (result['meta']['success']) {
                var fcm_token = FlutterSession().get('fcm_token');
                fcm_token.then((value) async {
                  blocAuth.setFcmToken(result['meta']['id_mitra'].toString(), value.toString());
                });
                blocAuth.checkSession();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomAnimateBar()));
              }
            }),
      ].toSet(),
      scrollBar: false,
      allowFileURLs: true,
      withJavascript: true,
      withLocalStorage: true,
      hidden: false,
      initialChild: Container(
        child: const Center(
          child: Text('Waiting.....'),
        ),
      ),
    );
  }
}
