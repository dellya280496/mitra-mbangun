import 'dart:async';

import 'package:apps/Utils/InstruksiPembayaran.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fw_ticket/fw_ticket.dart';
import 'package:intl/intl.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';

class WidgetTagihan extends StatefulWidget {
  final String param;

  WidgetTagihan({Key key, this.param}) : super(key: key);

  @override
  _WidgetTagihanState createState() => _WidgetTagihanState();
}

class _WidgetTagihanState extends State<WidgetTagihan> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    // TODO: implement build
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    AppBar appBar = AppBar(
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.cyan[600],
      title: Text(
        'Tagihan',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: () {
          if (this.widget.param == 'checkout') {
            Navigator.of(context).pushNamedAndRemoveUntil('/BottomNavBar', (Route<dynamic> route) => false);
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: appBar,
        body: blocOrder.listOrderDetail.isEmpty
            ? Center(
          child: CircularProgressIndicator(),
        )
            : Column(
          children: [
            Container(
              color: Colors.cyan[600],
              height: (height * 0.23) - appBar.preferredSize.height - statusBarHeight,
              width: width,
              child: Column(
                children: [
                  Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image(width: 20, height: 20, image: new AssetImage('assets/logo.png')),
                      )),
                  Text(
                    'm-Bangun',
                    style: TextStyle(fontFamily: 'SUNDAY', color: Colors.white, fontSize: 16),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.yellow.withOpacity(0.1),
              height: height * 0.88 - appBar.preferredSize.height - statusBarHeight,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: StreamBuilder(
                        stream: Stream.periodic(Duration(seconds: 1), (i) => i),
                        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                          bool expired = false;
                          int estimateTs = DateTime
                              .parse(blocOrder.listOrderDetail[0].batasBayar)
                              .millisecondsSinceEpoch; // set needed date
                          DateFormat format = DateFormat("mm:ss");
                          int now = DateTime
                              .now()
                              .millisecondsSinceEpoch;
                          Duration remaining = Duration(milliseconds: estimateTs - now);
                          if (now >= estimateTs) {
                            expired = true;
                          }
                          var hourse = '${remaining.inHours}';
                          var menit = '${format.format(DateTime.fromMillisecondsSinceEpoch(remaining.inMilliseconds))}';
                          return expired
                              ? Container(
                            height: height * 0.71,
                            child: Center(
                              child: Container(
                                height: 100,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.8,
                                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(8))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Waktu pembayaran telah habis',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(letterSpacing: 0.5,
                                          height: 1.5,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Silahkan order ulang jika ingin melanjutkan transaksi',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(letterSpacing: 0.5,
                                          height: 1.5,
                                          fontSize: 12,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                              : Container(
                            padding: EdgeInsets.all(15),
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Container(
                                  child: Text(
                                    'Sisa waktu yang harus dibayar',
                                    style: TextStyle(fontSize: 14, color: Colors.grey),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          hourse,
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, fontFamily: 'WorkSansMedium'),
                                        ),
                                        Text(
                                          'Jam',
                                          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14, fontFamily: 'WorkSansMedium'),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(':', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, fontFamily: 'WorkSansMedium')),
                                        SizedBox(
                                          height: 18,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          menit,
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, fontFamily: 'WorkSansMedium'),
                                        ),
                                        Text(
                                          "Menit",
                                          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14, fontFamily: 'WorkSansMedium'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  child: Text(
                                    'Jumlah yang harus dibayar',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        Money.fromInt((int.parse(blocOrder.listOrderDetail[0].total)), IDR).toString(),
                                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent, fontSize: 18),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      GestureDetector(
                                        child: Icon(
                                          Icons.content_copy,
                                          color: Colors.grey,
                                          size: 14,
                                        ),
                                        onTap: () {
                                          Clipboard.setData(new ClipboardData(text: blocOrder.listOrderDetail[0].total));
                                          _scaffoldKey.currentState.showSnackBar(new SnackBar(
                                            content: Text('Salin ' + "'" + blocOrder.listOrderDetail[0].total + "'"),
                                            backgroundColor: Colors.green,
                                          ));
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.8,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all(Radius.circular(8))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Harap transfer sebelum batas waktu diatas!',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(letterSpacing: 0.5,
                                            height: 1.5,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Pastikan tagihan anda sesuai dengan nominal yang tertera diatas.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(letterSpacing: 0.5,
                                            height: 1.5,
                                            fontSize: 12,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.9,
                                    child: Ticket(
                                      innerRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
                                      outerRadius: BorderRadius.all(Radius.circular(10.0)),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 4),
                                          blurRadius: 2.0,
                                          spreadRadius: 2.0,
                                          color: Color.fromRGBO(196, 196, 196, .76),
                                        )
                                      ],
                                      child: Container(
                                        color: Colors.white,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.more_vert,
                                                    color: Colors.lightBlue,
                                                  ),
                                                  Text(
                                                    'INV: ' + blocOrder.listOrderDetail[0].noOrder,
                                                    style: TextStyle(color: Colors.black, fontSize: 16.0, fontFamily: 'WorkSansBold', fontWeight: FontWeight.bold),
                                                  ),
                                                  Icon(
                                                    Icons.more_vert,
                                                    color: Colors.lightBlue,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 2),
                                              child: DottedLine(
                                                dashColor: Colors.grey,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 30),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: Center(
                                                        child: Text(
                                                          blocOrder.listOrderDetail[0].namaBank,
                                                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0, color: Colors.grey),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  FittedBox(
                                                    child: Column(
                                                      children: [
                                                        blocOrder.detailMidtransTransaksi['va_numbers'] == null
                                                            ? Text(blocOrder.detailMidtransTransaksi['bill_key'] == null ? '0' : blocOrder.detailMidtransTransaksi['bill_key'],
                                                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0))
                                                            : Text(
                                                          blocOrder.detailMidtransTransaksi['va_numbers'][0]['va_number'].toString(),
                                                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
                                                        ),
                                                        Text('no. va')
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
//                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: <Widget>[
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            InkWell(
                                                                onTap: () async {
                                                                  var url =
                                                                      'https://app.midtrans.com/snap/v1/transactions/' + blocOrder.listOrderDetail[0].tokenVa + '/pdf';
                                                                  Navigator.push(
                                                                      context,
                                                                      SlideRightRoute(
                                                                          page: IntruksiPembayaran(
                                                                            url: url,
                                                                          )));
                                                                },
                                                                child: Text(
                                                                  'Cara pembayaran',
                                                                  style: TextStyle(color: Colors.green),
                                                                )),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              color: Colors.cyan[700],
                                              padding: EdgeInsets.symmetric(vertical: 8.0),
                                              child: Center(
                                                child: GestureDetector(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      new Text(
                                                        'Salin rekening ',
                                                        style: TextStyle(color: Colors.white, fontSize: 14),
                                                      ),
                                                      Icon(
                                                        Icons.content_copy,
                                                        color: Colors.white,
                                                        size: 14,
                                                      ),
                                                    ],
                                                  ),
                                                  onTap: () {
                                                    Clipboard.setData(new ClipboardData(
                                                        text: blocOrder.detailMidtransTransaksi['va_numbers'][0]['va_number'] == null
                                                            ? blocOrder.detailMidtransTransaksi['bill_key'].toString()
                                                            : blocOrder.detailMidtransTransaksi['va_numbers'][0]['va_number'].toString()));
                                                    _scaffoldKey.currentState.showSnackBar(new SnackBar(
                                                      content: Text('Salin ' + "'" + blocOrder.detailMidtransTransaksi['va_numbers'][0]['va_number'] == null
                                                          ? blocOrder.detailMidtransTransaksi['bill_key'].toString()
                                                          : blocOrder.detailMidtransTransaksi['va_numbers'][0]['va_number'].toString() + "'"),
                                                      backgroundColor: Colors.green,
                                                    ));
                                                  },
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop() {
    if (this.widget.param == 'checkout') {
      return showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text('Anda yakin!'),
              content: Text('Ingin keluar dari pembayaran?'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
                FlatButton(
                  onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/BottomNavBar', (Route<dynamic> route) => false),
                  /*Navigator.of(context).pop(true)*/
                  child: Text('Yes'),
                ),
              ],
            ),
      ) ??
          false;
    } else {
      Navigator.pop(context);
//      return
//      setState(() {
//        currentScreen = HomeScreen();
//        currentTab = 0;
//      });
    }
  }

//  Future<bool> _onWillPop(context) {
//    if (this.widget.param == 'checkout') {
//      Navigator.of(context).pushNamedAndRemoveUntil('/BottomNavBar', (Route<dynamic> route) => false);
//      return true;
//    } else {
//      Navigator.pop(context);
//      return true;
//    }
//  }
}
