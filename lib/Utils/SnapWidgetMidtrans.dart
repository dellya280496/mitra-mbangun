import 'dart:async';
import 'dart:convert';

import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/widget/Invoice/WidgetWaitingPayment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SnapWidgetMidtrans extends StatefulWidget {
  final urlSnap;
  final tokenSnap;
  final bodyTransaction;

  SnapWidgetMidtrans({Key key, this.urlSnap, this.tokenSnap, this.bodyTransaction}) : super(key: key);

  @override
  _SnapWidgetMidtransState createState() {
    return _SnapWidgetMidtransState();
  }
}

class _SnapWidgetMidtransState extends State<SnapWidgetMidtrans> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  String url = "";
  double progress = 0;

  @override
  void initState() {
    super.initState();
//    _initializeTimer();
  }

  bool buttonBack = true;
  Timer timer;

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  void _initializeTimer() {
    timer = Timer.periodic(const Duration(seconds: 5), (__) {
      createOrder();
    });
  }

  createOrder() async {
    await new Future.delayed(const Duration(seconds: 1));
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    var result = blocOrder.getTransaksiStatus(widget.bodyTransaction['data_order']['no_order'].toString());
    result.then((value) {
      if (value != null) {
        if (value['status_code'] == '404' || value['status_code'] == '401') {
          print('Transaction doesnt exist.');
        } else {
          timer.cancel();
          Navigator.push(
            context,
            SlideRightRoute(
              page: WidgetWaitingPayment(
                idOrder: widget.bodyTransaction['data_order']['no_order'].toString(),
                body: widget.bodyTransaction,
              ),
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rincian Pembelian',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
        elevation: 0,
        leading: Container(),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: WebView(
              initialUrl: widget.urlSnap,
              javascriptMode: JavascriptMode.unrestricted,
              javascriptChannels: <JavascriptChannel>[
                JavascriptChannel(
                    name: 'Print',
                    onMessageReceived: (JavascriptMessage msg) {
                      var result = json.decode(msg.message);
                      print(result['transaction_status']);
                      if (result['transaction_status'] != null) {
                        Navigator.push(
                          context,
                          SlideRightRoute(
                            page: WidgetWaitingPayment(
                              idOrder: widget.bodyTransaction['data_order']['no_order'].toString(),
                              body: widget.bodyTransaction,
                            ),
                          ),
                        );
                      }
                    }),
              ].toSet(),
            ),
          ),
//          !buttonBack
//              ? Container(
//                  height: 0,
//                )
//              : Container(
//                  height: 50,
//                  width: MediaQuery.of(context).size.width,
//                  child: FlatButton(
//                    color: Colors.red[500],
//                    onPressed: () {
//                      Navigator.pop(context);
//                    },
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: [
//                        Icon(
//                          Icons.arrow_back_ios,
//                          color: Colors.white,
//                          size: 18,
//                        ),
//                        Text(
//                          'Kembali',
//                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//                        ),
//                      ],
//                    ),
//                  ),
//                )
        ],
      ),
    );
  }
}
