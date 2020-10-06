import 'dart:convert';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:apps/Utils/BottomAnimation.dart';
import 'package:apps/Utils/ThemeChanger.dart';
import 'package:apps/models/DeviceInfo.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/providers/BlocProyek.dart';
import 'package:apps/providers/Categories.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/screen/LoginScreen.dart';
import 'package:apps/screen/ProfileScreen.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:apps/screen/RequestScreen.dart';
import 'package:apps/screen/SplashScreen.dart';
import 'package:apps/widget/Aktivity/Pengajuan/WidgetPengajuanByParamList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/subjects.dart';
import 'Utils/SettingApp.dart';

const kAndroidUserAgent = 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

String selectedUrl = 'https://flutter.io';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}

// Streams are created so that app can respond to notification-related events since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject = BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject = BehaviorSubject<String>();

NotificationAppLaunchDetails notificationAppLaunchDetails;
// ignore: prefer_collection_literals
final Set<JavascriptChannel> jsChannels = [
  JavascriptChannel(
      name: 'Print',
      onMessageReceived: (JavascriptMessage message) {
        print(message.message);
      }),
].toSet();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.camera.request();
  await Permission.storage.request();
  await Permission.mediaLibrary.isGranted;
  notificationAppLaunchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  var initializationSettingsAndroid = AndroidInitializationSettings('ic_stat_name');
  // Note: permissions aren't requested here just to demonstrate that can be done later using the `requestPermissions()` method
  // of the `IOSFlutterLocalNotificationsPlugin` class
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (int id, String title, String body, String payload) async {
        didReceiveLocalNotificationSubject.add(ReceivedNotification(id: id, title: title, body: body, payload: payload));
      });
  var initializationSettings = InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    selectNotificationSubject.add(payload);
  });
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    Map<String, dynamic> deviceData;

    try {
      if (Platform.isAndroid) {
        deviceData = readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        await FlutterSession().set('deviceData', json.encode(deviceData));
      } else if (Platform.isIOS) {
        deviceData = readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
        await FlutterSession().set('deviceData', json.encode(deviceData));
      }
    } on PlatformException {
      deviceData = <String, dynamic>{'Error:': 'Failed to get platform version.'};
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

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
        ),
        ChangeNotifierProvider<BlocProyek>(
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
          '/widget': (_) => new WebviewScaffold(
                url: baseURLMobile + '?email=',
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
