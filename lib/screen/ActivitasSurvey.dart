import 'package:apps/Utils/WidgetErrorConnection.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/Utils/values/colors.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/providers/BlocProyek.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/screen/ProyekScreen.dart';
import 'package:apps/widget/Login/LoginWidget.dart';
import 'package:apps/widget/Pendaftaran/WidgetTunggu.dart';
import 'package:apps/widget/Pengajuan/component/WidgetCardMenu.dart';
import 'package:apps/widget/Profile/TopContainer.dart';
import 'package:apps/widget/Profile/WidgetMyFavorite.dart';
import 'package:apps/widget/Toko/Pengajuan.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class ActivitasSurvey extends StatelessWidget {
  ActivitasSurvey({Key key}) : super(key: key);

  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(color: AppColors.kDarkBlue, fontSize: 20.0, fontWeight: FontWeight.w700, letterSpacing: 1.2),
    );
  }

  var dataList = ['New', 'Kontrak', 'Progress', 'Finish', 'Batal'];

  static CircleAvatar calendarIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: AppColors.kGreen,
      child: Icon(
        Icons.work,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    BlocProyek blocProyek = Provider.of<BlocProyek>(context);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Aktivitas'),
      ),
      body: !blocAuth.connection
          ? WidgetErrorConection()
          : blocAuth.isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : !blocAuth.isLogin
          ? Container(
        color: Colors.white,
        child: LoginWidget(
          primaryColor: Color(0xFFb16a085),
          backgroundColor: Colors.white,
          page: '/BottomNavBar',
        ),
      )
          : !blocAuth.isMitra
          ? WidgetTunggu()
          : SafeArea(
        child: Column(
          children: <Widget>[
                Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Divider(),
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                      child: Column(
                        children: <Widget>[
                          !blocAuth.survey
                              ? Container()
                              : Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  subheading('Daftar Proyek'),
                                ],
                              ),
                              SizedBox(height: 15.0),
                              InkWell(
                                onTap: () {
                                  var param = {
                                    'aktif': '1',
                                    'status': "('survey')",
                                    'status_pembayaran_survey': 'terbayar',
                                    'limit': blocProyek.limit.toString(),
                                    'offset': blocProyek.offset.toString(),
                                  };
                                  blocProyek.getAllProyekByParam(param);
                                  Navigator.push(
                                      context,
                                      SlideRightRoute(
                                          page: ProyekScreen(
                                            namaKategori: 'Survey',
                                            param: param,
                                              status:'proses'
                                          )));
                                },
                                child: WidgetMyFavorite(
                                  icon: Icons.people,
                                  iconBackgroundColor: Colors.red,
                                  title: 'Survey',
                                  subtitle: 'Pengajuan untuk segera di survey',
                                ),
                              ),
                              SizedBox(height: 15.0),
                              InkWell(
                                onTap: () {
                                  var param = {
                                    'aktif': '1',
                                    'status': "('setuju')",
                                    'status_pembayaran_survey': 'terbayar',
                                    'limit': blocProyek.limit.toString(),
                                    'offset': blocProyek.offset.toString(),
                                  };
                                  blocProyek.getAllProyekByParam(param);
                                  Navigator.push(
                                      context,
                                      SlideRightRoute(
                                          page: ProyekScreen(
                                            namaKategori: 'Terbit',
                                            param: param,
                                              status:'proses'
                                          )));
                                },
                                child: WidgetMyFavorite(
                                  icon: Icons.done,
                                  iconBackgroundColor: Colors.green,
                                  title: 'Terbit',
                                  subtitle: 'Pengajuan sudah di terbitkan',
                                ),
                              ),
                              SizedBox(height: 15.0),
                              InkWell(
                                onTap: () {
                                  var param = {
                                    'aktif': '1',
                                    'status': "('proses')",
                                    'status_pembayaran_survey': 'terbayar',
                                    'limit': blocProyek.limit.toString(),
                                    'offset': blocProyek.offset.toString(),
                                  };
                                  blocProyek.getAllProyekByParam(param);
                                  Navigator.push(
                                      context,
                                      SlideRightRoute(
                                          page: ProyekScreen(
                                            namaKategori: 'Tanda Tangan',
                                            param: param,
                                            status:'proses'
                                          )));
                                },
                                child: WidgetMyFavorite(
                                  icon: Icons.fingerprint_outlined,
                                  iconBackgroundColor: Colors.blue,
                                  title: 'Tanda tangan',
                                  subtitle: 'Tanda tangan mengetahui m-Bangun',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _pengajuan(BuildContext context) {
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    Navigator.push(context, SlideRightRoute(page: Pengajuan())).then((value) {
      blocAuth.checkSession();
    });
  }
}
