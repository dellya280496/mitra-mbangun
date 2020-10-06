import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/screen/ProdukScreen.dart';
import 'package:flutter/material.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class WidgetProdukTerjual extends StatelessWidget {
  WidgetProdukTerjual({
    Key key,
    @required this.blocProduk,
  }) : super(key: key);
  final BlocProduk blocProduk;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: EdgeInsets.only(top: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Produk Terjual',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          )),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Provider.of<BlocProduk>(context).getAllProductByParam({'aktif': '1', 'id_toko': blocProduk.detailStore[0].id.toString()});
                    Navigator.push(
                        context,
                        SlideRightRoute(
                            page: ProdukScreen(
                          namaKategori: 'Produk ' + blocProduk.detailStore[0].namaToko,
                        )));
                  },
                  child: Text(
                    'Semua',
                    style: TextStyle(fontSize: 12, color: Color(0xffb16a085)),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.25,
          child: GridView.count(
            crossAxisCount: 1,
            scrollDirection: Axis.horizontal,
            children: List.generate(
              blocProduk.listProdukTerjual.isEmpty ? 1 : blocProduk.listProdukTerjual.length,
              (j) {
                final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
                var avgRating = blocProduk.listProdukTerjual.isEmpty || blocProduk.listProdukTerjual[j].avg_rating == null ? '0' : blocProduk.listProdukTerjual[j].avg_rating;
                var jumlahRating = blocProduk.listProdukTerjual.isEmpty ? '0' : blocProduk.listProdukTerjual[j].jumlah_rating;
                var harga = blocProduk.listProdukTerjual.isEmpty ? '0' : blocProduk.listProdukTerjual[j].harga;
                var hargaFormat = Money.fromInt(harga == null ? 0 : int.parse(harga), IDR);
                print(blocProduk.listProdukTerjual.isEmpty);
                if (blocProduk.listProdukTerjual.isEmpty) {
                  return Center(
                    child: Text('Tidak ada data'),
                  );
                } else {
                  return Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: InkWell(
                      onTap: () {
                        blocProduk.getDetailProductByParam({'id': blocProduk.listProdukTerjual[j].id.toString(), 'aktif': '1'});
                        blocProfile.getCityParam({'id': blocProduk.listProdukTerjual[j].idKota.toString()});
                        blocOrder.getUlasanProduByParam({'id_produk': blocProduk.listProdukTerjual[j].id});
                      },
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: getPostImages(blocProduk.listProdukTerjual[j].foto),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 150,
                                    child: RichText(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      text: TextSpan(
                                          style: TextStyle(color: Colors.grey[800], fontSize: 13, fontWeight: FontWeight.normal), text: blocProduk.listProdukTerjual[j].nama),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    child: RichText(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      text: TextSpan(
                                          style: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          text: hargaFormat.toString()),
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        RichText(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          text: TextSpan(
                                              style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.normal, fontStyle: FontStyle.italic),
                                              text: blocProduk.listProdukTerjual[j].namaToko + ' '),
                                        ),
                                        blocProduk.listProdukTerjual.isEmpty
                                            ? Container()
                                            : blocProduk.listProdukTerjual[j].jenisToko == 'official_store'
                                                ? Image.asset(
                                                    'assets/icons/verified.png',
                                                    height: 10,
                                                  )
                                                : Container()
                                      ],
                                    ),
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
                                        style: TextStyle(fontSize: 11, color: Colors.grey),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    elevation: 2,
                    margin: EdgeInsets.all(10),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  getPostImages(String url) {
    if (url == null) {
      return SizedBox();
    }
    return Image.network(baseURL+ '/api-v2/assets/toko/' + url, fit: BoxFit.cover, errorBuilder: (context, urlImage, error) {
      print(error.hashCode);
      return Image.asset('assets/logo.png');
    });
  }
}
