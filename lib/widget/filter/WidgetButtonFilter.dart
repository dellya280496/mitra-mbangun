import 'package:apps/widget/filter/WIdgetFilter.dart';
import 'package:flutter/material.dart';
import 'package:route_transitions/route_transitions.dart';

class WidgetButtonFilter extends StatelessWidget {
  WidgetButtonFilter({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              PageRouteTransition(
                animationType: AnimationType.slide_up,
                builder: (context) => WidgetFilter(),
              ));
        },
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.filter_list,
              color: Colors.white,
              size: 18,
            ),
            Container(
              width: 5,
            ),
            Text(
              'filter',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, letterSpacing: 1),
            ),
          ],
        )),
      ),
      width: 100,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.cyan[700],
        boxShadow: [
          BoxShadow(color: Colors.cyan[600], spreadRadius: 1),
        ],
      ),
    );
  }
}
