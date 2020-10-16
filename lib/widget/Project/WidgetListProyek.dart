import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/models/ProyekListM.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProyek.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/providers/BlocProyek.dart';
import 'package:apps/widget/Profile/WidgetUpdateProfile.dart';
import 'package:apps/widget/Project/WidgetDetailProyek.dart';
import 'package:apps/widget/Project/WidgetOverViewProyek.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';

class WidgetListProyek extends StatefulWidget {
  final String namaKategori;
  final param;
  final status;

  WidgetListProyek({Key key, this.namaKategori, this.status, this.param}) : super(key: key);

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
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    var size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: blocProyek.isLoading,
      child: LazyLoadScrollView(
        isLoading: blocProyek.isLoading,
        onEndOfPage: () => loadMore(),
        child: RefreshIndicator(
        onRefresh: ()async {
          blocAuth.checkSession();
          if (blocAuth.survey) {
            var param = {
              'aktif': '1',
              'status': "('survey','setuju')",
              'status_pembayaran_survey': 'terbayar',
              'limit': blocProyek.limit.toString(),
              'offset': blocProyek.offset.toString(),
            };
            blocProyek.getAllProyekByParam(param);
          } else {
            var idJenisLayanan = blocAuth.listJenisLayananMitra.map((e) => e.id).toString();
            if (idJenisLayanan != '()') {
              var param = {
                'aktif': '1',
                'status': "('setuju')",
                'status_pembayaran_survey': 'terbayar',
                'limit': blocProyek.limit.toString(),
                'offset': blocProyek.offset.toString(),
                'id_jenis_layanan': idJenisLayanan
              };
              blocProyek.getAllProyekByParam(param);
            } else {
              blocProyek.clearlistProyeks();
              blocProyek.clearRecentProyek();
            }
          }
        },
          child: GridView.count(
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
                    blocProyek.getTagihanByParam({'id_proyek': blocProyek.listProyeks[j].id.toString()});
                    blocProyek.getBidsByParam({'id_mitra': blocAuth.idUser, 'id_projek': blocProyek.listProyeks[j].id});
                    blocProfile.getSubDistrictById(blocProyek.listProyeks[j].idKecamatan);
                    blocProyek.getListPekerja({'id_projek': blocProyek.listProyeks[j].id.toString(), 'status_proyek': widget.status.toString()});

                    if ((blocAuth.detailMitra[0].namaBank == null && blocAuth.detailMitra[0].noRekening == null && blocAuth.detailMitra[0].namaPemilikRekening == null) ||
                        (blocAuth.detailMitra[0].namaBank == '' && blocAuth.detailMitra[0].noRekening == '' && blocAuth.detailMitra[0].namaPemilikRekening == '')) {
                      Navigator.push(context, SlideRightRoute(page: WidgetUpdateProfile()));
                    } else {
                      Navigator.push(context, SlideRightRoute(page: WidgetDetailProyek()));
                    }
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
