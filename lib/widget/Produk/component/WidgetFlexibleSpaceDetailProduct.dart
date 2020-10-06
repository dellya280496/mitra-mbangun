import 'package:apps/Utils/PreviewFoto.dart';
import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:route_transitions/route_transitions.dart';

class WidgetFlexibleSpaceDetailProduct extends StatelessWidget {
  const WidgetFlexibleSpaceDetailProduct({
    Key key,
    @required this.blocProduk,
    @required this.hashCode,
  }) : super(key: key);

  final BlocProduk blocProduk;
  final int hashCode;

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      centerTitle: true,
      collapseMode: CollapseMode.parallax,
      title: Container(
        padding: EdgeInsets.only(left: 50, right: 20),
        child: RichText(
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          strutStyle: StrutStyle(fontSize: 14.0),
          text: TextSpan(
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 14,
              ),
              text: blocProduk.detailProduct[0].nama),
        ),
      ),
      background: Carousel(
        autoplay: false,
        overlayShadow: false,
        noRadiusForIndicator: true,
        images: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageRouteTransition(
                  animationType: AnimationType.slide_down,
                  builder: (context) => PreviewFoto(urlFoto: baseURL+ '/api-v2/assets/toko/' + blocProduk.detailProduct[0].foto),
                ),
              );
            },
            child: Image.network(baseURL+ '/api-v2/assets/toko/' + blocProduk.detailProduct[0].foto, width: MediaQuery.of(context).size.width, fit: BoxFit.fitWidth,
                errorBuilder: (context, urlImage, error) {
              print(error.hashCode);
              return Image.asset('assets/logo.png');
            }),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageRouteTransition(
                  animationType: AnimationType.slide_down,
                  builder: (context) => PreviewFoto(urlFoto: baseURL+ '/api-v2/assets/toko/' + blocProduk.detailProduct[0].foto1),
                ),
              );
            },
            child: Image.network(baseURL+ '/api-v2/assets/toko/' + blocProduk.detailProduct[0].foto1, width: MediaQuery
                .of(context)
                .size
                .width, fit: BoxFit.fitWidth,
                errorBuilder: (context, urlImage, error) {
                  print(error.hashCode);
                  return Image.asset('assets/logo.png');
                }),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageRouteTransition(
                  animationType: AnimationType.slide_down,
                  builder: (context) => PreviewFoto(urlFoto: baseURL+ '/api-v2/assets/toko/' + blocProduk.detailProduct[0].foto2),
                ),
              );
            },
            child: Image.network(baseURL+ '/api-v2/assets/toko/' + blocProduk.detailProduct[0].foto2, width: MediaQuery
                .of(context)
                .size
                .width, fit: BoxFit.fitWidth,
                errorBuilder: (context, urlImage, error) {
                  print(error.hashCode);
                  return Image.asset('assets/logo.png');
                }),
          ),
        ],
        dotSize: 4.0,
        dotSpacing: 15.0,
        dotColor: Colors.lightGreenAccent,
        indicatorBgPadding: 3.0,
        dotBgColor: Colors.grey.withOpacity(0.5),
      ),
    );
  }
}
