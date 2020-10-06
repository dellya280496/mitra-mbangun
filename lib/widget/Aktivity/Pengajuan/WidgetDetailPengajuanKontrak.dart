import 'package:apps/Utils/PreviewFoto.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/widget/Aktivity/Pengajuan/component/WidgetListPekerja.dart';
import 'package:apps/widget/Project/component/WidgetKontrak.dart';
import 'package:apps/widget/Produk/component/WidgetDeskripsiProduk.dart';
import 'package:apps/widget/Produk/component/WidgetDetailBahanProduk.dart';
import 'package:apps/widget/Produk/component/WidgetDetailLokasi.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';

class WidgetDetailPengajuanKontrak extends StatelessWidget {
  WidgetDetailPengajuanKontrak({Key key, @required this.param}) : super(key: key);

  final String param;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    var data = dataProvider.getdataProdukById;
//    var budget = dataProvider.getdataProdukById['data'][0]['produkbudget'] == null ? '0' : dataProvider.getdataProdukById['data'][0]['produkbudget'];

    return Scaffold(
      body: dataProvider.isLoading
          ? SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Scaffold(
                  appBar: AppBar(
                    title: Text('Waiting'),
                  ),
                  body: PKCardPageSkeleton(
                    totalLines: 3,
                  ),
                ),
              ),
            )
          : Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: NestedScrollView(
                    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          automaticallyImplyLeading: true,
                          expandedHeight: 200.0,
                          floating: false,
                          pinned: true,
                          leading: Container(
                            margin: EdgeInsets.only(
                              left: 10,
                            ),
                            padding: EdgeInsets.all(3),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.black26,
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                          flexibleSpace: FlexibleSpaceBar(
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
                                    text: data == null ? '' : dataProvider.getdataProdukById['data'][0]['produknama']),
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
                                          builder: (context) => PreviewFoto(
                                            urlFoto: dataProvider.getdataProdukById['data'][0]['produkthumbnail'] == null
                                                ? dataProvider.fotoNull
                                                : dataProvider.getdataProdukById['data'][0]['produkthumbnail'],
                                          ),
                                        ));
                                  },
                                  child: Image.network(
                                    data == null
                                        ? dataProvider.fotoNull
                                        : dataProvider.getdataProdukById['data'][0]['produkthumbnail'] == null
                                            ? dataProvider.fotoNull
                                            : dataProvider.getdataProdukById['data'][0]['produkthumbnail'],
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageRouteTransition(
                                          animationType: AnimationType.slide_down,
                                          builder: (context) => PreviewFoto(
                                            urlFoto: dataProvider.getdataProdukById['data'][0]['produkfoto1'] == null
                                                ? dataProvider.fotoNull
                                                : dataProvider.getdataProdukById['data'][0]['produkfoto1'],
                                          ),
                                        ));
                                  },
                                  child: Image.network(
                                    data == null
                                        ? dataProvider.fotoNull
                                        : dataProvider.getdataProdukById['data'][0]['produkfoto1'] == null
                                            ? dataProvider.fotoNull
                                            : dataProvider.getdataProdukById['data'][0]['produkfoto1'],
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageRouteTransition(
                                          animationType: AnimationType.slide_down,
                                          builder: (context) => PreviewFoto(
                                            urlFoto: dataProvider.getdataProdukById['data'][0]['produkfoto2'] == null
                                                ? dataProvider.fotoNull
                                                : dataProvider.getdataProdukById['data'][0]['produkfoto2'],
                                          ),
                                        ));
                                  },
                                  child: Image.network(
                                    data == null
                                        ? dataProvider.fotoNull
                                        : dataProvider.getdataProdukById['data'][0]['produkfoto2'] == null
                                            ? dataProvider.fotoNull
                                            : dataProvider.getdataProdukById['data'][0]['produkfoto2'],
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageRouteTransition(
                                          animationType: AnimationType.slide_down,
                                          builder: (context) => PreviewFoto(
                                            urlFoto: dataProvider.getdataProdukById['data'][0]['produkfoto3'] == null
                                                ? dataProvider.fotoNull
                                                : dataProvider.getdataProdukById['data'][0]['produkfoto3'],
                                          ),
                                        ));
                                  },
                                  child: Image.network(
                                    data == null
                                        ? dataProvider.fotoNull
                                        : dataProvider.getdataProdukById['data'][0]['produkfoto3'] == null
                                            ? dataProvider.fotoNull
                                            : dataProvider.getdataProdukById['data'][0]['produkfoto3'],
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageRouteTransition(
                                          animationType: AnimationType.slide_down,
                                          builder: (context) => PreviewFoto(
                                            urlFoto: dataProvider.getdataProdukById['data'][0]['produkfoto4'] == null
                                                ? dataProvider.fotoNull
                                                : dataProvider.getdataProdukById['data'][0]['produkfoto4'],
                                          ),
                                        ));
                                  },
                                  child: Image.network(
                                    data == null
                                        ? dataProvider.fotoNull
                                        : dataProvider.getdataProdukById['data'][0]['produkfoto4'] == null
                                            ? dataProvider.fotoNull
                                            : dataProvider.getdataProdukById['data'][0]['produkfoto4'],
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ],
                              dotSize: 4.0,
                              dotSpacing: 15.0,
                              dotColor: Colors.lightGreenAccent,
                              indicatorBgPadding: 3.0,
                              dotBgColor: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ];
                    },
                    body: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 7),
                              child: WidgetDeskripsiProduk(),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: WidgetDetailLokasi(dataProvider:
                              dataProvider),
                            ),
                            param != 'Publish'
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: WidgetDetailBahanProduk(),
                                  )
                                : Container(),
                            param == 'Negosiasi' || param == 'Kontrak' || param == 'Progress'
                                ? Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: WidgetListPekerja(
                                    ),
                                  )
                                : Container(),
                            param == 'Kontrak' || param == 'Progress'
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: WidgetKontrak(param: 'owner',),
                                  )
                                : Container()
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
