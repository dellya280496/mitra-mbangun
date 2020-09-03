import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class WidgetOverViewProyek extends StatelessWidget {
  final String ProyekNama;
  final String thumbnail;
  final String harga;

  WidgetOverViewProyek({Key key, this.ProyekNama, this.thumbnail, this.harga}) : super(key: key);

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
                      text: ProyekNama,
                    ),
                  ),
                  Text(harga, style: TextStyle(color: Colors.greenAccent, fontSize: 14, fontWeight: FontWeight.w700)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }

  getPostImages(String url) {
    var urlImage = 'http://m-bangun.com/api-v2/assets/toko/' + url;
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
