import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/widget/Pengajuan/component/WidgetCardMenu.dart';
import 'package:apps/widget/Project/PengajuanProject.dart';
import 'package:apps/widget/Toko/Pengajuan.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class WidgetMenu extends StatelessWidget {
  WidgetMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              blocAuth.statusToko == '0'
                  ? InkWell(
                      onTap: () => _pengajuan(context),
                      child: WidgetCardMenu(
                        title: 'Buka Toko',
                        color: Colors.amber[800],
                        thumbnail: 'assets/icons/store.png',
                        deskripsi: 'Anda bisa menjual produk anda secara eksklusif di m-Bangun, cukup mengisi detail produk anda dan produk anda siap di untuk publish!',
                      ),
                    )
                  : Container(),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    SlideRightRoute(
                      page: PengajuanProject(),
                    ),
                  );
                },
                child: WidgetCardMenu(
                  title: 'Pengajuan Proyek',
                  color: Colors.cyan[600],
                  thumbnail: 'assets/icons/worker.png',
                  deskripsi: 'Mau benerin perabotan rumah atau appartemen? kesulitan cari tukang di tengah kota? kami siap datang untuk melakukan survey!',
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  _pengajuan(context) {
    Navigator.push(context, SlideRightRoute(page: Pengajuan()));
  }

  openSubkategori(chilrdern) {}

  _launchURL(String url, context) async {
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    if (await canLaunch(url)) {
      await launch(url + '?email=' + blocAuth.currentUser.email);
    } else {
      throw 'Could not launch $url';
    }
  }

  _openScreen(String s, BuildContext context) {
    if (s == 'pengajuan_toko') {
      _launchURL(baseURLMobile, context);
    }
  }
}
