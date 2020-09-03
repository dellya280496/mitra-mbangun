import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/screen/LoginScreen.dart';
import 'package:apps/widget/Keranjang/Keranjang.dart';
import 'package:apps/widget/Produk/component/WidgetDeskripsiDetailProduk.dart';
import 'package:apps/widget/Produk/component/WidgetFlexibleSpaceDetailProduct.dart';
import 'package:apps/widget/Produk/component/WidgetHeaderDetailProduct.dart';
import 'package:apps/widget/Produk/component/WidgetInformasiDetailProduk.dart';
import 'package:apps/widget/Produk/component/WidgetLeadingTopDetaikProduct.dart';
import 'package:apps/widget/Produk/component/WidgetUlasanPembeli.dart';
import 'package:flutter/material.dart';
import 'package:money2/money2.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ProdukDetailScreen extends StatelessWidget {
  ProdukDetailScreen({Key key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String catatan;
  int jumlah = 1;
  final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BlocProduk blocProduk = Provider.of<BlocProduk>(context);
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    return Scaffold(
//      backgroundColor: Colors.white,
      body: blocProduk.isLoading
          ? Center(child: PKCardListSkeleton())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: NestedScrollView(
                      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          SliverAppBar(
                            automaticallyImplyLeading: true,
                            expandedHeight: 380.0,
                            floating: false,
                            pinned: true,
                            leading: WidgetLeadingTopDetaikProduct(),
                            flexibleSpace: WidgetFlexibleSpaceDetailProduct(blocProduk: blocProduk, hashCode: hashCode),
                          ),
                        ];
                      },
                      body: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            WidgetHeaderDetailProduct(blocProduk: blocProduk, blocOrder: blocOrder, IDR: IDR),
                            WidgetInformasiDetailProduk(blocProduk: blocProduk),
                            WidgetDeskripsiDetailProduk(blocProduk: blocProduk),
                            WidgetUlasanPembeli(blocProduk: blocProduk),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
//                  decoration: BoxDecoration(color: Colors.grey.withOpacity(0.3), borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))),
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            BlocAuth blocAuth = Provider.of<BlocAuth>(context);
                            BlocProfile blocProfile = Provider.of<BlocProfile>(context);
                            blocProfile.getUserAddressDefault(blocAuth.idUser);
                            blocOrder.getCart();
                            Navigator.push(context, SlideRightRoute(page: Keranjang()));
                          },
                          child: Stack(
                            children: <Widget>[
                              Icon(
                                Icons.shopping_cart,
                                size: 25,
                                color: Colors.cyan,
                              ),
                              blocOrder.listCart.length == 0
                                  ? Container(
                                      child: Text(''),
                                    )
                                  : Positioned(
                                      top: 0.0,
                                      right: 0.0,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                                        alignment: Alignment.center,
                                        child: Text(
                                          blocOrder.listCart.length.toString(),
                                          style: TextStyle(color: Colors.white, fontSize: 8),
                                        ),
                                      ),
                                    )
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.favorite_border,
                            color: Colors.cyan,
                            size: 25,
                          ),
                          onPressed: () {
                            if (blocAuth.isLogin) {
//                           Navigator.
                            } else {}
                          },
                        ),
                        _buttonBuy(context)
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget _buttonBuy(context) {
    BlocProduk blocProduk = Provider.of<BlocProduk>(context);
    return Container(
      child: InkWell(
        onTap: () {
          blocProduk.detailProduct[0].stok == '0' ? '' : _showDialog(context);
        },
        child: Center(
            child: Text(
          blocProduk.detailProduct[0].stok == '0' ? 'Stok tidak tersedia' : 'Beli',
          style: TextStyle(color: Colors.white),
        )),
      ),
      height: 40,
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(color: blocProduk.detailProduct[0].stok == '0' ? Colors.grey[400] : Colors.cyan, borderRadius: BorderRadius.circular(20)),
    );
  }

  void _showDialog(context) async {
    imageCache.clear();
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    BlocProduk blocProduk = Provider.of<BlocProduk>(context);
    blocAuth.checkSession();
    if (!blocAuth.isLogin) {
      Navigator.push(
          context,
          SlideRightRoute(
              page: LoginScreen(
                param: 'product',
              )));
    } else {
      Future<void> future = showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return ChangeNotifierProvider<BlocOrder>(
            builder: (context) => BlocOrder(),
            child: Consumer<BlocOrder>(builder: (context, blocOrder, _) {
              final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
              return Form(
                key: _formKey,
                autovalidate: false,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Tambah ke keranjang',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.clear))
                        ],
                      ),
//                    Divider(),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
                          child: Container(
                            color: Colors.white38,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 0),
                                        child: Image.network('https://m-bangun.com/api-v2/assets/toko/' + blocProduk.detailProduct[0].foto, width: 50, height: 80,
                                            errorBuilder: (context, urlImage, error) {
                                              print(error.hashCode);
                                              return Image.asset(
                                                'assets/logo.png',
                                                height: 40,
                                              );
                                            }),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.5,
                                            margin: EdgeInsets.only(top: 50),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Harga ',
                                                  style: TextStyle(fontSize: 12, color: Colors.grey),
                                                ),
                                                Text(Money.fromInt((int.parse(blocProduk.detailProduct[0].harga)), IDR).toString(),
                                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                                Text('Jumlah', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.5,
                                            child: TextFormField(
                                              onChanged: (value) {
                                                blocOrder.setCatatan(value);
                                              },
                                              style: TextStyle(fontSize: 11),
                                              maxLines: 2,
                                              keyboardType: TextInputType.multiline,
                                              decoration: InputDecoration(
                                                hintText: 'Catatan untuk penjual',
                                                hintStyle: TextStyle(color: Colors.grey, fontSize: 11, fontStyle: FontStyle.italic),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.5,
                                            margin: EdgeInsets.only(top: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Subtotal',
                                                  style: TextStyle(fontSize: 14, color: Colors.grey),
                                                ),
                                                Text(
                                                  Money.fromInt((int.parse(blocProduk.detailProduct[0].harga) * blocOrder.jumlah), IDR).toString(),
                                                  style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 0.0, top: 0, bottom: 30.0),
                                        child: Theme(
                                          data: ThemeData(
                                              accentColor: Colors.black,
                                              textTheme: TextTheme(
                                                headline: TextStyle(fontFamily: 'Montserrat', fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                                                body1: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 12,
                                                  color: Colors.grey[400],
                                                ),
                                              )),
                                          child: blocProduk.detailProduct[0].stok == '1'
                                              ? Text(
                                            '1',
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                          )
                                              : NumberPicker.integer(
                                            initialValue: blocOrder.jumlah,
                                            minValue: 1,
                                            maxValue: int.parse(blocProduk.detailProduct[0].stok),
                                            onChanged: (value) {
                                              blocOrder.setJumlah(value);
                                            },
                                            itemExtent: 30,
                                            listViewWidth: 30,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      blocOrder.jumlah < int.parse(blocProduk.detailProduct[0].minimalPesanan)
                          ? RoundedLoadingButton(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              child: Text('Tambah Keranjang', style: TextStyle(color: Colors.white)),
                              color: Colors.grey,
                              controller: _btnController,
                            )
                          : RoundedLoadingButton(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 40,
                        child: Text('Tambah Keranjang', style: TextStyle(color: Colors.white)),
                        color: Colors.cyan,
                        controller: _btnController,
                        onPressed: () async {
                          var map = new Map<String, String>();
                          map["id_produk"] = blocProduk.detailProduct[0].id;
                          map["id_user_login"] = blocAuth.idUser;
                          map["jumlah"] = blocOrder.jumlah.toString();
                          map["harga"] = blocProduk.detailProduct[0].harga;
                          map["subtotal"] = (int.parse(blocProduk.detailProduct[0].harga) * blocOrder.jumlah).toString();
                          map["id_toko"] = blocProduk.detailProduct[0].idToko;
                          map["jenis_ongkir"] = blocProduk.detailProduct[0].jenisOngkir;
                          map["catatan"] = blocOrder.catatan;
                          var result = blocProduk.getCurrentStokProduk({'id': blocProduk.detailProduct[0].id.toString()});
                          result.then((value) async {
                            print(value['stok']);
                            if (value['stok'] != '0') {
                              var response = await blocOrder.addToCart(map);
                              if (response) {
                                _btnController.success();
                                blocOrder.getCart();
                                await new Future.delayed(const Duration(seconds: 1));
                                Navigator.pop(context);
                              } else {
                                _btnController.error();
                                await new Future.delayed(const Duration(seconds: 1));
                                _btnController.reset();
                              }
                            } else {
                              _btnController.error();
                              await new Future.delayed(const Duration(seconds: 1));
                              _btnController.reset();
                              Navigator.pop(context);
                              blocProduk.getDetailProductByParam({'id': blocProduk.detailProduct[0].id.toString()});
                            }
                          });
                        },
                      )
                    ],
                  ),
                ),
              );
            }),
          );
        },
      );
      future.then((void value) => _closeModal(context));
    }
  }

  void _closeModal(context) {
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    blocOrder.getCart();
  }
}
