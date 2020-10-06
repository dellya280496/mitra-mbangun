import 'package:apps/providers/BlocAuth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Notification'),
      ),
      body: ListView.builder(
          itemCount: blocAuth.listNotification.length,
          padding: EdgeInsets.all(10),
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  blocAuth.updateNotification({'id': blocAuth.listNotification[index].id.toString(), 'status': 'read'});
                },
                title: Text(blocAuth.listNotification[index].title),
                subtitle: Text(blocAuth.listNotification[index].body),
                enabled: blocAuth.listNotification[index].status == 'read' ? false : true,
                trailing: blocAuth.listNotification[index].status == 'unread'
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.new_releases,
                            color: Colors.red,
                          ),
                          Text(
                            'Tandai di baca',
                            style: TextStyle(fontSize: 10),
                          )
                        ],
                      )
                    : Icon(Icons.new_releases),
              ),
            );
          }),
    );
  }
}
