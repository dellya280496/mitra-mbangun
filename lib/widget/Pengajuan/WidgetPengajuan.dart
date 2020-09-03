import 'package:apps/models/jenis_pengajuan.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/widget/home/WidgetMenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetPengajuan extends StatefulWidget {
  final double height;

  WidgetPengajuan({Key key, this.height}) : super(key: key);

  @override
  _WidgetPengajuanState createState() {
    return _WidgetPengajuanState();
  }
}

class _WidgetPengajuanState extends State<WidgetPengajuan> {
  var dataJenisPengajuan = new List<JenisPengajuan>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String jenispengajuanid;

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    // TODO: implement build
    return SingleChildScrollView(
      child: Column(
        children: [
          WidgetMenu(),
        ],
      ),
    );
  }
}
