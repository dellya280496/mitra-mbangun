import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/widget/Pendaftaran/WidgetPendaftaran.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:provider/provider.dart';

class PendaftaranScreen extends StatefulWidget {
  PendaftaranScreen({Key key}) : super(key: key);

  @override
  _PendaftaranScreenState createState() {
    return _PendaftaranScreenState();
  }
}

class _PendaftaranScreenState extends State<PendaftaranScreen> {
  @override
  void initState() {
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
    final flutterWebviewPlugin = new FlutterWebviewPlugin();
    var appBar = AppBar(
      elevation: 0,
      title: Text('Pendaftaran'),
      actions: [
        IconButton(
          onPressed: () {
            flutterWebviewPlugin.reload();
          },
          icon: Icon(Icons.refresh, color: Colors.grey[400], size: 20.0),
        ),
        IconButton(
          onPressed: () {
            blocAuth.handleSignOut();
          },
          icon: Icon(Icons.exit_to_app, color: Colors.grey[400], size: 20.0),
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: WidgetPendaftaran(),
    );
  }

  Future<bool> _onWillPop() {
    {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Anda yakin!'),
          content: Text('Ingin keluar dari aplikasi?'),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No'),
            ),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(true),
              /*Navigator.of(context).pop(true)*/
              child: Text('Yes'),
            ),
          ],
        ),
      );
    }
  }
}
