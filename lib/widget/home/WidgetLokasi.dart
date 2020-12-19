import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/Utils/TitleHeader.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/models/KotaM.dart';
import 'package:apps/models/ProvinsiM.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/screen/ChatScreen.dart';
import 'package:apps/screen/Notification.dart';
import 'package:apps/widget/Home/WidgetSelectLokasi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class WidgetLokasi extends StatefulWidget {
  WidgetLokasi({Key key}) : super(key: key);

  @override
  _WidgetLokasiState createState() {
    return _WidgetLokasiState();
  }
}

class _WidgetLokasiState extends State<WidgetLokasi> {
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
  String idKota;
  String idProvinsi;
  String namaProvinsi, namaKota, namaKecamatan;
  var dataKota = List<KotaM>();
  var dataProvinsi = List<ProvinsiM>();

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
    BlocProduk blocProduk = Provider.of<BlocProduk>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    var kecamatan = blocProduk.namaKecamatan == null ? '' : blocProduk.namaKecamatan.toLowerCase();
    var kota = blocProduk.namaKota == null ? '' : blocProduk.namaKota.toLowerCase();
    var provinsi = blocProduk.namaProvinsi == null ? '' : blocProduk.namaProvinsi.toLowerCase();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 50,
              width: 50,
              margin: EdgeInsets.only(bottom: 6, top: 5),
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                gradient: new LinearGradient(
                    colors: [Color(0xffb16a085).withOpacity(0.1), Colors.white],
                    begin: const FractionalOffset(7.0, 10.1),
                    end: const FractionalOffset(0.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              child: new Center(
                child: Image(width: 35, fit: BoxFit.fill, image: new AssetImage('assets/logo.png')),
              ),
            ),
            Container(
              width: 5,
            ),
            TitleHeader(
              title: "Mitra Mbangun",
              color: Colors.white,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        blocAuth.getNotification();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationScreen(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                    ),
                    new Positioned(
                      top: 5.0,
                      right: 5.0,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                        alignment: Alignment.center,
                        child: Text(
                          blocAuth.coundNotification.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 8),
                        ),
                      ),
                    )
                  ],
                ),
                Stack(
                  children: <Widget>[
                    IconButton(
                      onPressed: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen()));
                      },
                      icon: Icon(
                        Icons.message,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        )
        // Stack(
        //   children: <Widget>[
        //     IconButton(
        //       onPressed: () {
        //         blocAuth.getNotification();
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => NotificationScreen(),
        //           ),
        //         );
        //       },
        //       icon: Icon(
        //         Icons.notifications,
        //         color: Colors.white,
        //       ),
        //     ),
        //     new Positioned(
        //       top: 5.0,
        //       right: 5.0,
        //       child: Container(
        //         padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        //         decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
        //         alignment: Alignment.center,
        //         child: Text(
        //           blocAuth.coundNotification.toString(),
        //           style: TextStyle(color: Colors.white, fontSize: 8),
        //         ),
        //       ),
        //     )
        //   ],
        // ),
      ],
    );
  }

  _modalListKota() async {
    String currentIdProvinsi = await LocalStorage.sharedInstance.readValue('idProvinsi');
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    blocProfile.clearDataCity();
    Navigator.push(
      context,
      SlideRightRoute(page: WidgetSelectLokasi()),
    ).then((value) {
      Provider.of<BlocProduk>(context).getCurrentLocation();
    });
  }
}
