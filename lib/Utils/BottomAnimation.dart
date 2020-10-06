import 'package:apps/main.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/providers/BlocProyek.dart';
import 'package:apps/screen/ActivitasSurvey.dart';
import 'package:apps/screen/HomeScreen.dart';
import 'package:apps/screen/MyAdsScreen.dart';
import 'package:apps/screen/Notification.dart';
import 'package:apps/screen/ProfileScreen.dart';
import 'package:apps/screen/ProyekScreen.dart';
import 'package:apps/screen/RequestScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';

class BottomAnimateBar extends StatefulWidget {
  @override
  _BottomAnimateBarState createState() => _BottomAnimateBarState();
}

class _BottomAnimateBarState extends State<BottomAnimateBar> {
  // Properties & Variables needed
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  int currentTab = 0; // to keep track of active tab index
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen(); // Our first view in viewport\
  @override
  void initState() {
    _requestIOSPermissions();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _showNotification(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
//        _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
//        _navigateToItemDetail(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) async {
      await FlutterSession().set('fcm_token', token);
      assert(token != null);
    });
    super.initState();
    Future.delayed(Duration.zero).then((_) async {
      BlocProyek blocProyek = Provider.of<BlocProyek>(context);
      BlocAuth blocAuth = Provider.of<BlocAuth>(context);
      if (blocAuth.survey) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
      } else {
        currentScreen = HomeScreen();
      }
    });
  }
  void _requestIOSPermissions() {
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationSubject.stream.listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null ? Text(receivedNotification.title) : null,
          content: receivedNotification.body != null ? Text(receivedNotification.body) : null,
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Ok'),
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationScreen(),
                  ),
                );
              },
            )
          ],
        ),
      );
    });
  }

  void _configureSelectNotificationSubject() {
    print('select');
    selectNotificationSubject.stream.listen((String payload) async {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NotificationScreen()),
      );
    });
  }

  Future<void> _showNotification(message) async {
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    var androidPlatformChannelSpecifics =
    AndroidNotificationDetails('your channel id', 'your channel name', 'your channel description', importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, message['notification']['title'], message['notification']['body'], platformChannelSpecifics, payload: 'item x');
    blocAuth.getNotification();
  }
  @override
  void dispose() {
    super.dispose();
  }

  _openRequest() {
    Navigator.push(
        context,
        PageRouteTransition(
          animationType: AnimationType.slide_up,
          builder: (context) => RequestScreen(),
        ));
  }

  Future<bool> _onWillPop() {
    if (currentTab == 0) {
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
          ) ??
          false;
    } else {
      setState(() {
        currentScreen = HomeScreen();
        currentTab = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProduk blocProduk = Provider.of<BlocProduk>(context);
    BlocProyek blocProyek = Provider.of<BlocProyek>(context);
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    int countAktivitas = 0;
    countAktivitas = blocOrder.countMenunggu +
        blocOrder.countMenungguKonfirmasi +
        blocOrder.countDikemas +
        blocOrder.countDikirim +
        blocOrder.countSaleMenungguKonfirmasi +
        blocOrder.countSaleDikemas +
        blocOrder.countSaleDikirim;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        extendBody: true,
        body: PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),
        backgroundColor: Colors.grey.withOpacity(0.3),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: blocAuth.survey ? bottomSurvey(countAktivitas) : bottomMitra(countAktivitas),
      ),
    );
  }

  Widget bottomSurvey(countAktivitas) {
    BlocProduk blocProduk = Provider.of<BlocProduk>(context);
    BlocProyek blocProyek = Provider.of<BlocProyek>(context);
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    return BottomAppBar(
      color: Colors.cyan[700],
      shape: CircularNotchedRectangle(),
      notchMargin: 5,
      child: Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            MaterialButton(
              minWidth: 30,
              onPressed: () {
                setState(() {
                  blocAuth.checkSession();
                  blocOrder.setIdUser();
                  blocOrder.getCountSaleByParam({'id_toko': blocAuth.idToko.toString()});
//                      blocProyek.getBidsByParam({'id_mitra': blocAuth.idUser.toString(), 'status_proyek': 'setuju'});
                  currentScreen = ActivitasSurvey(); // if user taps on this dashboard tab will be active
                  currentTab = 2;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Icon(
                        Icons.local_activity,
                        size: 25,
                        color: currentTab == 2 ? Colors.white : Colors.grey[400],
                      ),
                      countAktivitas == 0
                          ? Icon(
                              Icons.local_activity,
                              size: 25,
                              color: currentTab == 2 ? Colors.white : Colors.grey[400],
                            )
                          : new Positioned(
                              top: 0.0,
                              right: 0.0,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                                alignment: Alignment.center,
                                child: Text(
                                  countAktivitas.toString(),
                                  style: TextStyle(color: Colors.white, fontSize: 8),
                                ),
                              ),
                            )
                    ],
                  ),
                  Text(
                    'Aktivitas',
                    style: TextStyle(
                      fontSize: 11,
                      color: currentTab == 2 ? Colors.white : Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
            MaterialButton(
              minWidth: 30,
              onPressed: () {
                blocAuth.checkSession();
                blocOrder.setIdUser();
                setState(() {
                  currentScreen = ProfileScreen(); // if user taps on this dashboard tab will be active
                  currentTab = 3;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        size: 28,
                        color: currentTab == 3 ? Colors.white : Colors.grey[400],
                      ),
                    ],
                  ),
                  Text(
                    'Profil',
                    style: TextStyle(
                      fontSize: 11,
                      color: currentTab == 3 ? Colors.white : Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomMitra(countAktivitas) {
    BlocProduk blocProduk = Provider.of<BlocProduk>(context);
    BlocProyek blocProyek = Provider.of<BlocProyek>(context);
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    return BottomAppBar(
      color: Colors.cyan[700],
      shape: CircularNotchedRectangle(),
      notchMargin: 5,
      child: Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            MaterialButton(
              minWidth: 30,
              onPressed: () {
                setState(() {
                  blocAuth.checkSession();
                  blocProduk.initLoad();
                  if (blocAuth.survey) {
                    var param = {
                      'aktif': '1',
                      'status': "('survey','setuju')",
                      'status_pembayaran_survey': 'terbayar',
                      'limit': '6',
                      'offset': blocProyek.offset.toString(),
                    };
                    blocProyek.getRecentProyek(param);
                  } else {
                    var idJenisLayanan = blocAuth.listJenisLayananMitra.map((e) => e.id).toString();
                    if (idJenisLayanan != '()') {
                      var param = {
                        'aktif': '1',
                        'status': "('setuju')",
                        'status_pembayaran_survey': 'terbayar',
                        'limit': '6',
                        'offset': blocProyek.offset.toString(),
                        'id_jenis_layanan': idJenisLayanan
                      };
                      blocProyek.getRecentProyek(param);
                    } else {
                      blocProyek.clearlistProyeks();
                      blocProyek.clearRecentProyek();
                    }
                  }
                  currentScreen = HomeScreen(); // if user taps on this dashboard tab will be active
                  currentTab = 0;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Icon(
                        Icons.home,
                        size: 25,
                        color: currentTab == 0 ? Colors.white : Colors.grey[400],
                      ),
                    ],
                  ),
                  Text(
                    'Beranda',
                    style: TextStyle(
                      fontSize: 11,
                      color: currentTab == 0 ? Colors.white : Colors.grey[400],
                    ),
                  )
                ],
              ),
            ),
            MaterialButton(
              minWidth: 30,
              onPressed: () async {
                blocAuth.checkSession();
                if (blocAuth.survey) {
                  var param = {
                    'aktif': '1',
                    'status': "('survey','setuju')",
                    'status_pembayaran_survey': 'terbayar',
                    'limit': blocProyek.limit.toString(),
                    'offset': blocProyek.offset.toString(),
                  };
                  blocProyek.getAllProyekByParam(param);
                } else {
                  var idJenisLayanan = blocAuth.listJenisLayananMitra.map((e) => e.id).toString();
                  if (idJenisLayanan != '()') {
                    var param = {
                      'aktif': '1',
                      'status': "('setuju')",
                      'status_pembayaran_survey': 'terbayar',
                      'limit': blocProyek.limit.toString(),
                      'offset': blocProyek.offset.toString(),
                      'id_jenis_layanan': idJenisLayanan
                    };
                    blocProyek.getAllProyekByParam(param);
                  } else {
                    blocProyek.clearlistProyeks();
                    blocProyek.clearRecentProyek();
                  }
                }
                setState(() {
                  currentScreen = ProyekScreen(
                    namaKategori: 'Semua',
                  ); // if user taps on this dashboard tab will be active
                  currentTab = 1;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.business,
                    size: 25,
                    color: currentTab == 1 ? Colors.white : Colors.grey[400],
                  ),
                  Text(
                    'Proyek',
                    style: TextStyle(
                      fontSize: 11,
                      color: currentTab == 1 ? Colors.white : Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
            MaterialButton(
              minWidth: 30,
              onPressed: () {
                setState(() {
                  blocAuth.checkSession();
                  blocOrder.setIdUser();
                  blocOrder.getCountSaleByParam({'id_toko': blocAuth.idToko.toString()});
//                      blocProyek.getBidsByParam({'id_mitra': blocAuth.idUser.toString(), 'status_proyek': 'setuju'});
                  currentScreen = MyAdsScreen(); // if user taps on this dashboard tab will be active
                  currentTab = 2;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Icon(
                        Icons.local_activity,
                        size: 25,
                        color: currentTab == 2 ? Colors.white : Colors.grey[400],
                      ),
                      countAktivitas == 0
                          ? Icon(
                              Icons.local_activity,
                              size: 25,
                              color: currentTab == 2 ? Colors.white : Colors.grey[400],
                            )
                          : new Positioned(
                              top: 0.0,
                              right: 0.0,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                                alignment: Alignment.center,
                                child: Text(
                                  countAktivitas.toString(),
                                  style: TextStyle(color: Colors.white, fontSize: 8),
                                ),
                              ),
                            )
                    ],
                  ),
                  Text(
                    'Aktivitas',
                    style: TextStyle(
                      fontSize: 11,
                      color: currentTab == 2 ? Colors.white : Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
            MaterialButton(
              minWidth: 30,
              onPressed: () {
                blocAuth.checkSession();
                blocOrder.setIdUser();
                setState(() {
                  currentScreen = ProfileScreen(); // if user taps on this dashboard tab will be active
                  currentTab = 3;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        size: 28,
                        color: currentTab == 3 ? Colors.white : Colors.grey[400],
                      ),
                    ],
                  ),
                  Text(
                    'Profil',
                    style: TextStyle(
                      fontSize: 11,
                      color: currentTab == 3 ? Colors.white : Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
