import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/providers/BlocProyek.dart';
import 'package:apps/screen/ChekListScreen.dart';
import 'package:apps/screen/HomeScreen.dart';
import 'package:apps/screen/MyAdsScreen.dart';
import 'package:apps/screen/ProdukScreen.dart';
import 'package:apps/screen/ProfileScreen.dart';
import 'package:apps/screen/ProyekScreen.dart';
import 'package:apps/screen/RequestScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';

class BottomAnimateBar extends StatefulWidget {
  @override
  _BottomAnimateBarState createState() => _BottomAnimateBarState();
}

class _BottomAnimateBarState extends State<BottomAnimateBar> {
  // Properties & Variables needed

  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    ProfileScreen(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen(); // Our first view in viewport

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
        bottomNavigationBar: BottomAppBar(
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
                      blocOrder.getCart();
                      blocOrder.setIdUser();
                      blocProyek.getRecentProyek();
                      blocOrder.getCountSaleByParam({'id_toko': blocAuth.idToko.toString()});
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

                    String currentIdProvinsi = await LocalStorage.sharedInstance.readValue('idProvinsi');
                    String currentIdKota = await LocalStorage.sharedInstance.readValue('idKota');
                    String currentIdKecamatan = await LocalStorage.sharedInstance.readValue('idKecamatan');
                    var param = {
                      'aktif': '1',
                      'status': 'setuju',
                      'status_pembayaran_survey': 'terbayar',
                      'limit': blocProduk.limit.toString(),
                      'offset': blocProduk.offset.toString()
                    };
//                    blocProduk.getAllProductByParam(param);

                    blocProyek.getAllProyekByParam(param);
                    blocAuth.checkSession();
                    blocOrder.getCart();
                    blocOrder.getCountSaleByParam({'id_toko': blocAuth.idToko.toString()});
                    setState(() {
                      currentScreen = ProyekScreen(
                          namaKategori: 'Semua',
                          param: param
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
                      blocOrder.getCart();
                      blocOrder.setIdUser();
                      blocOrder.getCountSaleByParam({'id_toko': blocAuth.idToko.toString()});
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
                    blocOrder.getCart();
                    blocOrder.setIdUser();
                    blocOrder.getCountSaleByParam({'id_toko': blocAuth.idToko.toString()});
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
        ),
      ),
    );
  }
}
