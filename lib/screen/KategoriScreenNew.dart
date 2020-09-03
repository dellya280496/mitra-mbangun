import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/Categories.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/screen/LoginScreen.dart';
import 'package:apps/screen/SubKategoriScreen.dart';
import 'package:apps/widget/bantuan/WidgetBantuan.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';

class KategoriScreenNew extends StatelessWidget {
  KategoriScreenNew({Key key, this.title}) : super(key: key);
  final title;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BlogCategories dataProvider = Provider.of<BlogCategories>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(title),
      ),
      body: dataProvider.isLoading
          ? SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: PKCardListSkeleton(),
              ),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  padding: EdgeInsets.only(left: 5, right: 5, top: 10),
                  itemCount: dataProvider.dataKategoriHome.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: InkWell(
                        onTap: () => openSubkategori(context, dataProvider.dataKategoriHome[index]),
                        child: Container(
                          width: 100,
                          padding: EdgeInsets.all(8),
                          child: ListTile(
                            leading: Image.network(
                              dataProvider.dataKategoriHome[index].icon,
                              width: 45,
                            ),
                            title: Text(dataProvider.dataKategoriHome[index].nama),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
    );
  }

  void openSubkategori(context, param) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    dataProvider.getSubKategoriByIdKategori(param.produkkategoriid);

    if (dataProvider.isLogin) {
      if (param.produkkategoriflag == '2' || param.produkkategoriflag == '3' || param.produkkategoriflag == '4') {
        Navigator.push(
            context,
            SlideRightRoute(
                page: SubKategoriScreen(
                  flag: param.produkkategoriflag,
                  namaKategori: param.produkkategorinama,
                )));
      } else if (dataProvider.userKategori == param.produkkategorinama) {
        Navigator.push(
            context,
            SlideRightRoute(
                page: SubKategoriScreen(
                  flag: param.produkkategoriflag,
                  namaKategori: param.produkkategorinama,
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
        )
          ..show(context);
        }
      } else {
      Navigator.push(context, SlideRightRoute(page: LoginScreen()));
    }
  }
}
