import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/widget/Login/LoginWidget.dart';
import 'package:apps/widget/Pengajuan/WidgetPengajuan.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class RequestScreen extends StatefulWidget {
  RequestScreen({Key key}) : super(key: key);

  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  bool isLogin = false;
  String title = '';

  @override
  void initState() {
//    LocalStorage.sharedInstance.deleteValue('session');
    _chekSession();
    super.initState();
  }

  _chekSession() async {
    await new Future.delayed(const Duration(seconds: 1));
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    if (blocAuth.isLogin) {
      setState(() {
        title = 'Hai! Apa yang anda butuhkan?';
      });
    } else {
      setState(() {
        title = 'Silahkan login';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    var appBar = AppBar(
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.clear,
          color: Colors.black,
        ),
      ),
      title: Text(title),
    );
    return Scaffold(
      appBar: appBar,
      body: !blocAuth.isLogin
          ? Container(
              color: Colors.white,
              child: LoginWidget(
                primaryColor: Color(0xFFb16a085),
                backgroundColor: Colors.white,
                page: '/request',
              ),
            )
          : ModalProgressHUD(
              inAsyncCall: dataProvider.isLoading,
              child: WidgetPengajuan(height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top))),
    );
  }
}
