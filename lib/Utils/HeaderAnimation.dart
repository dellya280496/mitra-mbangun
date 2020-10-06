import 'package:flutter/material.dart';

class HeaderAnimation extends StatelessWidget {
  const HeaderAnimation({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(color: Colors.cyan[700], borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
    );
  }
}
