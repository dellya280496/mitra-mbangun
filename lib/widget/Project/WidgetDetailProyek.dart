import 'dart:io';

import 'package:apps/Utils/PreviewFoto.dart';
import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/models/Proyek.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocProyek.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/widget/Project/component/WidgetKontrak.dart';
import 'package:apps/widget/Project/component/WIdgetBidProyek.dart';
import 'package:apps/widget/Project/component/WidgetDeskripsiProyek.dart';
import 'package:apps/widget/Project/component/WidgetDetailBahan.dart';
import 'package:apps/widget/Project/component/WidgetDetailLokasi.dart';
import 'package:apps/widget/Project/component/WidgetLaporanAkhir.dart';
import 'package:apps/widget/Project/component/WidgetListPekerja.dart';
import 'package:apps/widget/Project/component/WidgetListPembayaran.dart';
import 'package:apps/widget/Project/component/WidgetUpdateProyek.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:html_editor/html_editor.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:money2/money2.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:route_transitions/route_transitions.dart';

class WidgetDetailProyek extends StatefulWidget {
  WidgetDetailProyek({
    Key key,
  }) : super(key: key);

  @override
  _WidgetDetailProyekState createState() => _WidgetDetailProyekState();
}

class _WidgetDetailProyekState extends State<WidgetDetailProyek> {
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<HtmlEditorState> keyEditor = GlobalKey();
  String waktuPenawaran, catatan;
  bool laporanAkhir = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    var data = dataProvider.getdataProdukById;
    BlocProyek blocProyek = Provider.of<BlocProyek>(context);
    var pemenang = blocProyek.listPekerja.where((element) => element.status == '1');
    final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
    var budget = blocProyek.detailProyek.isEmpty ? '0' : Money.fromInt(int.parse(blocProyek.detailProyek[0].budget.toString()), IDR).toString();
    print('aa' + blocProyek.detailProyek.where((element) => element.fileLaporanAkhir != '').length.toString());
    return Scaffold(
      body: blocProyek.detailProyek.isEmpty
          ? SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Scaffold(
                  appBar: AppBar(
                    title: Text('Waiting'),
                  ),
                  body: Center(
                    child: PKCardListSkeleton(
//                      totalLines: 3,
                        ),
                  ),
                ),
              ),
            )
          : ModalProgressHUD(
              inAsyncCall: blocProyek.isLoading,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height - 55,
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
                                              urlFoto: blocProyek.detailProyek[0].foto1 == null
                                                  ? dataProvider.fotoNull
                                                  : baseURL + '/api-v2/assets/toko/' + blocProyek.detailProyek[0].foto1,
                                            ),
                                          ));
                                    },
                                    child: Image.network(
                                      blocProyek.detailProyek[0].foto1 == null ? dataProvider.fotoNull : baseURL + '/api-v2/assets/toko/' + blocProyek.detailProyek[0].foto1,
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
                                              urlFoto: blocProyek.detailProyek[0].foto2 == null
                                                  ? dataProvider.fotoNull
                                                  : baseURL + '/api-v2/assets/toko/' + blocProyek.detailProyek[0].foto2,
                                            ),
                                          ));
                                    },
                                    child: Image.network(
                                      blocProyek.detailProyek[0].foto2 == null ? dataProvider.fotoNull : baseURL + '/api-v2/assets/toko/' + blocProyek.detailProyek[0].foto2,
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
                                              urlFoto: blocProyek.detailProyek[0].foto3 == null
                                                  ? dataProvider.fotoNull
                                                  : baseURL + '/api-v2/assets/toko/' + blocProyek.detailProyek[0].foto3,
                                            ),
                                          ));
                                    },
                                    child: Image.network(
                                      blocProyek.detailProyek[0].foto3 == null ? dataProvider.fotoNull : baseURL + '/api-v2/assets/toko/' + blocProyek.detailProyek[0].foto3,
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
                                child: WidgetDeskripsiProyek(
                                    created: blocProyek.detailProyek.isEmpty ? '' : blocProyek.detailProyek[0].createdAt,
                                    lokasi: blocProyek.detailProyek.isEmpty ? '' : blocProyek.detailProyek[0].alamatLengkap,
                                    nama: blocProyek.detailProyek.isEmpty ? '' : blocProyek.detailProyek[0].nama,
                                    jenisLayanan: blocProyek.detailProyek.isEmpty ? '' : blocProyek.detailProyek[0].namaLayanan,
                                    noHp: blocProyek.detailProyek.isEmpty ? '' : blocProyek.detailProyek[0].noHp,
                                    budget: budget,
                                    status: blocProyek.detailProyek[0].status),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: WidgetDetailLokasi(
                                  alamatLengkap: blocProyek.detailProyek.isEmpty ? Container() : blocProyek.detailProyek[0].alamatLengkap,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: WidgetDetailBahan(
                                  param: blocProyek.detailProyek.isEmpty ? null : blocProyek.detailProyek[0],
                                ),
                              ),
                              blocProyek.detailProyek.isEmpty
                                  ? Container()
                                  : blocProyek.detailProyek[0].status == 'setuju' || blocProyek.detailProyek[0].status == 'proses'
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: WidgetListPekerja(),
                                        )
                                      : Container(),
                              blocProyek.detailProyek.isEmpty
                                  ? Container()
                                  : blocAuth.survey
                                      ? Container()
                                      : blocProyek.detailProyek[0].status == 'proses' || blocProyek.detailProyek[0].status == 'selesai'
                                          ? pemenang.where((element) => element.idMitra == blocAuth.idUser).length == 0
                                              ? Container()
                                              : Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                                  child: WidgetKontrak(
                                                    param: 'owner',
                                                  ),
                                                )
                                          : Container(),
                              blocProyek.detailProyek.isEmpty
                                  ? Container()
                                  : blocAuth.survey
                                      ? Container()
                                      : blocProyek.detailProyek[0].status == 'proses' || blocProyek.detailProyek[0].status == 'selesai'
                                          ? pemenang.where((element) => element.idMitra == blocAuth.idUser).length == 0
                                              ? Container()
                                              : Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                                  child: WidgetListPembayaran(),
                                                )
                                          : Container(),
                              blocProyek.detailProyek.where((element) => element.fileLaporanAkhir != '').length.toString() == '0'
                                  ? Container()
                                  : blocProyek.detailProyek.where((element) => element.fileLaporanAkhir != null).length.toString() == '0'
                                      ? Container()
                                      : blocProyek.detailProyek[0].status == 'proses' || blocProyek.detailProyek[0].status == 'selesai'
                                          ? pemenang.where((element) => element.idMitra == blocAuth.idUser).length == 0
                                              ? Container()
                                              : Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                                  child: WidgetLaporanAkhir(),
                                                )
                                          : Container(),
                              blocProyek.detailProyek.isEmpty
                                  ? Container()
                                  : !blocAuth.survey
                                      ? Container()
                                      : blocProyek.detailProyek[0].status == 'proses'
                                          ? pemenang.where((element) => element.idMitra == blocAuth.idUser).length == 0
                                              ? Container()
                                              : Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                                  child: WidgetListPembayaran(),
                                                )
                                          : Container(),
                              blocProyek.detailProyek.isEmpty
                                  ? Container()
                                  : !blocAuth.survey
                                      ? Container()
                                      : pemenang.length == 0
                                          ? Container()
                                          : blocProyek.detailProyek[0].status != 'proses'
                                              ? Container()
                                              : Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                                  child: WidgetKontrak(
                                                    param: 'owner',
                                                  ),
                                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar:
      blocProyek.detailProyek.isEmpty
          ? Container(
              height: 20,
              child: Center(
                child: CircularProgressIndicator(),
              ))
          : blocProyek.detailProyek[0].status == 'selesai'
              ? Container(color: Colors.white, height: 50, child: Center(child: Text('Terima kasih sudah menggunakan jasa kami')),)
              : Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)), color: Colors.white),
                  height: 55,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FlatButton(
                        height: 35,
                        minWidth: MediaQuery.of(context).size.width * 0.9,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: Text(
                          blocAuth.survey ? 'Ubah Data & Terbitkan' : blocProyek.detailProyek[0].status == 'proses' ? 'Upload Laporan Akhir' : 'Apply',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          if (blocAuth.survey) {
                            _showDialogUbahData(context);
                          } else if (blocProyek.listBids.isNotEmpty && blocProyek.detailProyek[0].status != 'proses') {
                            null;
                          } else if (blocProyek.listBids.isNotEmpty && blocProyek.detailProyek[0].status == 'proses') {
                            _showDialogSelesai(context, blocProyek.detailProyek[0]);
                          } else {
                            _showDialog(context);
                          }
                        },
                        color: blocProyek.listBids.isNotEmpty && blocProyek.detailProyek[0].status != 'proses' && !blocAuth.survey
                            ? Colors.grey
                            : blocProyek.listBids.isNotEmpty && blocProyek.detailProyek[0].status == 'proses' ? Colors.cyan[600] : Colors.cyan[600],
                      ),
                    ],
                  ),
                ),
    );
  }

  void _showDialog(context) {
    Navigator.push(context, PageRouteTransition(animationType: AnimationType.slide_up, builder: (context) => WidgetBidProyek()));
  }

  void _showDialogUbahData(context) {
    BlocProyek blocProyek = Provider.of<BlocProyek>(context);
    blocProyek.getTagihanByParam({'id_proyek': blocProyek.detailProyek[0].id.toString()});
    blocProyek.getDetailProyekByParam({'id': blocProyek.detailProyek[0].id, 'aktif': '1'});
    Navigator.push(
        context,
        PageRouteTransition(
          animationType: AnimationType.slide_up,
          builder: (context) => WidgetUpdateProyek(),
        ));
  }

  _showDialogSelesai(BuildContext context, Proyek detailProyek) async {
    BlocProyek blocProyek = Provider.of<BlocProyek>(context);
    FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      File file = File(result.files.single.path);
      var timeStamp = DateTime.now().toUtc().millisecondsSinceEpoch;
      var fileName = timeStamp.toString() + '.' + file.path.split('.').last.toString();
      var body = {'id': detailProyek.id, 'file_laporan_akhir': fileName};
      List<File> files = [file];
      blocProyek.updateProyek(files, body);
      blocProyek.getDetailProyekByParam({'id': blocProyek.detailProyek[0].id, 'aktif': '1'});
    }
  }
}
