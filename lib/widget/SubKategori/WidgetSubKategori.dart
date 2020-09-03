import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/screen/ProdukScreen.dart';
import 'package:apps/widget/bantuan/WidgetBantuan.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetSubKategori extends StatelessWidget {
  WidgetSubKategori({Key key, this.flag}) : super(key: key);
  final flag;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          padding: EdgeInsets.only(left: 5, right: 5, top: 10),
          itemCount: dataProvider.getDataSubKategori.length,
          itemBuilder: (context, index) {
            return Card(
              child: InkWell(
                onTap: () => _openListProdukBySubKategori(context, dataProvider.getDataSubKategori[index]),
                child: Container(
                  width: 100,
                  padding: EdgeInsets.all(8),
                  child: ListTile(
                    leading: Image.network(
                      dataProvider.getDataSubKategori[index].produkkategorisubthubmnail == null
                          ? 'https://previews.123rf.com/images/urfandadashov/urfandadashov1809/urfandadashov180901275/109135379-photo-not-available-vector-icon-isolated-on-transparent-background-photo-not-available-logo-concept.jpg'
                          : dataProvider.getDataSubKategori[index].produkkategorisubthubmnail,
                      width: 45,
                    ),
                    title: Text(dataProvider.getDataSubKategori[index].produkkategorisubnama),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  _openListProdukBySubKategori(context, param) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    dataProvider.setidSubKategori(param.produkkategorisubid);
    dataProvider.getAllProdukListByParam();
    if (flag == '2' || flag == '3' || flag == '4') {
      Navigator.push(
          context,
          SlideRightRoute(
              page: ProdukScreen(
                namaKategori: param.produkkategorisubnama,
                idSubKategori: param.produkkategorisubid,
              )));
    } else if (dataProvider.userSubKategori == param.produkkategorisubnama) {
      Navigator.push(
          context,
          SlideRightRoute(
              page: ProdukScreen(
            namaKategori: param.produkkategorisubnama,
            idSubKategori: param.produkkategorisubid,
          )));
    } else {
      Navigator.push(
        context,
        SlideRightRoute(
          page: WidgetBantuan(
          ),
        ),
      );
      Flushbar(
        title: "Error",
        message: "Silahkan login / member anda tidak sesuai",
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        flushbarPosition: FlushbarPosition.BOTTOM,
        icon: Icon(
          Icons.assignment_turned_in,
          color: Colors.white,
        ),
      )..show(context);
    }
  }
}
