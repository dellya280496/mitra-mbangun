import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/screen/MyAdsScreen.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    initializeDateFormatting('in', null);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Notification'),
      ),
      body: GroupedListView<dynamic, String>(
        padding: EdgeInsets.all(8),
        groupBy: (element) => DateFormat("dd MMM yyyy", 'in').format(DateTime.parse(element['create_at'])).toString(),
        elements: blocAuth.listNotification,
        order: GroupedListOrder.DESC,
        useStickyGroupSeparators: true,
        groupSeparatorBuilder: (String value) => Container(
          color: Colors.cyan[100].withOpacity(0.3),
          padding: EdgeInsets.all(8),
          child: Text(
            value.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        itemBuilder: (c, element) {
          return Card(
            elevation: 1.0,
            child: ListTile(
              onTap: () {
                blocAuth.updateNotification({'id': element['id'], 'status': 'read'});
                if (element['title'] == 'Penawaran') {
                  Navigator.push(context, SlideRightRoute(page: MyAdsScreen(indexPage: 1)));
                } else if (element['title'] == 'Proses') {
                  Navigator.push(context, SlideRightRoute(page: MyAdsScreen(indexPage: 1)));
                } else if (element['title'] == 'Selesai') {
                  Navigator.push(context, SlideRightRoute(page: MyAdsScreen(indexPage: 2)));
                }
                blocAuth.checkSession();
              },
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              title: Text(element['title']),
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat("dd", 'in').format(DateTime.parse(element['create_at'])).toString(),
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  Text(DateFormat("MMM", 'in').format(DateTime.parse(element['create_at'])).toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  Text(DateFormat("hh:mm", 'in').format(DateTime.parse(element['create_at'])).toString(), style: TextStyle(fontSize: 9, color: Colors.grey)),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
//                  Text(Money.fromInt(int.parse(element['cost'].toString()), IDR).toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                  Text(element['body'], style: TextStyle(fontWeight: FontWeight.normal)),
                ],
              ),
              trailing: element['status'] == 'unread'
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.new_releases,
                    color: Colors.red,
                  ),
                ],
              )
                  : Icon(Icons.new_releases),
            ),
          );
        },
      ),
    );
  }
}
