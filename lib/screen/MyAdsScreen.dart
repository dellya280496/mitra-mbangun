import 'package:apps/Utils/WidgetErrorConnection.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/widget/Aktivity/Pengajuan/widgetPengajuanList.dart';
import 'package:apps/widget/Aktivity/WidgetListPenawaran.dart';
import 'package:apps/widget/Aktivity/WidgetListSelesai.dart';
import 'package:apps/widget/Login/LoginWidget.dart';
import 'package:apps/widget/Aktivity/WidgetListProses.dart';
import 'package:apps/widget/Pendaftaran/WidgetTunggu.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAdsScreen extends StatefulWidget {
  @override
  _MyAdsScreenState createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  @override
  Widget build(BuildContext context) {
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    AppBar appBar = AppBar(
      elevation: 0.0,
      backgroundColor: Colors.cyan[700],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Container(
          padding: EdgeInsets.all(5),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              isScrollable: true,
              labelColor: Color(0xffb16a085),
              unselectedLabelColor: Colors.white,
              indicatorPadding: EdgeInsets.all(10),
              indicatorColor: Color(0xffb16a085),
              indicator: new BubbleTabIndicator(
                indicatorHeight: 30.0,
                indicatorColor: Colors.grey[200],
                tabBarIndicatorSize: TabBarIndicatorSize.tab,
              ),
              tabs: [
                Tab(
                  child: Text(
                    'Penawaran',
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                Tab(
                  child: Text(
                    'Proses',
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                Tab(
                  child: Text(
                    'Selesai',
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Aktivitas Saya',
            style: TextStyle(fontSize: 25, letterSpacing: 1, fontFamily: "WorkSansMedium", color: Colors.white),
          ),
        ],
      ),
    );
    return !blocAuth.connection
        ? WidgetErrorConection()
        : !blocAuth.isLogin
            ? Container(
                color: Colors.white,
                child: LoginWidget(
                  primaryColor: Colors.white,
                  backgroundColor: Colors.white,
                  page: '/BottomNavBar',
                ),
              )
            : !blocAuth.isMitra
                ? Scaffold(body: WidgetTunggu())
                : DefaultTabController(
                    length: 3,
                    child: Scaffold(
                      appBar: appBar,
                      body: Container(
                        child: TabBarView(
                          children: [
                            Container(child: WidgetListPenawaran(title: 'penawaran')),
                            Container(child: WidgetListProses(title: 'proses')),
                            Container(
                                child: WidgetListSelesai(
                              title: 'selesai',
                            )),
                          ],
                        ),
                      ),
                    ),
                  );
  }
}
