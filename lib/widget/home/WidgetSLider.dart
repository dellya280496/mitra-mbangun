import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/screen/DetailTokoScreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class WidgetSlider extends StatelessWidget {
  const WidgetSlider({
    Key key,
    @required this.blocProduk,
  }) : super(key: key);

  final BlocProduk blocProduk;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width,
      height: 180,
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 2.5,
          autoPlay: true,
        ),
        items: blocProduk.listIklan.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return InkWell(
                onTap: () {
//                  blocProduk.getDetailStore(i.idToko);
//                  Navigator.push(
//                      context,
//                      SlideRightRoute(
//                          page: DetailTokoScreen(
//                        id: i.idToko,
//                        image: i.baner,
//                      )));
                },
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Image.network(
                      'http://m-bangun.com/api-v2/assets/iklan/' +
                          i.baner,
                      fit: BoxFit.cover,
                      errorBuilder: (context, urlImage, error) {
                        print(error.hashCode);
                        return Image.asset('assets/logo.png');
                      },
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(),
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

  void _openDetailToko(context) {
    Navigator.push(context, SlideRightRoute(page: DetailTokoScreen()));
  }
}
