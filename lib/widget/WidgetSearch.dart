import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/widget/Home/WidgetCari.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetSearch extends StatelessWidget {
  WidgetSearch({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        width: MediaQuery.of(context).size.width,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(0))),
        child: InkWell(
          onTap: () => _search(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Cari',
                style: TextStyle(fontSize: 11),
              ),
              Icon(
                Icons.search,
                size: 20,
              )
            ],
          ),
        ));
  }

  _search(BuildContext context) {
    Navigator.push(context, SlideRightRoute(page: WidgetCari()));
    Provider.of<DataProvider>(context).setKeySearch('');
  }
}
