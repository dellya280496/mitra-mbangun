import 'dart:async';

import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PengajuanProject extends StatefulWidget {
  PengajuanProject({Key key}) : super(key: key);

  @override
  _PengajuanProjectState createState() => _PengajuanProjectState();
}

class _PengajuanProjectState extends State<PengajuanProject> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  bool loading = true;
  Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    loading = true;
//    _initializeTimer();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  void _initializeTimer() async {
    await new Future.delayed(const Duration(seconds: 1));
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    timer = Timer.periodic(const Duration(seconds: 5), (__) {
      var result = blocProfile.getTokoByParam({'id_user': blocAuth.idUser.toString()});
      result.then((value) {
        if (value['meta']['success']) {
          Navigator.pop(context);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Pengajuan Proyek'),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return WebviewScaffold(
            url: 'https://mobile.m-bangun.com/Projek?email=' + blocAuth.currentUser.email.toString(),
            withZoom: false,
            clearCache: true,
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
