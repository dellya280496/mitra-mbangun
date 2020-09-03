import 'package:flutter/material.dart';

class WidgetToast extends StatefulWidget {
  final String message;
  final Color color;

  WidgetToast({Key key, this.message, this.color}) : super(key: key);

  @override
  _WidgetToastState createState() {
    return _WidgetToastState();
  }
}

class _WidgetToastState extends State<WidgetToast> {
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
    // TODO: implement build
    return SnackBar(
      backgroundColor: widget.color,
      content: Text(widget.message),
    );
  }
}
