import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/models/ProyekListM.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProyek.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/providers/BlocProyek.dart';
import 'package:apps/widget/Project/WidgetOverViewProyek.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';

class WidgetListProyek extends StatefulWidget {
  final String idSubKategori;
  final param;

  WidgetListProyek({Key key, this.idSubKategori, this.param}) : super(key: key);

  @override
  _WidgetListProyekState createState() {
    return _WidgetListProyekState();
  }
}

class _WidgetListProyekState extends State<WidgetListProyek> {
  var dataProyekList = new List<ProyekListM>();
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
    BlocProyek blocProyek = Provider.of<BlocProyek>(context);
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    var size = MediaQuery.of(context).size;
    print(widget.param);
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return ModalProgressHUD(
      inAsyncCall: blocProyek.isLoading,
      child: LazyLoadScrollView(
        isLoading: blocProyek.isLoading,
        onEndOfPage: () => loadMore(),
        child: GridView.count(
//      shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          children: List.generate(
            blocProyek.listProyeks.length,
            (j) {
              var harga = blocProyek.listProyeks[j].budget;
              var hargaFormat = Money.fromInt(harga == null ? 0 : int.parse(harga), IDR);
              return InkWell(
                onTap: () {
                  blocProyek.getDetailProyekByParam({'id': blocProyek.listProyeks[j].id.toString()});
                  blocProfile.getCityParam({'id': blocProyek.listProyeks[j].idKota.toString()});
                  blocOrder.getUlasanProduByParam({'id_Proyek': blocProyek.listProyeks[j].id});
//                  Navigator.push(context, SlideRightRoute(page: ProyekDetailScreen()));
                },
                child: WidgetOverViewProyek(
                  ProyekNama: blocProyek.listProyeks[j].nama,
                  thumbnail: blocProyek.listProyeks[j].foto1,
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
    if (blocProyek.totalProyek <= (int.parse(widget.param['offset']) * blocProyek.limit)) {
    } else {
      blocProyek.loadMoreProyek(widget.param);
    }
  }
}
