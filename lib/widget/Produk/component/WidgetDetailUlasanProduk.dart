import 'package:apps/providers/BlocOrder.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class WidgetDetailUlasanProduk extends StatelessWidget {
  WidgetDetailUlasanProduk({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        title: Text('Semua ulasan'),
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: blocOrder.listUlasan.length,
          itemBuilder: (context, index) {
            var namaPembeli = blocOrder.listUlasan.isEmpty ? '' : blocOrder.listUlasan[0].namaPembeli == null ? '' : blocOrder.listUlasan[0].namaPembeli;
            return ListTile(
                leading: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmoothStarRating(
                      rating: double.parse(blocOrder.listUlasan[index].rating.toString()),
                      isReadOnly: true,
                      color: Colors.amber,
                      size: 9,
                      borderColor: Colors.cyan[200],
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
                    Text(blocOrder.listUlasan[index].rating.toString())
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
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Text(
                          namaPembeli,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Text(Jiffy(DateTime.parse(blocOrder.listUlasan[index].createdAt.toString())).format("dd MMM"), style: TextStyle(fontSize: 10, color: Colors.grey)),
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
                        fontSize: 12,
                      ),
                      text: blocOrder.listUlasan[index].ulasan),
                ));
          }),
    );
  }
}
