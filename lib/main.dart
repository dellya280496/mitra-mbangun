import 'package:apps/Utils/BottomAnimation.dart';
import 'package:apps/Utils/ThemeChanger.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/providers/BlocProyek.dart';
import 'package:apps/providers/Categories.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/screen/LoginScreen.dart';
import 'package:apps/screen/ProfileScreen.dart';
import 'package:apps/screen/RequestScreen.dart';
import 'package:apps/screen/SplashScreen.dart';
import 'package:apps/widget/Aktivity/Pengajuan/WidgetPengajuanByParamList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:provider/provider.dart';

const kAndroidUserAgent = 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

String selectedUrl = 'https://flutter.io';

// ignore: prefer_collection_literals
final Set<JavascriptChannel> jsChannels = [
  JavascriptChannel(
      name: 'Print',
      onMessageReceived: (JavascriptMessage message) {
        print(message.message);
      }),
].toSet();

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
//    print(BlocAuth().currentUser.email.toString());
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DataProvider>(
          create: (_) => DataProvider(),
        ),
        ChangeNotifierProvider<BlogCategories>(
          create: (_) => BlogCategories(),
        ),
        ChangeNotifierProvider<BlocAuth>(
          create: (_) => BlocAuth(),
        ),
        ChangeNotifierProvider<BlocProduk>(
          create: (_) => BlocProduk(),
        ),ChangeNotifierProvider<BlocProyek>(
          create: (_) => BlocProyek(),
        ),
        ChangeNotifierProvider<BlocProfile>(
          create: (_) => BlocProfile(),
        ),
        ChangeNotifierProvider<BlocOrder>(
          create: (_) => BlocOrder(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Theme Provider',
        theme: light,
        home: SplashScreen(),
        initialRoute: '/',
        routes: {
          '/widget': (_) =>
          new WebviewScaffold(
            url: 'https://mobile.m-bangun.com?email=',
            appBar: new AppBar(
              title: const Text('Pembukaan toko'),
            ),
            withZoom: true,
            javascriptChannels: jsChannels,
            allowFileURLs: true,
            withJavascript: true,
            withLocalStorage: true,
            hidden: true,
            initialChild: Container(
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
//          '/splace-screen': (context) => SplaceScreen(),
          '/login': (context) => LoginScreen(),
          '/request': (context) => RequestScreen(),
          '/profile': (context) => ProfileScreen(),
          '/BottomNavBar': (context) => BottomAnimateBar(),
          '/New': (context) => WidgetPengajuanByParamList(),
        },
//            builder: (BuildContext context, Widget widget) {
//              final mediaQuery = MediaQuery.of(context);
//              return new Padding(
//                child: widget,
//                padding: new EdgeInsets.only(
//                    bottom: getSmartBannerHeight(mediaQuery)),
//              );
//            },
      ),
    );
  }
}
