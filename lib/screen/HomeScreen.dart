import 'dart:io';

import 'package:apps/Utils/HeaderAnimation.dart';
import 'package:apps/Utils/WidgetErrorConnection.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/providers/BlocProyek.dart';
import 'package:apps/providers/Categories.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/screen/RequestScreen.dart';
import 'package:apps/widget/Home/WidgetLokasi.dart';
import 'package:apps/widget/Home/WidgetNews.dart';
import 'package:apps/widget/home/WidgetKategori.dart';
import 'package:apps/widget/home/WidgetOffialStore.dart';
import 'package:apps/widget/home/WidgetRecentProduct.dart';
import 'package:apps/widget/home/WidgetSLider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
  String PLAY_STORE_URL = 'https://play.google.com/apps';
  String APP_STORE_URL = 'https://play.google.com/store/apps/details?id=com.bangun.apps';
  String namaProfile;
  String deskripsi;
  bool disabledTap = false;

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
    // TODO: implement build

    DataProvider dataProvider = Provider.of<DataProvider>(context);
    BlogCategories blogCategories = Provider.of<BlogCategories>(context);
    BlocProduk blocProduk = Provider.of<BlocProduk>(context);
    BlocProyek blocProyek = Provider.of<BlocProyek>(context);
    _showVersionDialog();
    AppBar appBar = AppBar(
      backgroundColor: Colors.cyan[700],
      elevation: 0,
      title: WidgetLokasi(),
    );
    double height = appBar.preferredSize.height;
    return Scaffold(
      appBar: appBar,
      body: !blocProduk.connection
          ? WidgetErrorConection()
          : Container(
              margin: EdgeInsets.only(bottom: 50),
              color: Colors.white10.withOpacity(0.2),
              child: Stack(
                children: [
                  HeaderAnimation(),
                  Container(
                    margin: EdgeInsets.only(top: 100),
                    height: MediaQuery.of(context).size.height - 100 - height - MediaQuery.of(context).padding.top - 50,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          WidgetSlider(
                            blocProduk: blocProduk,
                          ),
                          WidgetRecentProduct(
                            blocProyek: blocProyek,
                          ),
                          WidgetNews(),
                        ],
                      ),
                    ),
                  ),
                  WidgetKategori(),
                ],
              ),
            ),
    );
  }

  _openRequest() {
    Navigator.push(
        context,
        PageRouteTransition(
          animationType: AnimationType.slide_up,
          builder: (context) => RequestScreen(),
        ));
  }

//  syncVersion() async {
//    await new Future.delayed(const Duration(seconds: 1));
//    DataProvider dataProvider = Provider.of<DataProvider>(context);
//    var newVersion = await dataProvider.newVersion;
//    if (newVersion > dataProvider.currentVersion) {
//      _showVersionDialog();
//    }
//  }

  _showVersionDialog() async {
//    await new Future.delayed(const Duration(seconds: 1));
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    final PackageInfo info = await PackageInfo.fromPlatform();
    var currentVersion = info.version;
    var newVersion = blocAuth.newVersion;
    if (blocAuth.showVersionDialog) {
      blocAuth.setShowVersionDialog(false);
      await showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          String title = "Pembaruan baru tersedia";
          String message = "Pembaruan versi tersedia! $newVersion, versi saat ini adalah $currentVersion";
          String btnLabel = "Perbarui";
          String btnLabelCancel = "Nanti";
          return Platform.isIOS
              ? WillPopScope(
            onWillPop: () {},
            child: new CupertinoAlertDialog(
              title: Text(title),
              content: Column(
                children: <Widget>[
                  Text("Pembaruan versi tersedia! $newVersion, versi saat ini adalah $currentVersion"),
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(btnLabel),
                  onPressed: () => _launchURL(APP_STORE_URL),
                ),
              ],
            ),
          )
              : WillPopScope(
            onWillPop: () {},
            child: new CupertinoAlertDialog(
              title: Text(title),
              content: Column(
                children: <Widget>[
                  Text("Pembaruan versi tersedia! $newVersion, versi saat ini adalah $currentVersion"),
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(btnLabel),
                  onPressed: () => _launchURL(PLAY_STORE_URL),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

