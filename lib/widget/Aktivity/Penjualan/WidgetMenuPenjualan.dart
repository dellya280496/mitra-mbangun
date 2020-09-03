import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/widget/Aktivity/Penjualan/WidgetListPenjualan.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class WidgetMenuPenjualan extends StatelessWidget {
  WidgetMenuPenjualan({Key key}) : super(key: key);
  var dataList = ['Pesanan Baru', 'Dikemas', 'Dikirim', 'Selesai'];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    return Container(
      width: MediaQuery.of(context).size.height,
      margin: EdgeInsets.only(bottom: 50),
      child: ListView.builder(
        itemCount: dataList.length,
        padding: EdgeInsets.all(10),
        itemBuilder: (context, index) {
          return Card(
            child: InkWell(
              onTap: () => _openPejualan(dataList[index], blocAuth.idToko, context),
              child: ListTile(
                  title: Text(
                    dataList[index],
                    style: TextStyle(fontSize: 16),
                  ),
                  leading: dataList[index] == 'Pesanan Baru'
                      ? blocOrder.countSaleMenungguKonfirmasi.toString() == '0'
                          ? Icon(
                              Icons.new_releases,
                              size: 33,
                              color: Colors.blue,
                            )
                          : Stack(
                              children: <Widget>[
                                Icon(
                                  Icons.new_releases,
                                  size: 33,
                                  color: Colors.blue,
                                ),
                                Positioned(
                                  top: 0.0,
                                  right: 0.0,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                                    alignment: Alignment.center,
                                    child: Text(
                                      blocOrder.countSaleMenungguKonfirmasi.toString() == '0' ? '' : blocOrder.countSaleMenungguKonfirmasi.toString(),
                                      style: TextStyle(color: Colors.white, fontSize: 10),
                                    ),
                                  ),
                                )
                              ],
                            )
                      : dataList[index] == 'Dikemas'
                          ? blocOrder.countSaleDikemas.toString() == '0'
                              ? Icon(
                                  FontAwesomeIcons.shoppingBag,
                                  color: Colors.deepOrange,
                                  size: 33,
                                )
                              : Stack(
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.shoppingBag,
                                      color: Colors.deepOrange,
                                      size: 33,
                                    ),
                                    Positioned(
                                      top: 0.0,
                                      right: 0.0,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                                        alignment: Alignment.center,
                                        child: Text(
                                          blocOrder.countSaleDikemas.toString() == '0' ? '' : blocOrder.countSaleDikemas.toString(),
                                          style: TextStyle(color: Colors.white, fontSize: 10),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                          : dataList[index] == 'Dikirim'
                              ? blocOrder.countSaleDikirim.toString() == '0'
                                  ? Icon(
                                      FontAwesomeIcons.truckPickup,
                                      color: Colors.cyan,
                                      size: 33,
                                    )
                                  : Stack(
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.truckPickup,
                                          color: Colors.cyan,
                                          size: 33,
                                        ),
                                        Positioned(
                                          top: 0.0,
                                          right: 0.0,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                                            alignment: Alignment.center,
                                            child: Text(
                                              blocOrder.countSaleDikirim.toString() == '0' ? '' : blocOrder.countSaleDikirim.toString(),
                                              style: TextStyle(color: Colors.white, fontSize: 10),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                              : dataList[index] == 'Selesai'
                                  ? Icon(
                                      Icons.assignment_turned_in,
                                      size: 33,
                                      color: Colors.green,
                                    )
                                  : Icon(Icons.delete, color: Colors.red),
                  trailing: Icon(Icons.arrow_forward_ios)),
            ),
          );
        },
      ),
    );
  }

  _openPejualan(String title, idToko, BuildContext context) {
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    if (title == 'Pesanan Baru') {
      var param = {
        'id_toko': idToko.toString(),
        'status_pembayaran': title == 'Pesanan Baru' ? 'terbayar' : 'terbayar',
        'status_order': title == 'Pesanan Baru' ? 'menunggu konfirmasi' : 'menunggu konfirmasi'
      };
      blocOrder.getOrderByParam(param);
      print(param);
    } else {
      var param = {'id_toko': idToko.toString(), 'status_order': title.toString(), 'status_pembayaran': 'terbayar'};
      blocOrder.getOrderByParam(param);
      print(param);
    }

    Navigator.push(
        context,
        SlideRightRoute(
            page: WidgetListPenjualan(
              title: title,
            )));
  }
}
