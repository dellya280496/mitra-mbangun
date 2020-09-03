import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/Utils/TitleHeader.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/models/KotaM.dart';
import 'package:apps/models/ProvinsiM.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/providers/DataProvider.dart';
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
              title: "m-Bangun",
              color: Colors.white,
            )
          ],
        ),

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
