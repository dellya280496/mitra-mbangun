import 'package:flutter/cupertino.dart';

class TextBold extends StatelessWidget {
  const TextBold({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
