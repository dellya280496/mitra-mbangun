

import 'package:apps/Utils/WidgetErrorConnection.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/screen/ProdukScreen.dart';
import 'package:apps/widget/Keranjang/Keranjang.dart';
import 'package:apps/widget/Login/LoginWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckListScreen extends StatelessWidget {

  CheckListScreen({Key key}) : super(key: key);
  var dataList = ['Keranjang', 'Favorite'];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    AppBar appBar = AppBar(
      elevation: 0,
      title: Text('Daftar Menu'),
    );
    return Scaffold(
      appBar: appBar,
      body: !blocAuth.connection
          ? WidgetErrorConection()
          : !blocAuth.isLogin
              ? Container(
                  color: Colors.white,
                  child: LoginWidget(
                    primaryColor: Color(0xFFb16a085),
                    backgroundColor: Colors.white,
                    page: '/BottomNavBar',
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () => blocOrder.getCart(),
                  child: ListView.builder(
                itemCount: dataList.length,
                padding: EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  return Card(
                    child: InkWell(
                      onTap: () => _openScreen(dataList[index], context),
                      child: ListTile(
                          title: Text(dataList[index]),
                          leading: dataList[index] == 'Keranjang'
                              ? Stack(
                                  children: <Widget>[
                                    Icon(
                                      Icons.shopping_cart,
                                      size: 30,
                                    ),
                                    blocOrder.listCart.length == 0
                                        ? Container(
                                            child: Text(''),
                                          )
                                        : Positioned(
                                            top: 0.0,
                                            right: 0.0,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                                              alignment: Alignment.center,
                                              child: Text(
                                                blocOrder.listCart.length.toString(),
                                                style: TextStyle(color: Colors.white, fontSize: 8),
                                              ),
                                            ),
                                          )
                                  ],
                                )
                              : dataList[index] == 'Favorite'
                                  ? Icon(
                                      Icons.favorite,
                                      size: 30,
                                      color: Colors.pink,
                                    )
                                  : '',
                          trailing: Icon(Icons.arrow_forward_ios)),
                    ),
                  );
                },
              ),
            ),
    );
  }

  _openScreen(String dataList, context) {
    if (dataList == 'Keranjang') {
      BlocAuth blocAuth = Provider.of<BlocAuth>(context);
      BlocOrder blocOrder = Provider.of<BlocOrder>(context);
      BlocProfile blocProfile = Provider.of<BlocProfile>(context);
      blocProfile.getUserAddressDefault(blocAuth.idUser);
      blocOrder.getCart();
      Navigator.push(context, SlideRightRoute(page: Keranjang()));
      Provider.of<BlocProfile>(context).getUserAddressDefault(blocAuth.idUser);
    } else {

      BlocAuth blocAuth = Provider.of<BlocAuth>(context);
      BlocProduk blocProduk = Provider.of<BlocProduk>(context);
      blocProduk.getFavoriteProductByParam({'id_user_login': blocAuth.idUser});
      Navigator.push(context, SlideRightRoute(page: ProdukScreen(
        namaKategori: 'Favorite',
      )));
//      Navigator.push(context, SlideRightRoute(page: FavoriteScreen()));
    }
  }
}
