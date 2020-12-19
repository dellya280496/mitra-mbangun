import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class BlocChatting extends ChangeNotifier {
  bool _isLoading = false;
  bool _connection = true;

  bool get connection => _connection;

  bool get isLoading => _isLoading;



  getChatRoomId({String sendBy, String sendFrom}) {
    if (sendBy.substring(0, 1).codeUnitAt(0) >
        sendFrom.substring(0, 1).codeUnitAt(0)) {
      return "$sendFrom\_$sendBy";
    } else {
      return "$sendBy\_$sendFrom";
    }
  }

  String _currentChatRoomId;

  String get currentChatRoomId => _currentChatRoomId;


  setCurrentChatRoomId(String chatroomId){
    _currentChatRoomId = chatroomId;
    notifyListeners();
  }

  createChatRoom({String chatroomId, List member, String owner}) async {
    Map<String, dynamic> data = {
      'chatroomId': chatroomId,
      "users": member,
      'createBy': owner
    };
    var groupChatrooms = await FirebaseFirestore.instance
        .collection('chatrooms')
        // .where('users', arrayContainsAny: member)
        .get();
    var membersId = [];
    groupChatrooms.docs.forEach((element) {
      // membersId.add(element.data());
      element.data()['users'].forEach((value) {
        if (member.last == value) {
          membersId.add(element.data());
        }
      });
    });
    if (membersId.isEmpty) {
      FirebaseFirestore.instance
          .collection('chatrooms')
          .document(chatroomId)
          .set(data)
          .catchError((e) {
        print(e.toString());
      });
      _currentChatRoomId = chatroomId;
    } else {
      _currentChatRoomId = membersId.first['chatroomId'];
    }
    notifyListeners();
  }

  addConverenceMessage({String chatroomdId, ChatMessage messageMap}) async {
    // messageMap.user = '';
    print(chatroomdId.toString() + ' ' + messageMap.toJson().toString());
    FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(_currentChatRoomId)
        .collection('chats')
        .add(messageMap.toJson())
        .catchError((e) {
      print(e.toString());
    });
    var lastMessage = {
      'lastMessage': {
        'text': messageMap.text.toString(),
        'sendBy': messageMap.user.uid.toString(),
        'sendAt': messageMap.createdAt.toString()
      }
    };
    var datachatRoom = await FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(_currentChatRoomId)
        .get();
    datachatRoom.reference.update(lastMessage);
  }
}
