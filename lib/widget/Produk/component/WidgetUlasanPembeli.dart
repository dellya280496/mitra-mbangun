import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/widget/Produk/component/WidgetDetailUlasanProduk.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class WidgetUlasanPembeli extends StatelessWidget {
  final BlocProduk blocProduk;

  WidgetUlasanPembeli({Key key, this.blocProduk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    var avgRating = blocProduk.detailProduct[0].avg_rating == null ? '0' : blocProduk.detailProduct[0].avg_rating;
    var jumlahRating = blocProduk.detailProduct[0].jumlah_rating == null ? '0' : blocProduk.detailProduct[0].jumlah_rating;
    var namaPembeli = blocOrder.listUlasan.isEmpty ? '' : blocOrder.listUlasan[0].namaPembeli == null ? '' : blocOrder.listUlasan[0].namaPembeli;
    // TODO: implement build
    return Container(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Ulasan Pembeli', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      InkWell(
                        onTap: () {
                          blocOrder.getUlasanProduByParam({'id_produk': blocProduk.detailProduct[0].id});
                          Navigator.push(context, SlideRightRoute(page: WidgetDetailUlasanProduk()));
                        },
                        child: Text(
                          'Selengkapnya',
                          style: TextStyle(fontSize: 14, color: Colors.cyan[700]),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Text(
                          avgRating,
                          style: TextStyle(fontSize: 18),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              '/5',
                              style: TextStyle(color: Colors.grey, fontSize: 14),
                            )),
                        SizedBox(
                          width: 2,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 14,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          '$jumlahRating ulasan',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                blocOrder.listUlasan.isEmpty
                    ? Container()
                    : ListTile(
                        leading: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SmoothStarRating(
                              rating: double.parse(avgRating.toString()),
                              isReadOnly: true,
                              color: Colors.amber,
                              size: 9,
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
                            Text(avgRating)
                          ],
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'oleh ',
                                  style: TextStyle(fontSize: 14, color: Colors.grey),
                                ),
                                Text(
                                  namaPembeli,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            Text(Jiffy(DateTime.parse(blocOrder.listUlasan[0].createdAt.toString())).format("dd MMM"), style: TextStyle(fontSize: 10, color: Colors.grey)),
                            SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                        subtitle: RichText(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          text: TextSpan(
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              text: blocOrder.listUlasan[0].ulasan),
                        )),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
          SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
