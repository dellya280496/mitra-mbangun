import 'package:apps/Utils/SettingApp.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class WidgetOverViewProduk extends StatelessWidget {
  final String produkNama;
  final String thumbnail;
  final String harga;
  final String namaToko;
  final String jenisToko;
  final String avgRating;
  final String jumlahRating;

  WidgetOverViewProduk({Key key, this.produkNama, this.thumbnail, this.harga, this.namaToko, this.jenisToko, this.avgRating, this.jumlahRating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridTile(
          child: getPostImages(thumbnail),
          footer: Container(
            height: 90,
            color: Colors.black87.withOpacity(0.7),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    text: TextSpan(
                      style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
                      text: produkNama,
                    ),
                  ),
                  Text(harga, style: TextStyle(color: Colors.greenAccent, fontSize: 14, fontWeight: FontWeight.w700)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            namaToko + ' ',
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                          jenisToko == 'official_store'
                              ? Image.asset(
                                  'assets/icons/verified.png',
                                  height: 12,
                                )
                              : Container()
                        ],
                      ),
                      Row(
                        children: [
                          SmoothStarRating(
                            rating: double.parse(avgRating.toString()),
                            isReadOnly: true,
                            color: Colors.amber,
                            size: 11,
                            borderColor: Colors.grey,
                            filledIconData: Icons.star,
                            halfFilledIconData: Icons.star_half,
                            defaultIconData: Icons.star_border,
                            starCount: 5,
                            allowHalfRating: true,
                            spacing: 2.0,
                            onRated: (value) {
                              print("rating value -> $value");
                              // print("rating value dd -> ${value.truncate()}");
                            },
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            '($jumlahRating)',
                            style: TextStyle(fontSize: 11, color: Colors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }

  getPostImages(String url) {
    var urlImage = baseURL+ '/'+ pathUrl +'/assets/toko/' + url;
    if (url == null) {
      return SizedBox();
    }
    return Image.network(
      urlImage,
      fit: BoxFit.cover,
      errorBuilder: (context, urlImage, error) {
        print(error.hashCode);
        return Image.asset('assets/logo.png');
      },
    );
  }
}
