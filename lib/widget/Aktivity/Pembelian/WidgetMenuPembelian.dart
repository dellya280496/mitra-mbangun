import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/widget/Aktivity/Pembelian/WidgetListPembelian.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class WidgetMenuPembelian extends StatelessWidget {
  WidgetMenuPembelian({Key key}) : super(key: key);
  var dataList = ['Menunggu Pembayaran', 'Menunggu Konfirmasi', 'Dikemas', 'Dikirim', 'Selesai', 'Batal'];

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
            child: ListTile(
                onTap: () => _openPembelian(dataList[index], blocAuth.idUser, context),
                title: Text(
                  dataList[index],
                  style: TextStyle(fontSize: 16),
                ),
                leading: dataList[index] == 'Menunggu Pembayaran'
                    ? blocOrder.countMenunggu.toString() == '0'
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
                                    blocOrder.countMenunggu.toString() == '0' ? '' : blocOrder.countMenunggu.toString(),
                                    style: TextStyle(color: Colors.white, fontSize: 10),
                                  ),
                                ),
                              )
                            ],
                          )
                    : dataList[index] == 'Menunggu Konfirmasi'
                        ? blocOrder.countMenungguKonfirmasi.toString() == '0'
                            ? Icon(
                                Icons.watch_later,
                                size: 33,
                                color: Colors.amber,
                              )
                            : Stack(
                                children: <Widget>[
                                  Icon(
                                    Icons.watch_later,
                                    size: 33,
                                    color: Colors.amber,
                                  ),
                                  Positioned(
                                    top: 0.0,
                                    right: 0.0,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                                      alignment: Alignment.center,
                                      child: Text(
                                        blocOrder.countMenungguKonfirmasi.toString() == '0' ? '' : blocOrder.countMenungguKonfirmasi.toString(),
                                        style: TextStyle(color: Colors.white, fontSize: 10),
                                      ),
                                    ),
                                  )
                                ],
                              )
                        : dataList[index] == 'Dikemas'
                            ? blocOrder.countDikemas.toString() == '0'
                                ? Icon(
                                    FontAwesomeIcons.shoppingBag,
                                    color: Colors.orange,
                                    size: 33,
                                  )
                                : Stack(
                                    children: <Widget>[
                                      Icon(
                                        FontAwesomeIcons.shoppingBag,
                                        color: Colors.orange,
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
                                            blocOrder.countDikemas.toString() == '0' ? '' : blocOrder.countDikemas.toString(),
                                            style: TextStyle(color: Colors.white, fontSize: 10),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                            : dataList[index] == 'Dikirim'
                                ? blocOrder.countDikirim.toString() == '0'
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
                                                blocOrder.countDikirim.toString() == '0' ? '' : blocOrder.countDikirim.toString(),
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
                                    : dataList[index] == 'Batal'
                                        ? Icon(
                                            Icons.backspace,
                                            size: 33,
                                            color: Colors.red,
                                          )
                                        : Icon(Icons.backspace, color: Colors.red),
                trailing: Icon(Icons.arrow_forward_ios)),
          );
        },
      ),
    );
  }

  _openPembelian(String title, idUser, context) {
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    if (title == 'Menunggu Pembayaran' || title == 'Batal') {
      var param = {'id_pembeli': idUser.toString(), 'status_pembayaran': title == 'Menunggu Pembayaran' ? 'menunggu' : title.toLowerCase() == 'Batal' ? 'batal' : 'batal'};
      print(param);
      blocOrder.getOrderByParam(param);
    } else {
      var param = {
        'id_pembeli': idUser.toString(),
        'status_order': title.toString().toLowerCase() == 'ulasan' ? 'selesai' : title.toString().toLowerCase(),
        'status_pembayaran': 'terbayar'
      };
      blocOrder.getOrderByParam(param);
    }

    Navigator.push(
        context,
        SlideRightRoute(
            page: WidgetListPembelian(
          title: title,
        ))).then((value) {});
  }
}
