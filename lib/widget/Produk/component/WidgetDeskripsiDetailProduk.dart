import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';
class WidgetDeskripsiDetailProduk extends StatelessWidget {
  const WidgetDeskripsiDetailProduk({
    Key key,
    @required this.blocProduk,
  }) : super(key: key);

  final BlocProduk blocProduk;

  @override
  Widget build(BuildContext context) {
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
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Deskripsi Produk', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: Html(
                      data: blocProduk.detailProduct[0].deskripsi,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: InkWell(
                        onTap: () {
                          _showDeskripsi(context);
                        },
                        child: Text(
                          'Baca Selengkapnya',
                          style: TextStyle(fontSize: 14, color: Colors.cyan[700]),
                        ),
                      )),
                ),
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

  void _showDeskripsi(context) async {
    BlocProduk blocProduk = Provider.of<BlocProduk>(context);
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return ChangeNotifierProvider<BlocOrder>(
          builder: (context) => BlocOrder(),
          child: Consumer<BlocOrder>(builder: (context, blocOrder, _) {
            final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
            return new Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.95,
              padding: EdgeInsets.all(15.0),
              color: Colors.transparent,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Deskripsi Produk',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.clear))
                      ],
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15, left: 5, right: 5),
                        child: Container(
                            color: Colors.white38,
                            child: Html(
                              style: {
                                "div": Style(
                                  fontSize: FontSize.large,
                                ),
                              },
                              data: blocProduk.detailProduct[0].deskripsi,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
