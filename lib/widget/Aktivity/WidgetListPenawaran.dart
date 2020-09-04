import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProyek.dart';
import 'package:apps/widget/Aktivity/Pembelian/component/WidgetDetailOrderProdukPembelian.dart';
import 'package:apps/widget/Project/WidgetDetailProyek.dart';
import 'package:apps/widget/Tagihan/WidgetTagihan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:jiffy/jiffy.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';
import 'package:sup/sup.dart';

class WidgetListPenawaran extends StatefulWidget {
  final String title;

  WidgetListPenawaran({Key key, this.title}) : super(key: key);

  @override
  _WidgetListPenawaranState createState() => _WidgetListPenawaranState();
}

class _WidgetListPenawaranState extends State<WidgetListPenawaran> {
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero).then((_) async {
      BlocProyek blocProyek = Provider.of<BlocProyek>(context);
      BlocAuth blocAuth = Provider.of<BlocAuth>(context);
      blocProyek.getBidsByParam({'id_mitra': blocAuth.idUser.toString(), 'status_proyek': 'setuju'});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    BlocProyek blocProyek = Provider.of<BlocProyek>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
    return Scaffold(
      body: blocProyek.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async {
                onRefresh(context);
              },
              child: blocProyek.listBids.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Sup(
                            title: Text('Belum ada proyek di Bid'),
                            image: Image.asset(
                              'assets/icons/empty_cart.png',
                              height: 150,
                            ),
                            subtitle: Text('Yuk lihat proyek tersedia,,,'),
                          ),
                          Container(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () {
                              onRefresh(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Muat Ulang'),
                                Container(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.refresh,
                                  size: 20,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: blocProyek.listBids.length,
                      padding: EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            contentPadding: EdgeInsets.all(8),
                            onTap: () {
                              blocProyek.getDetailProyekByParam({'id': blocProyek.listBids[index].idProjek.toString()});
                              Navigator.push(
                                  context,
                                  SlideRightRoute(
                                      page: WidgetDetailProyek(
                                    param: blocProyek.listProyeks[0],
                                  )));
                            },
                            leading: Image.network('https://m-bangun.com/api-v2/assets/toko/' + blocProyek.listBids[index].foto1, width: 90, height: 90,
                                errorBuilder: (context, urlImage, error) {
                              print(error.hashCode);
                              return Image.asset('assets/logo.png');
                            }),
                            title: Text(blocProyek.listBids[index].nama),
                            subtitle: Text(
                              Jiffy(DateTime.parse(blocProyek.listBids[index].createdAt.toString())).format("dd/MM/yyyy"),
                              style: TextStyle(fontSize: 11, color: Colors.grey),
                            ),
                            trailing: Icon(
                              Icons.watch_later,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                        );
                      },
                    ),
            ),
    );
  }

  onRefresh(context) {
    BlocProyek blocProyek = Provider.of<BlocProyek>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    blocProyek.getBidsByParam({'id_mitra': blocAuth.idUser.toString(), 'status': '0'});
  }
}
