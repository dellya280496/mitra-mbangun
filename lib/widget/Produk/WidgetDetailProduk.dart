import 'dart:convert';

import 'package:apps/Api/Api.dart';
import 'package:apps/Utils/PreviewFoto.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/widget/Produk/component/WidgetDeskripsiProduk.dart';
import 'package:apps/widget/Produk/component/WidgetDetailBahanProduk.dart';
import 'package:apps/widget/Produk/component/WidgetDetailLokasi.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:route_transitions/route_transitions.dart';

class WidgetDetailProduk extends StatefulWidget {
  WidgetDetailProduk({Key key}) : super(key: key);

  @override
  _WidgetDetailProdukState createState() {
    return _WidgetDetailProdukState();
  }
}

class _WidgetDetailProdukState extends State<WidgetDetailProduk> {
  TextEditingController waktuPengerjaanController, deskripsiController, budgetController = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();

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
    var data = dataProvider.getdataProdukById;
    var budget = dataProvider.getdataProdukById == null ? '0' : dataProvider.getdataProdukById['data'][0]['produkbudget'];
    budgetController.text = budget;
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
                  height: MediaQuery.of(context).size.height * 0.9,
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
                              child: WidgetDetailLokasi(dataProvider: dataProvider),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: WidgetDetailBahanProduk(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))),
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.1,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(
                          dataProvider.favoriteProduk ? Icons.favorite : Icons.favorite_border,
                          color: Colors.pink,
                        ),
                        onPressed: () {
                          if (dataProvider.isLogin) {
                            if (dataProvider.favoriteProduk) {
                              dataProvider.deleteFavoriteByUserId(dataProvider.getdataProdukById['data'][0]['produkid']);
                            } else {
                              dataProvider.setFavoriveByUserId(dataProvider.getdataProdukById['data'][0]['produkid']);
                            }
                          } else {
                            Flushbar(
                              title: "Error",
                              message: "Silahkan login / daftar member",
                              duration: Duration(seconds: 5),
                              backgroundColor: Colors.red,
                              flushbarPosition: FlushbarPosition.BOTTOM,
                              icon: Icon(
                                Icons.assignment_turned_in,
                                color: Colors.white,
                              ),
                            )
                              ..show(context);
                          }
                        },
                      ),
                      dataProvider.getdataProdukById['data'][0]['produkkategoriflag'] == '2' ? _buttonBuy() : _buttonBid()
                    ],
                  ),
                )
              ],
      ),
    );
  }

  Widget _buttonBid() {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    return Container(
      child: InkWell(
        onTap: () {
          !dataProvider.isBid ? _showDialog() : null;
        },
        child: Center(
            child: Text(
              'Bid',
              style: TextStyle(color: Colors.white),
            )),
      ),
      height: 40,
      width: MediaQuery
          .of(context)
          .size
          .width * 0.7,
      decoration: BoxDecoration(color: !dataProvider.isBid ? Colors.cyan[600] : Colors.grey, borderRadius: BorderRadius.circular(20)),
    );
  }

  Widget _buttonBuy() {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    return Container(
      child: InkWell(
        onTap: () {
          !dataProvider.isBid ? _showDialog() : null;
        },
        child: Center(
            child: Text(
              'Beli',
              style: TextStyle(color: Colors.white),
            )),
      ),
      height: 40,
      width: MediaQuery
          .of(context)
          .size
          .width * 0.7,
      decoration: BoxDecoration(color: !dataProvider.isBid ? Colors.cyan[600] : Colors.grey, borderRadius: BorderRadius.circular(20)),
    );
  }

  void _showDialog() {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    if (dataProvider.userId_ == null) {
      Flushbar(
        title: "Error",
        message: "Silahkan login / daftar member",
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        flushbarPosition: FlushbarPosition.BOTTOM,
        icon: Icon(
          Icons.assignment_turned_in,
          color: Colors.white,
        ),
      )..show(context);
    } else {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Form(
            key: _formKey,
            autovalidate: false,
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.58,
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
                          inputFormatters: [MoneyInputFormatter(useSymbolPadding: true, mantissaLength: 0, leadingSymbol: 'Rp')],
                          validator: (String arg) {
                            if (arg.length < 1)
                              return 'Harus di isi';
                            else
                              return null;
                          },
                          controller: budgetController,
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 18, color: Colors.green),
                          decoration: const InputDecoration(
                              hintText: 'Rp 100,000',
                              labelText: 'Ajukan Budget anda',
                              errorText: 'ganti jika anda memiliki budget penawaran',
//                          hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
//                          labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
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
                          controller: waktuPengerjaanController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              hintText: '15 Hari',
                              labelText: 'Ajukan Waktu Pengerjaan',
//                          labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
//                          hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
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
//                      focusNode: myFocusNodeBahan,
                          controller: deskripsiController,
                          validator: (String arg) {
                            if (arg.length < 1)
                              return 'Harus di isi';
                            else
                              return null;
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

  bidding() async {
    if (_formKey.currentState.validate()) {
      DataProvider dataProvider = Provider.of<DataProvider>(context);
      var budget = budgetController.text.replaceAll('Rp', '');
      var saveBudget = budget.replaceAll(',', '');
      var map = new Map<String, dynamic>();
      map['userid'] = dataProvider.userId;
      map['bidprice'] = saveBudget;
      map['biddeskripsi'] = deskripsiController.text;
      map['produkid'] = dataProvider.getdataProdukById['data'][0]['produkid'];
      map['bidwaktupengerjaan'] = waktuPengerjaanController.text;
      Api.addBids(dataProvider.token, map).then((response) async {
        print(response.body);
        var result = json.decode(response.body);
        if (result['status'] == true) {
          _btnController.success();
          await new Future.delayed(const Duration(seconds: 3));
          Navigator.pop(context);
          dataProvider.chekUserBidding(dataProvider.getdataProdukById['data'][0]['produkid']);
        } else {
          _btnController.error();
          await new Future.delayed(const Duration(seconds: 3));
          _btnController.reset();
        }
      });
    } else {
      _btnController.error();
      FocusScope.of(context).requestFocus(FocusNode());
      await new Future.delayed(const Duration(seconds: 3));
      _btnController.reset();
    }
  }
}
