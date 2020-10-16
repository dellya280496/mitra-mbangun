import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/models/Categories.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/screen/ProdukScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetGridKategori extends StatelessWidget {
  const WidgetGridKategori({
    Key key,
    @required this.blocProduk,
  }) : super(key: key);

  final BlocProduk blocProduk;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(color: Colors.cyan.withOpacity(0.9), borderRadius: BorderRadius.all(Radius.circular(20))),
      padding: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width * 0.9,
      child: GridView.count(
        scrollDirection: Axis.horizontal,
        crossAxisCount: 1,
        children: List.generate(blocProduk.listCategory.length, (j) {
          return Container(
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () => _openListProduk(context, blocProduk.listCategory[j]),
                  child: new Container(
                    height: 40,
                    width: 40,
                    margin: EdgeInsets.only(bottom: 5, top: 0),
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
                      child: Image.network(
                        baseURL+ '/'+ pathUrl +'/assets/kategori/' + blocProduk.listCategory[j].icon.toString(),
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                ),
                RichText(
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    text: blocProduk.listCategory[j].nama,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  _openListProduk(BuildContext context, Categories listCategory) {
    var param = {'id_kategori': listCategory.id.toString(), 'aktif': '1', 'limit': blocProduk.limit.toString(), 'offset': blocProduk.offset.toString()};
    Provider.of<BlocProduk>(context).getAllProductByParam(param);
    Navigator.push(
        context,
        SlideRightRoute(
            page: ProdukScreen(
          param: param,
          namaKategori: listCategory.nama,
        )));
  }
}
