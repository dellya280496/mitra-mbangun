import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/widget/Produk/WidgetListProduk.dart';
import 'package:apps/widget/filter/WIdgetFilter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:sup/sup.dart';

class ProdukScreen extends StatefulWidget {
  final String namaKategori;
  final String idSubKategori;
  final param;

  ProdukScreen({Key key, this.namaKategori, this.idSubKategori, this.param}) : super(key: key);

  @override
  _ProdukScreenState createState() => _ProdukScreenState();
}

class _ProdukScreenState extends State<ProdukScreen> with TickerProviderStateMixin {
  AnimationController _hideFabAnimation;

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        _hideFabAnimation.forward();
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            if (userScroll.metrics.maxScrollExtent != userScroll.metrics.minScrollExtent) {
              _hideFabAnimation.forward();
            }
            break;
          case ScrollDirection.reverse:
            if (userScroll.metrics.maxScrollExtent != userScroll.metrics.minScrollExtent) {
              _hideFabAnimation.reverse();
            }
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _hideFabAnimation = AnimationController(vsync: this, duration: kThemeAnimationDuration);
    _hideFabAnimation.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _hideFabAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BlocProduk blocProduk = Provider.of<BlocProduk>(context);
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(widget.namaKategori),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.info,
                color: Colors.grey,
              ),
              onPressed: () {},
            )
          ],
        ),
        body: blocProduk.listProducts.isEmpty
            ? Center(
                child: Sup(
                  title: Text('Produk tidak tersedia'),
                  subtitle: Text('Silahkan pilih kategori lainnya.'),
                  image: Image.asset(
                    'assets/img/sad.png',
                    height: 250,
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: WidgetListProduk(
                        param: widget.param,
                        idSubKategori: this.widget.idSubKategori,
                      ),
                    ),
                  ],
                ),
              ),
        floatingActionButton: ScaleTransition(
          scale: _hideFabAnimation,
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context,
                  PageRouteTransition(
                    animationType: AnimationType.slide_up,
                    builder: (context) => WidgetFilter(),
                  )).then((value) async {
                blocProduk.getCurrentLocation();
                String currentIdProvinsi = await LocalStorage.sharedInstance.readValue('idProvinsi');
                String currentIdKota = await LocalStorage.sharedInstance.readValue('idKota');
                String currentIdKecamatan = await LocalStorage.sharedInstance.readValue('idKecamatan');
                var param = {
                  'id_kecamatan': currentIdKecamatan.toString() == 'null' ? '' : currentIdKecamatan.toString(),
                  'id_kota': currentIdKota.toString() == 'null' ? '' : currentIdKota.toString(),
                  'id_provinsi': currentIdProvinsi.toString() == 'null' ? '' : currentIdProvinsi.toString(),
                  'aktif': '1'
                };
                blocProduk.getAllProductByParam(param);
              });
            },
            backgroundColor: Color(0xffb16a085),
            tooltip: 'Filter',
            icon: Icon(Icons.filter_list),
            label: Text("Filter", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, letterSpacing: 1)),
          ),
        ),
      ),
    );
  }
}
