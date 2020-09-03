import 'package:apps/Utils/values/colors.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/widget/Profile/TopContainer.dart';
import 'package:apps/widget/Profile/WidgetMyFavorite.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class ProfileWorkerScreen extends StatelessWidget {
  ProfileWorkerScreen({Key key}) : super(key: key);

  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(color: AppColors.kDarkBlue, fontSize: 20.0, fontWeight: FontWeight.w700, letterSpacing: 1.2),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Detail Profile'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainer(
              height: 150,
              width: width,
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
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
                                dataProvider.userFoto == null ? dataProvider.fotoNull : dataProvider.userFoto,
                                fit: BoxFit.cover,
                                width: 80,
                              ),
                            )),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            width: MediaQuery.of(context).size.width * 0.65,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                !dataProvider.verified ? Container() : Container(child: Image(width: 18, fit: BoxFit.contain, image: new AssetImage('assets/icons/verified.png'))),
                                Container(
//                                  width: 100,
                                  margin: EdgeInsets.only(left: dataProvider.verified ? 5 : 0),
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    text: TextSpan(
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: AppColors.kDarkBlue,
                                          fontWeight: FontWeight.w800,
                                        ),
                                        text: dataProvider.userNama),
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
                                  color: Colors.grey[800],
                                ),
                                text: dataProvider.userEmail,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ]),
            ),
            !dataProvider.verified
                ? Container()
                : Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    subheading('Detail Akun'),
                                    GestureDetector(
                                      onTap: () {},
                                      child: CircleAvatar(
                                        radius: 25.0,
                                        backgroundColor: AppColors.mainColor,
                                        child: Icon(
                                          Icons.perm_contact_calendar,
                                          size: 20.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15.0),
                                dataProvider.userKategori == null
                                    ? WidgetMyFavorite(
                                        icon: Icons.alarm,
                                        iconBackgroundColor: AppColors.kRed,
                                        title: '(Belum terdaftar)',
                                        subtitle: 'Belum terdaftar',
                                      )
                                    : WidgetMyFavorite(
                                        icon: Icons.alarm,
                                        iconBackgroundColor: AppColors.kRed,
                                        title: '(${dataProvider.userKategori})',
                                        subtitle: dataProvider.userSubKategori,
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
}
