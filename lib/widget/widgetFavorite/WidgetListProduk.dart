import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/models/ProdukListM.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/widget/Produk/WidgetDetailProduk.dart';
import 'package:apps/widget/Produk/WidgetOverViewProduk.dart';
import 'package:flutter/material.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';

class WidgetListProduk extends StatefulWidget {
  final String idSubKategori;

  WidgetListProduk({Key key, this.idSubKategori}) : super(key: key);

  @override
  _WidgetListProdukState createState() {
    return _WidgetListProdukState();
  }
}

class _WidgetListProdukState extends State<WidgetListProduk> {
  var dataProdukList = new List<ProdukListM>();
  final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
  String idKecamatan = '';
  String idKota = '';
  String idProvinsi = '';
  String key = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return GridView.count(
//      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 0.8,
      children: List.generate(
        dataProvider.getProdukListByParam.length,
        (j) {
          var harga = dataProvider.getProdukListByParam[j].produkharga;
          var hargaFormat = Money.fromInt(harga == null ? 0 : int.parse(harga), IDR);
          var kecamatan = dataProvider.getProdukListByParam[j].nama_kecamatan == null ? '' : dataProvider.getProdukListByParam[j].nama_kecamatan.toLowerCase();
          var kota = dataProvider.getProdukListByParam[j].nama_kabkota == null ? '' : dataProvider.getProdukListByParam[j].nama_kabkota.toLowerCase();
          var provinsi = dataProvider.getProdukListByParam[j].nama_propinsi == null ? '' : dataProvider.getProdukListByParam[j].nama_propinsi.toLowerCase();
          return InkWell(
            onTap: () {
              Navigator.push(context, SlideRightRoute(page: WidgetDetailProduk()));
              Provider.of<DataProvider>(context).getProdukById(dataProvider.getProdukListByParam[j].produkid);
              Provider.of<DataProvider>(context).chekUserBidding(dataProvider.getProdukListByParam[j].produkid);
            },
            child: WidgetOverViewProduk(
                produkNama: dataProvider.getProdukListByParam[j].produknama,
                thumbnail: dataProvider.getProdukListByParam[j].produkthumbnail,
                harga: harga == null ? '-' : hargaFormat.toString(),
              ));
        },
      ),
    );
  }
}
