import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/screen/DetailTokoScreen.dart';
import 'package:flutter/material.dart';

class WidgetOffialStore extends StatelessWidget {
  const WidgetOffialStore({
    Key key,
    @required this.blocProduk,
  }) : super(key: key);

  final BlocProduk blocProduk;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: GridView.count(
        scrollDirection: Axis.horizontal,
        crossAxisCount: 1,
        children: List.generate(blocProduk.listOfficialStore.length, (j) {
          return Container(
            child: InkWell(
              onTap: () {
                blocProduk.getDetailStore(blocProduk.listOfficialStore[j].id);
                _detailToko(context, blocProduk.listOfficialStore[j]);
              },
              child: new Container(
                child: new Center(
                  child: Image.network(
                    baseURL+ '/api-v2/assets/toko/' + blocProduk.listOfficialStore[j].foto,
                    height: 60,
                    errorBuilder: (context, urlImage, error) {
                      print(error.hashCode);
                      return Image.asset(
                        'assets/logo.png',
                        height: 60,
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  void _detailToko(context, param) {
    Navigator.push(
        context,
        SlideRightRoute(
            page: DetailTokoScreen(
          id: param.id,
          image: param.fotoSampul,
        )));
  }
}
