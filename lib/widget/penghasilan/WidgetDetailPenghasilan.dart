import 'package:apps/providers/BlocProfile.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';

class WidgetDetailPenghasilan extends StatelessWidget {
  WidgetDetailPenghasilan({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Penghasilan saya'),
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: blocProfile.listPenghasilan.length,
          itemBuilder: (BuildContext context, index) {
            var item = blocProfile.listPenghasilan[index];
            var status = item.status == 'belum_terbayar' ? 'Belum terbayar' : 'Terbayar';
            var total = Money.fromInt(item.total == null ? 0 : int.parse(item.total), IDR);
            var komisi = Money.fromInt(item.komisi == null ? 0 : int.parse(item.komisi), IDR);
            var totalOngkir = Money.fromInt(item.totalOngkir == null ? 0 : int.parse(item.totalOngkir), IDR);
            var totalProduk = Money.fromInt(item.totalProduk == null ? 0 : int.parse(item.totalProduk), IDR);
            var date = Jiffy(DateTime.parse(item.createdAt.toString())).format("dd MMM yyyy");
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: ExpansionTileCard(
                title: Text(total.toString()),
                subtitle: Text(date),
                trailing: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: status != 'Belum terbayar' ? Colors.green : Colors.amber[700]),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      status,
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
                children: [
                  ListTile(
                    title: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: [
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Komisi'.toString(),
                                style: TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                              Text(komisi.toString(), style: TextStyle(fontSize: 14, color: Colors.grey)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total Ongkir'.toString(), style: TextStyle(fontSize: 14, color: Colors.grey)),
                              Text(totalOngkir.toString(), style: TextStyle(fontSize: 14, color: Colors.grey)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total Produk'.toString(), style: TextStyle(fontSize: 14, color: Colors.grey)),
                              Text(totalProduk.toString(), style: TextStyle(fontSize: 14, color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
//            return Card(
//              child: ListTile(
//                title: Text(komisi.toString()),
//                subtitle: Text(date),
//                trailing: Container(
//                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: status != 'Belum terbayar' ? Colors.green: Colors.amber[700]),
//                  child: Padding(
//                    padding: const EdgeInsets.all(5.0),
//                    child: Text(
//                      status ,
//                      style: TextStyle(fontSize: 12, color: Colors.white),
//                    ),
//                  ),
//                ),
//              ),
//            );
          }),
    );
  }
}
