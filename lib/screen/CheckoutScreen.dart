import 'dart:convert';

import 'package:apps/Utils/SnapWidgetMidtrans.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/models/Cart.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/screen/ShippingAddressScreen.dart';
import 'package:apps/widget/Helper/CardRajaOngkir.dart';
import 'package:apps/widget/ShippingAddress/WidgetListPembayaran.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jiffy/jiffy.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:money2/money2.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CheckoutScreen extends StatelessWidget {
  final Cart listCart;
  final int index;
  final int subtotal;

  CheckoutScreen({Key key, this.listCart, this.subtotal, this.index}) : super(key: key);
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
  final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int totalDalamKota = 0;
  int totalRajaOngkir = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    final cart = listCart.chilrdern[0];
    AppBar appBar = AppBar(
      elevation: 0,
      title: Text('Checkout'),
    );
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar,
      body: ModalProgressHUD(
        inAsyncCall: blocProfile.isLoading || blocOrder.isLoading,
        child: Column(
          children: [
            Container(
              height: (MediaQuery.of(context).size.height * 0.9 - appBar.preferredSize.height) - MediaQuery.of(context).padding.top,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        margin: const EdgeInsets.only(top: 10.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(listCart.flag, style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Dikirim dari '),
                                Text(blocProfile.listSubDistrictById.isEmpty ? '' : blocProfile.listSubDistrictById[0].city, style: TextStyle(color: Colors.black)),
                              ],
                            ),
                            leading: Image.network(
                              'https://m-bangun.com/api-v2/assets/toko/' + listCart.chilrdern[0].fotoToko,
                              width: 40,
                              height: 80,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: blocProfile.listUserAddressDefault.isNotEmpty ? Colors.white : Colors.red.withOpacity(0.2),
                        margin: const EdgeInsets.only(top: 10.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text('Alamat Penerima'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  blocProfile.listUserAddressDefault.isEmpty
                                      ? ''
                                      : '#' + blocProfile.listUserAddressDefault[0].namaPenerima + ' ' + '(' + blocProfile.listUserAddressDefault[0].namaAlamat + ')',
                                ),
                                Text(
                                  blocProfile.listUserAddressDefault.isEmpty ? '' : blocProfile.listUserAddressDefault[0].alamatLengkap,
                                ),
                              ],
                            ),
                            leading: Icon(FontAwesomeIcons.addressBook),
                            trailing: Container(
                              height: 30,
                              width: 80,
                              child: new Row(
                                children: <Widget>[
                                  new Expanded(
                                      child: RoundedLoadingButton(
                                    child: Text('Ubah', style: TextStyle(color: Colors.white, fontSize: 12)),
                                    color: Colors.cyan[700],
                                    controller: _btnController,
                                    onPressed: () {
                                      blocProfile.getAllUserAddress(blocAuth.idUser);
                                      Navigator.push(context, SlideRightRoute(page: ShippingAddressScreen())).then((value) {
                                        Provider.of<BlocProfile>(context).getSubDistrictById(listCart.chilrdern[0].idKecamatan);
                                        Provider.of<BlocProfile>(context).getUserAddressDefault(blocAuth.idUser);
                                        blocOrder.clearCost();
                                        for (var k = 0; k < listCart.chilrdern.length; k++) {
                                          var idKotaPembeli = blocProfile.listUserAddressDefault[0].idKota;
                                          var idKotaToko = listCart.chilrdern[k].idKota;
                                          var jenisOngkir = listCart.chilrdern[k].jenisOngkir;
                                          if (jenisOngkir == 'include_dalam_kota') {
                                            if (idKotaToko != idKotaPembeli) {
                                              var beratTotal = int.parse(listCart.chilrdern[k].berat.toString()) * int.parse(listCart.chilrdern[k].jumlah.toString());
                                              totalDalamKota += beratTotal;
                                            }
                                          }
                                          if (jenisOngkir == 'raja_ongkir') {
                                            var beratTotal = int.parse(listCart.chilrdern[k].berat.toString()) * int.parse(listCart.chilrdern[k].jumlah.toString());
                                            totalRajaOngkir += beratTotal;
                                          }
                                        }
                                        if (blocProfile.listUserAddressDefault.isNotEmpty) {
                                          var param = {
                                            'origin': cart.idKecamatan.toString(),
                                            'destination': blocProfile.listUserAddressDefault[0].idKecamatan,
                                            'weight': (totalDalamKota + totalRajaOngkir) == 0 ? '1' : (totalDalamKota + totalRajaOngkir).toString()
                                          };
                                          blocOrder.getCost(param);
                                        }
                                      });
                                      _btnController.reset();
                                    },
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      blocOrder.isLoading
                          ? Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              child: PKCardListSkeleton(),
                            )
                          : blocProfile.listUserAddressDefault.isEmpty
                              ? Container()
                              : Container(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (_, j) {
                                      var idKotaPembeli = blocProfile.listUserAddressDefault[0].idKota;
                                      var idKotaToko = listCart.chilrdern[j].idKota;
//                                      print(blocOrder.listCart[0].chilrdern.where((element) => element.jenisOngkir == 'raja_ongkir').length);
                                      if (blocOrder.listCart[0].chilrdern[j].jenisOngkir == 'raja_ongkir') {
                                        return CardRajaOngkir(
                                          listCart: listCart,
                                          blocAuth: blocAuth,
                                          blocOrder: blocOrder,
                                          blocProfile: blocProfile,
                                          IDR: IDR,
                                          btnController: _btnController,
                                        );
                                      } else if (idKotaPembeli != idKotaToko && blocOrder.listCart[0].chilrdern[j].jenisOngkir == 'raja_ongkir') {
                                        return CardRajaOngkir(
                                          listCart: listCart,
                                          blocAuth: blocAuth,
                                          blocOrder: blocOrder,
                                          blocProfile: blocProfile,
                                          IDR: IDR,
                                          btnController: _btnController,
                                        );
                                      } else {
                                        return Container();
                                      }
                                    },
                                    itemCount: blocOrder.listCart[0].chilrdern.where((element) => element.jenisOngkir == 'raja_ongkir').length > 1
                                        ? 1
                                        : blocOrder.listCart[0].chilrdern.length,
                                  ),
                                ),
                      Container(
                        color: blocOrder.listMetodePembayaranSelected.isEmpty ? Colors.red.withOpacity(0.2) : Colors.white,
                        margin: const EdgeInsets.only(top: 10.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text('Metode Pembayaran'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  blocOrder.listMetodePembayaranSelected.isEmpty ? '-' : blocOrder.listMetodePembayaranSelected['metode_pembayaran'],
                                ),
                                Text(blocOrder.listMetodePembayaranSelected.isEmpty ? '' : blocOrder.listMetodePembayaranSelected['nama_bank'],
                                    style: TextStyle(color: Colors.black)),
//                                    Text(
//                                      blocOrder.listMetodePembayaranSelected.isEmpty ? '' : 'a.n ' + blocOrder.listMetodePembayaranSelected['nama_rekening'],
//                                    )
                              ],
                            ),
                            leading: Icon(FontAwesomeIcons.creditCard),
                            trailing: Container(
                              height: 30,
                              width: 80,
                              margin: const EdgeInsets.only(top: 10.0),
//                                  padding: const EdgeInsets.only(left: 90.0, right: 20.0),
                              child: new Row(
                                children: <Widget>[
                                  new Expanded(
                                      child: RoundedLoadingButton(
                                    child: Text('Ubah', style: TextStyle(color: Colors.white, fontSize: 12)),
                                    color: Colors.cyan[700],
                                    controller: _btnController,
                                    onPressed: () {
                                      blocProfile.getAllUserAddress(blocAuth.idUser);
                                      blocOrder.getMetodePembayaran();
                                      Navigator.push(context, SlideRightRoute(page: WidgetListPembayaran())).then((value) {
                                        Provider.of<BlocProfile>(context).getSubDistrictById(listCart.chilrdern[0].idKecamatan);
                                        Provider.of<BlocProfile>(context).getUserAddressDefault(blocAuth.idUser);
                                      });
                                      _btnController.reset();
                                    },
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            'Subtotal',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ),
                        Container(
                          child: Text(
                            blocOrder.listCostSelected.isEmpty
                                ? Money.fromInt((this.subtotal), IDR).toString()
                                : Money.fromInt((this.subtotal + blocOrder.listCostSelected['total_ongkir']), IDR).toString(),
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: Text('Bayar', style: TextStyle(color: Colors.white, fontSize: 18)),
                        color: Colors.green,
                        onPressed: () {
                          makePayment(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void makePayment(context) {
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    var timeStamp = DateTime
        .now()
        .toUtc()
        .millisecondsSinceEpoch;
    var totalOngkir = blocOrder.listCostSelected.isEmpty ? 0 : blocOrder.listCostSelected['total_ongkir'];
    var pengiriman = {
      "id": "ongkir",
      "price": totalOngkir.toString(),
      "quantity": "1",
      "name": blocOrder.listCostSelected['nama_kurir'].toString() + '(' + blocOrder.listCostSelected['jenis_service'].toString() + ')'
    };
    var listKeranjang = listCart.chilrdern.map((e) {
      return {"id": e.id.toString(), "price": e.harga.toString(), "quantity": e.jumlah.toString(), "name": e.nama.toString()};
    }).toList();
    listKeranjang.add(pengiriman);
    var phoneNumber = '';
    if (blocOrder.listMetodePembayaranSelected['kode'] == 'permata_va') {
      phoneNumber = blocProfile.listUserAddressDefault[0].noHp.toString().substring(2);
    } else {
      phoneNumber = blocProfile.listUserAddressDefault[0].noHp.toString();
    }
    var body = {
      "enabled_payments": [blocOrder.listMetodePembayaranSelected['kode'].toString().toLowerCase()],
      blocOrder.listMetodePembayaranSelected['kode'].toString().toLowerCase(): {"va_number": phoneNumber},
      "transaction_details": {"order_id": "$timeStamp", "gross_amount": (this.subtotal + totalOngkir).toString()},
      "item_details": listKeranjang,
      "expiry": {"start_time": "${Jiffy(DateTime.now()).format("yyyy-MM-dd HH:mm:ss")} +0700", "duration": 120, "unit": "minute"},
      "customer_details": {
        "first_name": blocAuth.currentUser.displayName.toString(),
        "last_name": "",
        "email": blocAuth.currentUser.email.toString(),
        "phone": blocProfile.listUserAddressDefault[0].noHp.toString(),
        "billing_address": {
          "first_name": blocProfile.listUserAddressDefault[0].namaPenerima.toString(),
          "last_name": "",
          "email": blocAuth.currentUser.email.toString(),
          "phone": blocProfile.listUserAddressDefault[0].noHp.toString(),
          "address": blocProfile.listUserAddressDefault[0].alamatLengkap.toString(),
          "city": '',
          "postal_code": ""
        },
        "shipping_address": {
          "first_name": blocProfile.listUserAddressDefault[0].namaPenerima.toString(),
          "last_name": "",
          "email": blocAuth.currentUser.email.toString(),
          "phone": blocProfile.listUserAddressDefault[0].noHp.toString(),
          "address": blocProfile.listUserAddressDefault[0].alamatLengkap.toString(),
          "city": "",
          "postal_code": ""
        },
      }
    };
    var data = json.encode(body);
//    print(data);
    var result = blocOrder.makePayment(data);
    result.then((value) {
      if (value['token'] != null) {
        saveTransaction(context, timeStamp, value);
      }
    });
  }

  void saveTransaction(context, noOrder, responMidtrasn) {
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    var totalOngkir = blocOrder.listCostSelected.isEmpty ? 0 : blocOrder.listCostSelected['total_ongkir'];
    Map data_order = {
      'id_toko': listCart.chilrdern[0].idToko.toString(),
      'id_pembeli': blocAuth.idUser.toString(),
      'no_order': noOrder.toString(),
      'subtotal': this.subtotal.toString(),
      'total_ongkir': totalOngkir.toString(),
      'total': (this.subtotal + totalOngkir).toString(),
      'metode_pembayaran': blocOrder.listMetodePembayaranSelected['metode_pembayaran'].toString(),
      'status_pembayaran': 'menunggu'.toString(),
      'total_diskon': '0'.toString(),
      'total_lain_lain': '0'.toString(),
      'kode_kurir': blocOrder.listCostSelected['kode_kurir'].toString(),
      'nama_kurir': blocOrder.listCostSelected['nama_kurir'].toString(),
      'estimasi_pengiriman': blocOrder.listCostSelected['estimasi_pengiriman'].toString(),
      'jenis_service': blocOrder.listCostSelected['jenis_service'].toString(),
      'no_rekening': blocOrder.listMetodePembayaranSelected['no_rekening'].toString(),
      'nama_rekening': blocOrder.listMetodePembayaranSelected['nama_rekening'].toString(),
      'nama_bank': blocOrder.listMetodePembayaranSelected['nama_bank'].toString(),
      'token_va': responMidtrasn['token']
    };
    Map data_expired = {"expiry_duration": '120', "unit": "minute"};
    Map data_penerima = {
      'id_user_login': blocAuth.idUser.toString(),
      'nama_penerima': blocProfile.listUserAddressDefault[0].namaPenerima.toString(),
      'no_hp_penerima': blocProfile.listUserAddressDefault[0].noHp.toString(),
      'nama_alamat': blocProfile.listUserAddressDefault[0].namaAlamat.toString(),
      'id_kecamatan': blocProfile.listUserAddressDefault[0].idKecamatan.toString(),
      'alamat_lengkap': blocProfile.listUserAddressDefault[0].alamatLengkap.toString(),
    };
    List data_produk = [];
    for (var i = 0; i < listCart.chilrdern.length; i++) {
      Map dataProduk = {
        'id_produk': listCart.chilrdern[i].idProduk.toString(),
        'id_keranjang': listCart.chilrdern[i].id.toString(),
        'nama_produk': listCart.chilrdern[i].nama.toString(),
        'harga': listCart.chilrdern[i].harga.toString(),
        'jumlah': listCart.chilrdern[i].jumlah.toString(),
        'subtotal': (int.parse(listCart.chilrdern[i].jumlah.toString()) * int.parse(listCart.chilrdern[i].harga)).toString(),
        'berat': listCart.chilrdern[i].berat.toString(),
        'slug': listCart.chilrdern[i].nama.toString(),
        'catatan': listCart.chilrdern[i].catatan.toString(),
      };
      data_produk.add(dataProduk);
    }
    blocOrder.setErrorShippingAddres(false);
    blocOrder.setErrorMethodeTransfer(false);

    Map body = {'data_order': data_order, 'data_produk': data_produk, 'data_penerima': data_penerima, 'expired_time': data_expired};

    var rajaOngkir = blocOrder.listCart[0].chilrdern
        .where((element) => element.jenisOngkir == 'raja_ongkir')
        .length;
    var result = blocOrder.getCart();
    result.then((value) {
      var aktif = value[index]['chilrdern']
          .where((element) => element['aktif'] == '0')
          .length;
      var stok = value[index]['chilrdern']
          .where((element) => element['stok'] == '0')
          .length;
      if (aktif <= 0 && stok <= 0) {
//        print('push');
        if (rajaOngkir == 0 && blocOrder.listMetodePembayaranSelected.isNotEmpty && blocProfile.listUserAddressDefault.isNotEmpty) {
          Navigator.push(
            context,
            SlideRightRoute(
              page: SnapWidgetMidtrans(
                tokenSnap: responMidtrasn['token'],
                urlSnap: responMidtrasn['redirect_url'],
                bodyTransaction: body,
              ),
            ),
          );
//          print('pembayaran free ongkir');
        } else if (blocOrder.listCostSelected.isNotEmpty && rajaOngkir == 1 && blocOrder.listMetodePembayaranSelected.isNotEmpty && blocProfile.listUserAddressDefault.isNotEmpty) {
          print('cost');
          Navigator.push(
            context,
            SlideRightRoute(
              page: SnapWidgetMidtrans(
                tokenSnap: responMidtrasn['token'],
                urlSnap: responMidtrasn['redirect_url'],
                bodyTransaction: body,
              ),
            ),
          );
//          Navigator.push(context, SlideRightRoute(page: WidgetWaitingPayment(body: body, idOrder: noOrder)));
        }
      } else {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Barang tidak tersedia'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ));
//        print('not');
      }
    });
  }

  void _showToast(String message, Color color) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: Duration(seconds: 3),
    ));
  }
}
