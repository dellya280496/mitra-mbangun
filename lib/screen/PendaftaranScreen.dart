import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/widget/Pendaftaran/WidgetPendaftaran.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Pendaftaran'),
        actions: [
          IconButton(
            onPressed: () {
              blocAuth.handleSignOut();
            },
            icon: Icon(Icons.exit_to_app, color: Colors.grey[400], size: 20.0),
          ),
        ],
      ),
      body: WidgetPendaftaran(),
    );
  }
}
