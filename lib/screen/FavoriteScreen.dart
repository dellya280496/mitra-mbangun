import 'package:apps/providers/DataProvider.dart';
import 'package:apps/widget/Login/LoginWidget.dart';
import 'package:apps/widget/Produk/WidgetListProduk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({Key key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
//    Provider.of<DataProvider>(context).getAllBidByUserIdAndStatusId(widget.statusId);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    return !dataProvider.isLogin
        ? LoginWidget(
            primaryColor: Color(0xFFb16a085),
            backgroundColor: Colors.white,
            page: '/BottomNavBar',
          )
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text('Favorite'),
            ),
            body: !dataProvider.connection
                ? Center(
                    child: InkWell(
                        onTap: () {
                          dataProvider.getToken();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.network_check,
                              color: Colors.grey,
                              size: 50,
                            ),
                            Text('Tidak Ada Koneksi Internet'),
                            Container(
                              height: 10,
                            ),
                            Container(
                              height: 35.0,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: FlatButton(
                                onPressed: () {
                                  dataProvider.getToken();
                                },
                                child: Text(
                                  'Coba Lagi',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        )),
                  )
                : Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: RefreshIndicator(
                            onRefresh: refreshList,
                            key: refreshKey,
                            child: WidgetListProduk(),
                          ),
                        ),
                      ],
                    ),
                  ),
          );
  }
}
