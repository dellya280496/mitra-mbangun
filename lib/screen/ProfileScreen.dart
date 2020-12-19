import 'package:apps/Utils/BottomAnimation.dart';
import 'package:apps/Utils/WidgetErrorConnection.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/Utils/values/colors.dart';
import 'package:apps/main.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/providers/BlocProyek.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/screen/LoginScreen.dart';
import 'package:apps/screen/ProyekScreen.dart';
import 'package:apps/screen/SplashScreen.dart';
import 'package:apps/screen/TokoSayaScreen.dart';
import 'package:apps/widget/Login/LoginWidget.dart';
import 'package:apps/widget/Pendaftaran/WidgetTunggu.dart';
import 'package:apps/widget/Pengajuan/component/WidgetCardMenu.dart';
import 'package:apps/widget/Profile/TopContainer.dart';
import 'package:apps/widget/Profile/WidgetMyFavorite.dart';
import 'package:apps/widget/Profile/WidgetUpdateProfile.dart';
import 'package:apps/widget/Toko/Pengajuan.dart';
import 'package:apps/widget/penghasilan/WidgetDetailPenghasilan.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key key}) : super(key: key);

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
      body: !blocAuth.connection
          ? WidgetErrorConection()
          : blocAuth.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              :!blocAuth.isMitra
                      ? WidgetTunggu()
                      : SafeArea(
                          child: Column(
                            children: <Widget>[
                              TopContainer(
                                height: 200,
                                width: width,
                                child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Profil',
                                        style: TextStyle(
                                          fontSize: 22.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () async{
                                             await blocAuth.handleSignOut();
                                             await blocProyek.clearlistProyeks();
                                             await blocProyek.clearRecentProyek();
                                             await Provider.of<BlocOrder>(context).clearCountOrder();
                                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
                                              => MyApp()));
                                            },
                                            icon: Icon(Icons.exit_to_app, color: Colors.grey[400], size: 20.0),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        CircularPercentIndicator(
                                          radius: 70.0,
                                          lineWidth: 5.0,
                                          animation: true,
                                          percent: 0.75,
                                          circularStrokeCap: CircularStrokeCap.round,
                                          progressColor: AppColors.kRed,
                                          backgroundColor: AppColors.kDarkYellow,
                                          center: Container(
                                              width: 60.0,
                                              height: 60.0,
                                              child: ClipOval(
                                                child: Image.network(
                                                   blocAuth.currentUserChat.avatar,
                                                  fit: BoxFit.contain,
                                                ),
                                              )),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: 5),
                                              width: MediaQuery.of(context).size.width * 0.5,
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  !dataProvider.verified
                                                      ? Container()
                                                      : Container(child: Image(width: 18, fit: BoxFit.contain, image: new AssetImage('assets/icons/verified.png'))),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width * 0.4,
                                                    margin: EdgeInsets.only(left: dataProvider.verified ? 5 : 0),
                                                    child: RichText(
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      text: TextSpan(
                                                          style: TextStyle(
                                                            fontSize: 16.0,
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w800,
                                                          ),
                                                          text: blocAuth.currentUserChat.name.toString()),
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: 5),
                                              child: RichText(
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                strutStyle: StrutStyle(fontSize: 12.0),
                                                text: TextSpan(
                                                  style: TextStyle(
                                                    color: Colors.grey[300],
                                                  ),
                                                  text: blocAuth.detailMitra[0].email,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        IconButton(icon: Icon(Icons.edit, size: 20,color: Colors.white,), onPressed: (){
                                          Navigator.push(context, SlideRightRoute(page: WidgetUpdateProfile()));
                                        })
                                      ],
                                    ),
                                  )
                                ]),
                              ),
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
                                                                      status: 'survey',
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
//                                                                blocProfile.getPenghasilanByParam({'id_toko': blocAuth.idToko.toString()});
                                                                Navigator.push(
                                                                  context,
                                                                  SlideRightRoute(
                                                                    page: ProyekScreen(
                                                                      namaKategori: 'Terbit',
                                                                      param: param,
                                                                      status: 'setuju',
                                                                    ),
                                                                  ),
                                                                );
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
//                                                                blocProfile.getPenghasilanByParam({'id_toko': blocAuth.idToko.toString()});
                                                                Navigator.push(
                                                                    context,
                                                                    SlideRightRoute(
                                                                        page: ProyekScreen(
                                                                      namaKategori: 'Tanda Tangan',
                                                                      param: param,
                                                                      status: 'proses',
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
