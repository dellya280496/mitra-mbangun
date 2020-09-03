import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money2/money2.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class WidgetDetailOrderProdukPembelian extends StatelessWidget {
  final String title;
  final order;

  WidgetDetailOrderProdukPembelian({Key key, this.order, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    var totalTerUlas = blocOrder.listOrderDetailProduk.where((element) => element.statusUlasan != null).length;
    var totalOrder = blocOrder.listOrderDetailProduk.length;
    final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
    // TODO: implement build
    print(order.statusUlasan + 'status');
    AppBar appBar = AppBar(
      title: Text('Detail Produk'),
    );
    return Scaffold(
      appBar: appBar,
      body: blocOrder.isLoading
          ? PKCardListSkeleton()
          : Container(
              decoration: BoxDecoration(color: Colors.grey[100], image: DecorationImage(image: AssetImage('assets/shipping_background.png'), fit: BoxFit.contain)),
              height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top),
              child: Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: RefreshIndicator(
                      onRefresh: () async {
                        onRefresh(context, order.id);
                      },
                      child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(10),
                          itemCount: blocOrder.listOrderDetailProduk.length,
                          itemBuilder: (_, j) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: Image.network(
                                    'https://m-bangun.com/api-v2/assets/toko/' + blocOrder.listOrderDetailProduk[j].foto,
                                    errorBuilder: (context, urlImage, error) {
                                      print(error.hashCode);
                                      return Image.asset('assets/logo.png');
                                    },
                                    width: 80,
                                  ),
                                  title: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    text: TextSpan(
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black,
                                        ),
                                        text: blocOrder.listOrderDetailProduk[j].namaProduk),
                                  ),
                                  subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(Money.fromInt((int.parse(blocOrder.listOrderDetailProduk[j].subtotal)), IDR).toString(),
                                          style: TextStyle(fontStyle: FontStyle.normal, color: Colors.redAccent)),
                                      Text(
                                        blocOrder.listOrderDetailProduk[j].catatan == null ? '-' : '"' + blocOrder.listOrderDetailProduk[j].catatan + '"',
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      title.toString().toLowerCase() == 'selesai'
                                          ? blocOrder.listOrderDetailProduk[j].statusUlasan == '1'
                                              ? Container()
                                              : SizedBox(
                                                  height: 25,
                                                  width: double.infinity,
                                                  child: RaisedButton(
                                                    child: Text(
                                                      'Ulas Produk',
                                                      style: TextStyle(fontSize: 12),
                                                    ),
                                                    color: Colors.orangeAccent,
                                                    textColor: Colors.white,
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                    onPressed: () async {
                                                      _ulasaPopUp(context, blocAuth, blocOrder, blocOrder.listOrderDetailProduk[j]);
                                                    },
                                                  ),
                                                )
                                          : Container()
                                    ],
                                  ),
                                  trailing: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(color: Colors.orange[100], borderRadius: BorderRadius.all(Radius.circular(50))),
                                      child: Center(
                                        child: Text(
                                          blocOrder.listOrderDetailProduk[j].jumlah,
                                          style: TextStyle(color: Colors.orange[900]),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                      child: Container(
                        width: 150,
                        child: this.title == 'menunggu_konfirmasi'
                            ? Image.asset(
                                'assets/img/waiting.png',
                                fit: BoxFit.fitWidth,
                              )
                            : this.title == 'dikemas'
                                ? Image.asset(
                                    'assets/img/packing.png',
                                    fit: BoxFit.fitWidth,
                                  )
                                : this.title == 'dikirim'
                                    ? Image.asset(
                                        'assets/img/dikirim.png',
                                        fit: BoxFit.fitWidth,
                                      )
                                    : this.title == 'ulasan'
                                        ? Image.asset(
                                            'assets/img/waiting.png',
                                            fit: BoxFit.fitWidth,
                                          )
                                        : Image.asset(
                                            'assets/img/waiting.png',
                                            fit: BoxFit.fitWidth,
                                          ),
                      ),
                    ),
                  ),
                  title.toLowerCase().toLowerCase() != 'dikirim'
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: RaisedButton(
                              child: Text(
                                title.toLowerCase() == 'dikirim' ? 'Barang diterima' : title == 'menunggu konfirmasi' ? 'Kemas Barang' : title,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              color: Color(0xffb16a085),
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              onPressed: () async {
                                _confirmPopUp(context, blocOrder, blocAuth);
                              },
                            ),
                          ),
                  ),
                  title.toLowerCase().toLowerCase() != 'selesai'
                      ? Container()
                      : order.statusUlasan.toString() != '0'
                      ? Container()
                      : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: RaisedButton(
                        child: Text(
                          'Beri Rating Penjual',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        color: Color(0xffb16a085),
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        onPressed: () async {
                          _ulasanToko(context, blocAuth, blocOrder);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  _confirmPopUp(context, BlocOrder blocOrder, blocAuth) async {
    Future<void> future = showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        String title = "Penerimaan barang";
        String btnLabel = "Terima";
        String btnLabelCancel = "Belum";
        return WillPopScope(
          onWillPop: () {},
          child: new CupertinoAlertDialog(
            title: Text(title),
            content: Column(
              children: <Widget>[
                Text("Apakah Anda yakin barang sudah anda terima?"),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(btnLabelCancel),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                  child: Text(btnLabel),
                  onPressed: () {
                    var body = {'id': order.id.toString(), 'status_order': this.title.toLowerCase() == 'dikirim' ? 'selesai' : '', 'id_toko': order.idToko.toString()};
                    Navigator.pop(context);
                    var result = blocOrder.updateOrder(body);
                    result.then((value) {
                      print(value);
                      if (value) {
                        var param = {'id_pembeli': blocAuth.idToko.toString(), 'status_order': title.toString().toLowerCase(), 'status_pembayaran': 'terbayar'};
                        blocOrder.getOrderByParam(param);
                        blocOrder.setIdUser();
                      }
                    });
                  }),
            ],
          ),
        );
      },
    );
    future.then((void value) {
      Navigator.pop(context);
    });
  }

  _ulasaPopUp(context, BlocAuth blocAuth, BlocOrder blocOrder, order) async {
    Future<void> future = showDialog<void>(
      context: context,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: Container(
          height: 200,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  'Ulas produk ini!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SmoothStarRating(
                rating: 0,
                isReadOnly: false,
                color: Colors.amber,
                size: 40,
                filledIconData: Icons.star,
                halfFilledIconData: Icons.star_half,
                defaultIconData: Icons.star_border,
                starCount: 5,
                allowHalfRating: true,
                spacing: 2.0,
                onRated: (value) {
                  blocOrder.changeRating(value.toString());
                },
              ),
              SizedBox(
                height: 15,
              ),
              new Expanded(
                child: new TextField(
                  autofocus: true,
                  maxLines: 5,
                  onChanged: (value) {
                    blocOrder.changeUlasan(value);
                  },
                  style: TextStyle(fontSize: 12),
                  decoration: new InputDecoration(labelText: 'Tulis ulasan', labelStyle: TextStyle(fontSize: 16), hintText: 'Berikan ulasan untuk produk ini!'),
                ),
              )
            ],
          ),
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.pop(context);
              }),
          new FlatButton(
              child: const Text('Submit'),
              onPressed: () async {
                Navigator.pop(context);
                var body = {
                  'id_order_produk': order.id,
                  'id_produk': order.idProduk,
                  'id_user_login': blocAuth.idUser,
                  'rating': blocOrder.rating.toString(),
                  'ulasan': blocOrder.ulasan.toString()
                };
                var result = await blocOrder.insertUlasan(body);
                if (result) {
                  onRefresh(context, order.idOrder);
                }
              })
        ],
      ),
    );
  }

  _ulasanToko(context, BlocAuth blocAuth, BlocOrder blocOrder) async {
    Future<void> future = showDialog<void>(
      context: context,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: Container(
          height: 100,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  'Ulas toko ini',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              new Expanded(
                child: new TextField(
                  autofocus: true,
                  maxLines: 5,
                  onChanged: (value) {
                    blocOrder.changeUlasan(value);
                  },
                  style: TextStyle(fontSize: 12),
                  decoration: new InputDecoration(labelText: 'Tulis ulasan', labelStyle: TextStyle(fontSize: 16), hintText: 'Berikan ulasan untuk produk ini!'),
                ),
              )
            ],
          ),
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('Tidak Suka'),
              onPressed: () async {
                Navigator.pop(context);
                var body = {'id_order': order.id, 'id_toko': order.idToko, 'id_user_login': blocAuth.idUser, 'suka': '0', 'komentar': blocOrder.ulasan.toString()};
                var result = await blocOrder.insertUlasanToko(body);
                if (result) {
                  onRefresh(context, this.order.id);
                }
              }),
          new FlatButton(
              child: const Text('Suka'),
              onPressed: () async {
                Navigator.pop(context);
                var body = {'id_order': order.id, 'id_toko': order.idToko, 'id_user_login': blocAuth.idUser, 'suka': '1', 'komentar': blocOrder.ulasan.toString()};
                var result = await blocOrder.insertUlasanToko(body);
                if (result) {
                  Navigator.pop(context);
                  onRefresh(context, this.order.id);
                }
              })
        ],
      ),
    );
  }

  onRefresh(context, idOrder) {
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    var param = {
      'id_order': idOrder.toString(),
    };
    blocOrder.getOrderProdukByParam(param);
    if (title == 'Menunggu Pembayaran') {
      var param = {'id_pembeli': blocAuth.idUser.toString(), 'status_pembayaran': title == 'Menunggu Pembayaran' ? 'menunggu' : 'terbayar'};
      blocOrder.getOrderByParam(param);
    } else {
      var param = {'id_pembeli': blocAuth.idUser.toString(), 'status_order': title.toString(), 'status_pembayaran': 'terbayar'};
      blocOrder.getOrderByParam(param);
    }
  }
}

class Location {
  String city;
  DateTime date;
  bool showHour;
  bool isHere;
  bool passed;

  Location(this.city, this.date, {this.showHour = false, this.isHere = false, this.passed = false});

  String getDate() {
    if (showHour) {
      return DateFormat("K:mm aaa, d MMMM y").format(date);
    } else {
      return DateFormat('d MMMM y').format(date);
    }
  }
}
