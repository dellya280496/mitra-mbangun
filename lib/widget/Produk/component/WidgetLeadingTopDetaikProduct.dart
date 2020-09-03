import 'package:flutter/material.dart';

class WidgetLeadingTopDetaikProduct extends StatelessWidget {
  const WidgetLeadingTopDetaikProduct({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 10,
      ),
      padding: EdgeInsets.all(3),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.black26,
        child: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
