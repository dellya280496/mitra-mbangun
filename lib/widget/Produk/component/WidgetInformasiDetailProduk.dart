import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/screen/ProdukScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetInformasiDetailProduk extends StatelessWidget {
  const WidgetInformasiDetailProduk({
    Key key,
    @required this.blocProduk,
  }) : super(key: key);

  final BlocProduk blocProduk;

  @override
  Widget build(BuildContext context) {
    BlocProduk blocProduk = Provider.of<BlocProduk>(context);
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
                  child: Text('Informasi Produk', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Berat',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(blocProduk.detailProduct[0].berat + ' gram', style: TextStyle(color: Colors.grey, fontSize: 14)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Kondisi',
                          style: TextStyle(
                            fontSize: 14,
                          )),
                      Text(blocProduk.detailProduct[0].kondisi, style: TextStyle(color: Colors.grey, fontSize: 14)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Pemesanan Min',
                          style: TextStyle(
                            fontSize: 14,
                          )),
                      Text(
                        blocProduk.detailProduct[0].minimalPesanan,
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Kategori',
                          style: TextStyle(
                            fontSize: 14,
                          )),
                      InkWell(
                        onTap: () {
                          blocProduk.getAllProductByParam({'id_kategori': blocProduk.detailProduct[0].idKategori.toString(), 'aktif': '1'});
                          Navigator.push(
                              context,
                              SlideRightRoute(
                                  page: ProdukScreen(
                                    namaKategori: blocProduk.detailProduct[0].namaKategori,
                                  )));
                        },
                        child: Text(
                          blocProduk.detailProduct[0].namaKategori,
                          style: TextStyle(color: Colors.cyan[700], fontSize: 14),
                        ),
                      ),
                    ],
                  ),
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
}
