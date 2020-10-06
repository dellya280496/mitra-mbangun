import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/widget/Aktivity/Penjualan/component/WidgetDetailOrderProdukPenjualan.dart';
import 'package:apps/widget/Tagihan/WidgetTagihan.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';
import 'package:sup/sup.dart';

class WidgetListPenjualan extends StatelessWidget {
  final String title;

  WidgetListPenjualan({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(this.title),
      ),
      body: blocOrder.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
        onRefresh: () async {
                onRefresh(context);
              },
              child: blocOrder.listOrder.isEmpty
                  ? Center(
                      child: Sup(
                        title: Text('Belum ada orderan !!!'),
                        image: Image.asset(
                          'assets/icons/empty_cart.png',
                          height: 150,
                        ),
                        subtitle: Text('Data tidak tersedia'),
                      ),
                    )
                  : ListView.builder(
                      itemCount: blocOrder.listOrder.length,
                      padding: EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            if (blocOrder.listOrder[index].statusOrder == null || blocOrder.listOrder[index].statusPembayaran == 'menunggu_pembayaran') {
                              var param = {
                                'id': blocOrder.listOrder[index].id,
                              };
                              blocOrder.getOrderTagihanByParam(param);
                              Navigator.push(context, SlideRightRoute(page: WidgetTagihan()));
                            }
                            if (blocOrder.listOrder[index].statusOrder == 'menunggu_konfirmasi' || blocOrder.listOrder[index].statusPembayaran == 'terbayar') {
                              var param = {
                                'id_order': blocOrder.listOrder[index].id,
                              };
                              blocOrder.getOrderProdukByParam(param);
                              blocProfile.getSubDistrictById(blocOrder.listOrder[index].idKecamatan);
                              Navigator.push(context,
                                  SlideRightRoute(page: WidgetDetailOrderProdukPenjualan(title: blocOrder.listOrder[index].statusOrder, order: blocOrder.listOrder[index])));
                            }
                          },
                          child: Card(
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(8.0),
                              leading: Image.network(baseURL+ '/api-v2/assets/toko/' + blocOrder.listOrder[index].foto, width: 90, height: 90,
                                  errorBuilder: (context, urlImage, error) {
                                print(error.hashCode);
                                return Image.asset('assets/logo.png');
                              }),
                              title: Text(blocOrder.listOrder[index].namaToko),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '(INV:' + blocOrder.listOrder[index].noOrder + ')',
                                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12, fontWeight: FontWeight.w700, color: Colors.grey),
                                  ),
                                  Text(Money.fromInt((int.parse(blocOrder.listOrder[index].total)), IDR).toString(),
                                      style: TextStyle(fontStyle: FontStyle.normal, fontSize: 14, color: Colors.redAccent)),
                                ],
                              ),
                              trailing: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.watch_later,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                    Text(
                                      Jiffy(DateTime.parse(blocOrder.listOrder[index].batasBayar.toString())).format("dd/MM/yyyy"),
                                      style: TextStyle(fontSize: 11, color: Colors.grey),
                                    ),
                                    Text(Jiffy(DateTime.parse(blocOrder.listOrder[index].batasBayar.toString())).format("HH:mm"), style: TextStyle(fontSize: 9, color: Colors.grey))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
    );
  }

  onRefresh(context) {
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    blocOrder.setCountPembelian();
    if (title == 'Pesanan Baru') {
      var param = {
        'id_toko': blocAuth.idToko.toString(),
        'status_pembayaran': title == 'Pesanan Baru' ? 'terbayar' : 'terbayar',
        'status_order': title == 'Pesanan Baru' ? 'menunggu konfirmasi' : 'menunggu konfirmasi'
      };
      blocOrder.getOrderByParam(param);
      print(param);
    } else {
      var param = {'id_toko': blocAuth.idToko.toString(), 'status_order': title.toString(), 'status_pembayaran': 'terbayar'};
      blocOrder.getOrderByParam(param);
      print(param);
    }
  }
}
