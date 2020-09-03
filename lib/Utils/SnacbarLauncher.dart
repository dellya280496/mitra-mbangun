import 'package:flutter/material.dart';

class SnackBarLauncher extends StatelessWidget {
  final String error;
  final Color color;

  const SnackBarLauncher({Key key, @required this.error, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _displaySnackBar(context, error: error));
    }
    // Placeholder container widget
    return Container();
  }

  void _displaySnackBar(BuildContext context, {@required String error}) {
    final snackBar = SnackBar(
      content: Text(error),
      backgroundColor: color,
    );
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
