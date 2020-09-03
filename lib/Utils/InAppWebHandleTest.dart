import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

//import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//import 'package:url_launcher/url_launcher.dart';

class InAppWebHandleTest extends StatefulWidget {
  InAppWebHandleTest({Key key}) : super(key: key);

  @override
  _InAppWebHandleTestState createState() => _InAppWebHandleTestState();
}

class _InAppWebHandleTestState extends State<InAppWebHandleTest> {
//  InAppWebViewController webView;
//  ContextMenu contextMenu;
  String url = "";
  double progress = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, title: Text("Toko")),
      body: WebView(
        initialUrl: 'http://localhost/mbangun-webview/welcome/success?email=denifrahman@gmail.com',
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: <JavascriptChannel>[
          JavascriptChannel(
              name: 'Print',
              onMessageReceived: (JavascriptMessage msg) {
                print(msg.message);
              }),
        ].toSet(),
      ),
    );
  }
}
