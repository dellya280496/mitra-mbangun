import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/models/ProdukListM.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/widget/Produk/WidgetDetailProduk.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';

class WidgetCari extends StatefulWidget {
  WidgetCari({Key key}) : super(key: key);

  @override
  _WidgetCariState createState() {
    return _WidgetCariState();
  }
}

class _WidgetCariState extends State<WidgetCari> {
  var dataProdukList = new List<ProdukListM>();
  String idSubKategori = '';
  final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getProdukByParam(query) async {
    Provider.of<DataProvider>(context).setKeySearch(query);
  }

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    // TODO: implement build
    return Scaffold(
        body: FloatingSearchBar.builder(
      pinned: true,
      itemCount: dataProvider.getProdukListByParam.length,
      padding: EdgeInsets.only(top: 10.0),
      itemBuilder: (BuildContext context, int j) {
        var harga = dataProvider.getProdukListByParam[j].produkharga;
        var hargaFormat = Money.fromInt(harga == null ? 0 : int.parse(harga), IDR);
        var kecamatan =
            dataProvider.getProdukListByParam[j].nama_kecamatan == null ? '' : dataProvider.getProdukListByParam[j].nama_kecamatan.toLowerCase();
        var kota = dataProvider.getProdukListByParam[j].nama_kabkota == null ? '' : dataProvider.getProdukListByParam[j].nama_kabkota.toLowerCase();
        var provinsi =
            dataProvider.getProdukListByParam[j].nama_propinsi == null ? '' : dataProvider.getProdukListByParam[j].nama_propinsi.toLowerCase();
        return Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: () {
              Navigator.push(context, SlideRightRoute(page: WidgetDetailProduk()));
              Provider.of<DataProvider>(context).getProdukById(dataProvider.getProdukListByParam[j].produkid);
              Provider.of<DataProvider>(context).getFavoriteByProdukIdAndUserId(dataProvider.getProdukListByParam[j].produkid);
            },
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5),
//                        height: 100,
                  child: ListTile(
                    leading: Image.network(
                      dataProvider.getProdukListByParam[j].produkthumbnail == null
                          ? 'https://previews.123rf.com/images/urfandadashov/urfandadashov1809/urfandadashov180901275/109135379-photo-not-available-vector-icon-isolated-on-transparent-background-photo-not-available-logo-concept.jpg'
                          : dataProvider.getProdukListByParam[j].produkthumbnail,
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                    ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              strutStyle: StrutStyle(fontSize: 12.0),
                              text: TextSpan(
                                style: TextStyle(color: Colors.grey[800], fontSize: 14, fontWeight: FontWeight.w700),
                                text: '${dataProvider.getProdukListByParam[j].produknama}',
                              ),
                            ),
                            Text(harga == null ? '-' : hargaFormat.toString(),
                                style: TextStyle(fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.access_time,
                                    color: Colors.grey,
                                    size: 12,
                                  ),
                                  Text(' '),
                                  Text(
                                    Jiffy(dataProvider.getProdukListByParam[j].produkcreate).fromNow(),
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ],
                              ),
                              Container(
                                height: 3,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.place,
                                    color: Colors.grey,
                                    size: 12,
                                  ),
                                  Text(' '),
                                  Text(
                                    '${kecamatan[0].toUpperCase()}${kecamatan.substring(1)}, ${kota[0].toUpperCase()}${kota.substring(1)}\n${provinsi[0].toUpperCase()}${provinsi.substring(1)}',
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              elevation: 5,
              margin: EdgeInsets.all(10),
            );
          },
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
          Provider.of<DataProvider>(context).getAllProdukListByParam();
        },
          ),
          onChanged: (String query) => _getProdukByParam(query),
          onTap: () {},
          decoration: InputDecoration.collapsed(
            hintText: "Search...",
          ),
        ));
  }
}
