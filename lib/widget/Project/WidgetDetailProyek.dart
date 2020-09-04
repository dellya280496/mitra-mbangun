import 'package:apps/Utils/PreviewFoto.dart';
import 'package:apps/models/Proyek.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocProyek.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/widget/Kontrak/WidgetKontrak.dart';
import 'package:apps/widget/Project/component/WidgetDeskripsiProyek.dart';
import 'package:apps/widget/Project/component/WidgetDetailBahan.dart';
import 'package:apps/widget/Project/component/WidgetDetailLokasi.dart';
import 'package:apps/widget/Project/component/WidgetListPekerja.dart';
import 'package:apps/widget/Project/component/WidgetSurveyInformation.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:money2/money2.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:route_transitions/route_transitions.dart';

class WidgetDetailProyek extends StatefulWidget {
  WidgetDetailProyek({Key key, @required this.param}) : super(key: key);

  final Proyek param;

  @override
  _WidgetDetailProyekState createState() => _WidgetDetailProyekState();
}

class _WidgetDetailProyekState extends State<WidgetDetailProyek> {
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String waktuPenawaran, catatan;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    var data = dataProvider.getdataProdukById;
    BlocProyek blocProyek = Provider.of<BlocProyek>(context);
    final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
    var budget = Money.fromInt(int.parse(blocProyek.detailProyek[0].budget.toString()), IDR).toString();
    return Scaffold(
      body: blocProyek.isLoading
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
          : Column(
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
                                                : 'https://m-bangun.com/api-v2/assets/toko/' + blocProyek.detailProyek[0].foto1,
                                          ),
                                        ));
                                  },
                                  child: Image.network(
                                    blocProyek.detailProyek[0].foto1 == null
                                        ? dataProvider.fotoNull
                                        : 'https://m-bangun.com/api-v2/assets/toko/' + blocProyek.detailProyek[0].foto1,
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
                                                : 'https://m-bangun.com/api-v2/assets/toko/' + blocProyek.detailProyek[0].foto2,
                                          ),
                                        ));
                                  },
                                  child: Image.network(
                                    blocProyek.detailProyek[0].foto3 == null
                                        ? dataProvider.fotoNull
                                        : 'https://m-bangun.com/api-v2/assets/toko/' + blocProyek.detailProyek[0].foto3,
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
                                                : 'https://m-bangun.com/api-v2/assets/toko/' + blocProyek.detailProyek[0].foto3,
                                          ),
                                        ));
                                  },
                                  child: Image.network(
                                    blocProyek.detailProyek[0].foto3 == null
                                        ? dataProvider.fotoNull
                                        : 'https://m-bangun.com/api-v2/assets/toko/' + blocProyek.detailProyek[0].foto3,
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
                                            urlFoto: blocProyek.detailProyek[0].foto4 == null
                                                ? dataProvider.fotoNull
                                                : 'https://m-bangun.com/api-v2/assets/toko/' + blocProyek.detailProyek[0].foto4,
                                          ),
                                        ));
                                  },
                                  child: Image.network(
                                    blocProyek.detailProyek[0].foto4 == null
                                        ? dataProvider.fotoNull
                                        : 'https://m-bangun.com/api-v2/assets/toko/' + blocProyek.detailProyek[0].foto4,
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
                                  created: blocProyek.detailProyek[0].createdAt,
                                  lokasi: blocProyek.detailProyek[0].alamatLengkap,
                                  nama: blocProyek.detailProyek[0].nama,
                                  jenisLayanan: blocProyek.detailProyek[0].namaLayanan,
                                  budget: budget),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: WidgetDetailLokasi(
                                alamatLengkap: blocProyek.detailProyek[0].alamatLengkap,
                              ),
                            ),
                            widget.param.status == 'setuju'
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: WidgetDetailBahan(),
                                  )
                                : Container(),
                            widget.param.status == 'setuju'
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: WidgetListPekerja(
                                      param: widget.param,
                                    ),
                                  )
                                : Container(),
                            widget.param.status == 'proses'
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: WidgetKontrak(
                                      param: 'owner',
                                    ),
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)), color: Colors.white),
        height: 55,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              height: 35,
              minWidth: MediaQuery.of(context).size.width * 0.9,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Text(
                'Apply',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                blocProyek.listBids.isNotEmpty ? null : _showDialog(context);
              },
              color: blocProyek.listBids.isNotEmpty ? Colors.grey : Colors.cyan[600],
            )
          ],
        ),
      ),
    );
  }

  void _showDialog(context) {
    BlocProyek blocProyek = Provider.of<BlocProyek>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    if (!blocAuth.isLogin) {
    } else {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Form(
            key: _formKey,
            autovalidate: false,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.58,
              padding: EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Apply Penawaran Anda',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.clear))
                      ],
                    ),
                    Divider(),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new TextFormField(
                          validator: (String arg) {
                            if (arg.length < 1)
                              return 'Harus di isi';
                            else
                              return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              waktuPenawaran = value;
                            });
                          },
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              hintText: '15 Hari',
                              labelText: 'Ajukan Waktu Pengerjaan',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xffb16a085),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xffb16a085),
                                ),
                              ),
                              hasFloatingPlaceholder: true),
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new TextFormField(
                          validator: (String arg) {
                            if (arg.length < 1)
                              return 'Harus di isi';
                            else
                              return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              catatan = value;
                            });
                          },
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                              labelText: "Catatan",
                              hintText: 'Catatan',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xffb16a085),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xffb16a085),
                                ),
                              ),
                              hasFloatingPlaceholder: true),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    RoundedLoadingButton(
                      child: Text('Apply', style: TextStyle(color: Colors.white)),
                      color: Colors.red,
                      controller: _btnController,
                      onPressed: () => bidding(),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }

  bidding() {
    BlocProyek blocProyek = Provider.of<BlocProyek>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    _formKey.currentState.save();
    _btnController.reset();
    var body = {
      'id_projek': blocProyek.detailProyek[0].id.toString(),
      'id_user': blocProyek.detailProyek[0].idUserLogin.toString(),
      'id_mitra': blocAuth.idUser.toString(),
      'deskripsi': catatan.toString(),
      'waktu_pengerjaan': waktuPenawaran.toString(),
      'status': '0'
    };
    if (_formKey.currentState.validate()) {
      var result = blocProyek.addBidding(body);
      result.then((value) {
        if (value) {
          blocProyek.getBidsByParam({'id_mitra': blocAuth.idUser, 'id_projek': widget.param.id});
          Navigator.pop(context);
        }
      });
    }
  }
}
