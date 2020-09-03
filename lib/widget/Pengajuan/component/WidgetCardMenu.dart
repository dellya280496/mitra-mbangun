import 'package:flutter/material.dart';

class WidgetCardMenu extends StatelessWidget {
  const WidgetCardMenu({Key key, this.thumbnail, this.deskripsi, this.title, this.color}) : super(key: key);
  final thumbnail;
  final deskripsi;
  final title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            InkWell(
              child: Image.asset(
                thumbnail,
                height: 100,
                width: 100,
              ),
            ),
            Text(
              title,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            RichText(
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 3,
              strutStyle: StrutStyle(fontSize: 10.0),
              text: TextSpan(
                style: TextStyle(color: Colors.white, fontSize: 14),
                text: deskripsi,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
