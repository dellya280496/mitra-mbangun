import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocChatting.dart';
import 'package:apps/widget/konsultasi/ConversationScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class WidgetKonsultasi extends StatefulWidget {
  WidgetKonsultasi({Key key}) : super(key: key);

  @override
  _WidgetKonsultasiState createState() {
    return _WidgetKonsultasiState();
  }
}

class _WidgetKonsultasiState extends State<WidgetKonsultasi> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final blocChat = Provider.of<BlocChatting>(context);
    final blocAuth = Provider.of<BlocAuth>(context);
    var uid = blocAuth.currentUserChat.uid;
    // TODO: implement build
    return SafeArea(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('chatrooms').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) return CircularProgressIndicator();
            List<DocumentSnapshot> items = snapshot.data.documents;
            var _listMessage = items.map((i) => i.data()).toList();
            var dataHistory = _listMessage.where((element) => element['users'].contains(uid)).toList();
            return ListView.builder(
              itemCount: dataHistory.length,
              itemBuilder: (context, index) {
                var phone = _listMessage[index]['createBy'] == uid
                    ? _listMessage[index]['users'].last
                    : _listMessage[index]['users'].first;
                return StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('users').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null)
                        return Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Center(child: CircularProgressIndicator()));
                      List<DocumentSnapshot> users = snapshot.data.documents;
                      var listUsers = users.map((i) => i.data()).toList();
                      var user = listUsers.where((element) => element['uid'] == phone).toList();
                      if (user.isEmpty) {
                        return Container(
                          height: MediaQuery.of(context).size.height,
                          child: Center(
                            child: Text('no chat history'),
                          ),
                        );
                      } else {
                        return Column(
                          children: [
                            ListTile(
                              onTap: () {
                                blocChat.setCurrentChatRoomId(_listMessage[index]['chatroomId']);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ConversationScreen(
                                              fromUser: 'Chat',
                                            )));
                              },
                              title: Text(
                                user[0]['name'].toString(),
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(_listMessage[index]['lastMessage']['text'].toString()),
                              trailing: Text(
                                Jiffy(_listMessage[index]['lastMessage']['sendAt'].toString(), "yyyy-MM-dd").fromNow(),
                                style: Theme.of(context).textTheme.caption,
                              ),
                              leading: CircleAvatar(
                                  radius: 25.0,
                                  backgroundColor: Colors.white,
                                  child: Image.network(user[0]['avatar'].toString())),
                            ),
                            Divider()
                          ],
                        );
                      }
                    });
              },
            );
          }),
    );
  }
}
