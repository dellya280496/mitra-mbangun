import 'dart:async';

import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/widget/Aktivity/Pengajuan/WidgetDetailPengajuanKontrak.dart';
import 'package:apps/widget/Invoice/WidgetInvoice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';

class WidgetPengajuanByParamList extends StatefulWidget {
  final param;

  WidgetPengajuanByParamList({Key key, this.param}) : super(key: key);

  @override
  _WidgetPengajuanByParamListState createState() => _WidgetPengajuanByParamListState();
}

class _WidgetPengajuanByParamListState extends State<WidgetPengajuanByParamList> {
  Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    Provider.of<DataProvider>(context).getProdukListByUserId(widget.param);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    var today = DateTime.now();
    initializeDateFormatting('in', null);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(widget.param),
      ),
      body: ModalProgressHUD(
        inAsyncCall: dataProvider.isLoading,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 25,
              child: RefreshIndicator(
                onRefresh: refreshList,
                key: refreshKey,
                child: dataProvider.getProdukListByIdUser.length == 0
                    ? ListView(
                        children: [
                          Container(
                            height: 50,
                          ),
                          Icon(
                            Icons.watch_later,
                            color: Colors.grey.withOpacity(0.4),
                            size: 50,
                          ),
                          Text(
                            'Tidak Ada Data',
                            textAlign: TextAlign.center,
                          )
                        ],
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: dataProvider.getProdukListByIdUser.length,
                        itemBuilder: (context, index) {
                          var produkId = dataProvider.getProdukListByIdUser[index].produkid;
                          DateTime tanggal_booking = DateTime.parse(dataProvider.getProdukListByIdUser[index].produkcreate.toString());
                          var budget = dataProvider.getProdukListByIdUser[index].produkbudget;
                          var accBudget = dataProvider.getProdukListByIdUser[index].produkharga;
                          var budgetFormat = Money.fromInt(budget == null ? 0 : int.parse(budget), IDR);
                          var accBudgetFormat = Money.fromInt(accBudget == null ? 0 : int.parse(accBudget), IDR);
                          return InkWell(
                            onTap: () {
                              if (widget.param == 'Progress') {
                                Navigator.push(
                                    context,
                                    SlideRightRoute(
                                        page: WidgetInvoice(
                                          flag: 'owner',
                                        )));
                                dataProvider.getAllInvoice(produkId);
                              } else {
                                dataProvider.getKontrakByProdukId(produkId);
                                dataProvider.getProdukById(produkId);
                                dataProvider.getBiddingByProdukId(produkId);
                                Navigator.push(context, SlideRightRoute(page: WidgetDetailPengajuanKontrak(param: widget.param)));
                              }
                            },
                            child: Stack(
                              children: <Widget>[
                                Card(
                                  elevation: 2,
                                  margin: EdgeInsets.all(15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Container(
                                    height: 90,
                                    decoration: BoxDecoration(color: Colors.cyan[500], borderRadius: BorderRadius.all(Radius.circular(10))),
                                    padding: EdgeInsets.all(5),
                                    child: ListTile(
                                      title: Text(
                                        dataProvider.getProdukListByIdUser[index].produknama,
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                                        maxLines: 2,
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text('Budget ' + budgetFormat.toString(), style: TextStyle(color: Colors.white)),
                                          accBudget == null
                                              ? Text(
                                            '-',
                                            style: TextStyle(color: Colors.white),
                                          )
                                              : Text('Acc Budget ' + accBudgetFormat.toString(), style: TextStyle(color: Colors.white)),
                                        ],
                                      ),
                                      trailing: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          (dataProvider.getProdukListByIdUser[index].statusnama == 'New' || dataProvider.getProdukListByIdUser[index].statusnama == 'Review')
                                              ? Icon(
                                            FontAwesomeIcons.exclamationCircle,
                                            color: Colors.amber,
                                            size: 25,
                                          )
                                              : Icon(
                                            FontAwesomeIcons.solidCheckCircle,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          Text(
                                            dataProvider.getProdukListByIdUser[index].statusnama,
                                            style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.w600, color: Colors.white, fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 80.0),
                                  child: Card(
                                    elevation: 2,
                                    margin: EdgeInsets.all(15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                    ),
                                    child: Container(
                                        height: 120,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[100], borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10))),
                                        padding: EdgeInsets.all(10),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: ListTile(
                                            title: Text(
                                              dataProvider.getProdukListByIdUser[index].produkdeskripsi == null ? '' : dataProvider.getProdukListByIdUser[index].produkdeskripsi,
                                              style: TextStyle(color: Colors.black),
                                            ),
                                            subtitle: Text(
                                              DateFormat("EEE, dd MMMM yyyy", 'in').format(tanggal_booking),
                                            ),
                                            trailing: IconButton(
                                              onPressed: () {
                                                dataProvider.getKontrakByProdukId(produkId);
                                                dataProvider.getProdukById(produkId);
                                                Navigator.push(context, SlideRightRoute(page: WidgetDetailPengajuanKontrak(param: widget.param)));
                                              },
                                              icon: Icon(Icons.arrow_drop_down_circle),
                                            ),
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
