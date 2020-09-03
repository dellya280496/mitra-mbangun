import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/screen/CheckoutScreen.dart';
import 'package:apps/screen/DetailTokoScreen.dart';
import 'package:apps/widget/Keranjang/components/shop_item_list.dart';
import 'package:apps/widget/Keranjang/components/shop_item_list_non_aktive.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';
import 'package:sup/sup.dart';

class Keranjang extends StatefulWidget {
  Keranjang({Key key}) : super(key: key);

  @override
  _KeranjangState createState() => _KeranjangState();
}

final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');

class _KeranjangState extends State<Keranjang> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    BlocProduk blocProduk = Provider.of<BlocProduk>(context);
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    AppBar appBar = AppBar(
      elevation: 0,
      title: Text('Keranjang'),
    );
    return ModalProgressHUD(
      inAsyncCall: blocOrder.isLoading,
      child: Scaffold(
        appBar: appBar,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: RefreshIndicator(
                  onRefresh: () async {
                    onRefresh();
                  },
                  child: Container(
                    height: (MediaQuery.of(context).size.height - 20) - (appBar.preferredSize.height + MediaQuery.of(context).padding.top),
                    child: Column(
                      children: [
                        Expanded(
                          child: blocOrder.listCart.isEmpty
                              ? Center(
                                  child: Sup(
                                    title: Text('Belanja dulu yuk !!!'),
                                    image: Image.asset(
                                      'assets/icons/empty_cart.png',
                                      height: 150,
                                    ),
                                    subtitle: Text('Data tidak tersedia'),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: blocOrder.listCart.length,
                                  itemBuilder: (_, i) {
                                    var subTotal = blocOrder.listCart[i].chilrdern.map<int>((m) => int.parse(m.subtotal)).reduce((a, b) => a + b);
                                    return Container(
                                      child: Column(
                                        children: [
                                          Divider(
                                            thickness: 2,
                                          ),
                                          Container(
                                            color: Colors.white,
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      child: InkWell(
                                        onTap: () {
                                          var idToko = blocOrder.listCart[i].chilrdern[0].idToko;
                                          var fotoSampul = blocOrder.listCart[i].chilrdern[0].fotoToko;
                                          blocProduk.getDetailStore(idToko);
                                          Navigator.push(
                                              context,
                                              SlideRightRoute(
                                                  page: DetailTokoScreen(
                                                id: idToko,
                                                image: fotoSampul,
                                              ))).then((value) {
                                            blocOrder.getCart();
                                          });
                                        },
                                        child: ListTile(
                                          title: Text(blocOrder.listCart[i].flag),
                                          leading: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.network(
                                              'https://m-bangun.com/api-v2/assets/toko/' + blocOrder.listCart[i].chilrdern[0].fotoToko,
                                              width: 40,
                                              height: 80,
                                            ),
                                          ),
                                          subtitle: Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: 15,
                                                color: Colors.orangeAccent,
                                              ),
                                              Icon(
                                                Icons.star,
                                                size: 15,
                                                color: Colors.orangeAccent,
                                              ),
                                              Icon(
                                                Icons.star,
                                                size: 15,
                                                color: Colors.orangeAccent,
                                              ),
                                              Icon(
                                                Icons.star,
                                                size: 15,
                                                color: Colors.orangeAccent,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (_, j) {
                                          if (blocOrder.listCart[i].chilrdern[j].aktif == '0' || blocOrder.listCart[i].chilrdern[j].stok == '0') {
                                            return ShopItemListNonAtif(
                                              chilrdern: blocOrder.listCart[i].chilrdern[j],
                                              index: j,
                                              onRemove: () {
                                                blocOrder.removeCart(blocOrder.listCart[i].chilrdern[j].id);
                                              },
                                            );
                                          } else {
                                            return ShopItemList(
                                              chilrdern: blocOrder.listCart[i].chilrdern[j],
                                              index: j,
                                              onRemove: () {
                                                blocOrder.removeCart(blocOrder.listCart[i].chilrdern[j].id);
                                              },
                                            );
                                          }
                                        },
                                        itemCount: blocOrder.listCart[i].chilrdern.length,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                                      height: MediaQuery.of(context).size.height * 0.06,
                                      color: Colors.cyan[500].withOpacity(0.7),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Subtotal',
                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
                                          ),
                                          Text(
                                            blocOrder.listCart[i].chilrdern.length.toString() + ' items',
                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w200, fontSize: 16),
                                          ),
                                          Text(
                                            Money.fromInt(subTotal, IDR).toString(),
                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.95,
                                      margin: EdgeInsets.only(top: 5),
                                      height: 50,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.deepOrange),
                                      child: InkWell(
                                        onTap: () async {
                                          blocProfile.getProvince();
                                          var idKecamatanToko = blocOrder.listCart[i].chilrdern[0].idKecamatan;
                                          blocProfile.getSubDistrictById(idKecamatanToko);
                                          blocOrder.getMetodePembayaran();
                                          blocOrder.clearCost();
                                          int totalDalamKota = 0;
                                          int totalRajaOngkir = 0;
                                          if (blocProfile.listUserAddressDefault.isNotEmpty) {
                                            for (var k = 0; k < blocOrder.listCart[i].chilrdern.length; k++) {
                                              var idKotaPembeli = blocProfile.listUserAddressDefault[0].idKota;
                                              var idKotaToko = blocOrder.listCart[i].chilrdern[k].idKota;
                                              var jenisOngkir = blocOrder.listCart[i].chilrdern[k].jenisOngkir;
                                              if (jenisOngkir == 'include_dalam_kota') {
                                                if (idKotaToko != idKotaPembeli) {
                                                  var beratTotal = int.parse(blocOrder.listCart[i].chilrdern[k].berat.toString()) *
                                                      int.parse(blocOrder.listCart[i].chilrdern[k].jumlah.toString());
                                                  totalDalamKota += beratTotal;
                                                }
                                              }
                                              if (jenisOngkir == 'raja_ongkir') {
                                                var beratTotal =
                                                    int.parse(blocOrder.listCart[i].chilrdern[k].berat.toString()) *
                                                        int.parse(blocOrder.listCart[i].chilrdern[k].jumlah.toString());
                                                totalRajaOngkir += beratTotal;
                                              }
                                            }
                                            var param = {
                                              'origin': idKecamatanToko.toString(),
                                              'destination': blocProfile.listUserAddressDefault[0].idKecamatan,
                                              'weight': (totalDalamKota + totalRajaOngkir) == 0 ? '1' : (totalDalamKota + totalRajaOngkir).toString()
                                            };
                                            blocOrder.getCost(param);
                                          }
                                          var result = blocOrder.getCart();
                                          result.then((value) {
                                            var aktif = value[i]['chilrdern'].where((element) => element['aktif'] == '0').length;
                                            var stok = value[i]['chilrdern'].where((element) => element['stok'] == '0').length;
                                            if (aktif <= 0 && stok <= 0) {
                                              print('push');
                                              Navigator.push(
                                                  context,
                                                  SlideRightRoute(
                                                      page: CheckoutScreen(
                                                          listCart: blocOrder.listCart[i],
                                                          index: i,
                                                          subtotal: blocOrder.listCart[i].chilrdern.map<int>((m) => int.parse(m.subtotal)).reduce((a, b) => a + b))));
                                            } else {
                                              print('not');
                                            }
                                          });
                                        },
                                        child: Center(
                                          child: Text(
                                            blocOrder.listCart[i].chilrdern.where((element) => element.aktif == '0').length >= 1 ||
                                                    blocOrder.listCart[i].chilrdern.where((element) => element.stok == '0').length >= 1
                                                ? 'Hapus produk tidak tersedia'
                                                : 'Checkout',
                                            style: TextStyle(color: Colors.white, fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 20,
              child: Center(child: Text('m-Bangun Shop 2020')),
            )
          ],
        ),
      ),
    );
  }

  onRefresh() async {
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    Provider.of<BlocProfile>(context).getUserAddressDefault(blocAuth.idUser);
    blocOrder.getCart();
  }
}
