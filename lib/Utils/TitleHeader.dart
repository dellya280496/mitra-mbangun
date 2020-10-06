import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TitleHeader extends StatelessWidget {
  const TitleHeader({
    Key key,
    @required this.title,
    @required this.color,
  }) : super(key: key);
  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, color: color, fontFamily: 'WorkSansMedium', letterSpacing: 2, fontWeight: FontWeight.bold),
    );
  }
}
