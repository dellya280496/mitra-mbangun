import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/models/ProdukListM.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/providers/BlocProyek.dart';
import 'package:apps/widget/Produk/WidgetOverViewProduk.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';

class WidgetListProduk extends StatefulWidget {
  final String idSubKategori;
  final param;

  WidgetListProduk({Key key, this.idSubKategori, this.param}) : super(key: key);

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
    BlocProduk blocProduk = Provider.of<BlocProduk>(context);
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    var size = MediaQuery.of(context).size;
    print(widget.param);
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return ModalProgressHUD(
      inAsyncCall: blocProduk.isLoading,
      child: LazyLoadScrollView(
        isLoading: blocProduk.isLoading,
        onEndOfPage: () => loadMore(),
        child: GridView.count(
//      shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          children: List.generate(
            blocProduk.listProducts.length,
            (j) {
              var avgRating = blocProduk.listProducts[j].avg_rating == null ? '0' : blocProduk.listProducts[j].avg_rating;
              var jumlahRating = blocProduk.listProducts[j].jumlah_rating == null ? '0' : blocProduk.listProducts[j].jumlah_rating;
              var harga = blocProduk.listProducts[j].harga;
              var hargaFormat = Money.fromInt(harga == null ? 0 : int.parse(harga), IDR);
              return InkWell(
                onTap: () {
                  blocProduk.getDetailProductByParam({'id': blocProduk.listProducts[j].id.toString()});
                  blocProfile.getCityParam({'id': blocProduk.listProducts[j].idKota.toString()});
                  blocOrder.getUlasanProduByParam({'id_produk': blocProduk.listProducts[j].id});
                },
                child: WidgetOverViewProduk(
                  produkNama: blocProduk.listProducts[j].nama,
                  namaToko: blocProduk.listProducts[j].namaToko,
                  jenisToko: blocProduk.listProducts[j].jenisToko,
                  thumbnail: blocProduk.listProducts[j].foto,
                  avgRating: avgRating,
                  jumlahRating: jumlahRating,
                  harga: hargaFormat.toString(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  loadMore() {
    BlocProyek blocProyek = Provider.of<BlocProyek>(context);
    widget.param['offset'] = ((int.parse(widget.param['offset']) + 1)).toString();
    if (blocProyek.totalProduk <= (int.parse(widget.param['offset']) * blocProyek.limit)) {
    } else {
      blocProyek.loadMoreProyek(widget.param);
    }
  }
}
