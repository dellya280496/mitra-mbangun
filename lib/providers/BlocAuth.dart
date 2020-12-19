import 'package:apps/Repository/AuthRepository.dart';
import 'package:apps/Repository/UserRepository.dart';
import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/models/JenisLayananMitra.dart';
import 'package:apps/models/NotificationM.dart';
import 'package:apps/models/UserMitra.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info/package_info.dart';

class BlocAuth extends ChangeNotifier {
  BlocAuth() {
    checkSession();
  }

  bool _isLoading = false;
  bool _isLogin = false;
  String _statusToko = '0';
  String _idToko = '0';
  bool _isRegister = false;
  bool _isMitra = false;
  bool _survey = false;
  String _errorMessage, _idUser, _token, _id_mitra;
  bool _connection = true;
  bool _isNonActive = false;

  bool get isNonActive => _isNonActive;

  String get statusToko => _statusToko;

  String get id_mitra => _id_mitra;

  String get idToko => _idToko;

  bool get connection => _connection;

  String get errorMessage => _errorMessage;

  bool get isRegister => _isRegister;

  bool get isMitra => _isMitra;

  bool get isLoading => _isLoading;

  bool get survey => _survey;

  String get idUser => _idUser;

  bool get isLogin => _isLogin;

  handleSignOut() async {
    LocalStorage.sharedInstance.deleteValue('no_telp');
    LocalStorage.sharedInstance.deleteValue('userData');
    _isNonActive = true;
    _isLoading = false;
    _connection = true;
    _isLogin = false;
    _isMitra = false;
    _phoneNumber = '';
    var fcm_token = FlutterSession().get('fcm_token');
    fcm_token.then((value) async {
      var param = {'fcm_token': value};
      var result = await AuthRepository().deleteFcmToken(param);
      print(result);
    });
    checkSession();
//      _googleSignIn.isSignedIn().then((value) {
//        if (value) {
//          return true;
//        } else {
//          _isLogin = false;
//          _idToko = '0';
//          _idUser = '0';
//          _connection = true;
//          _isNonActive = false;
//          _isRegister = false;
//          notifyListeners();
//          return false;
//        }
//      });
//     });
  }

  create(body) async {
    var result = await UserRepository().create(body);
    if (result['meta']['success']) {
      _isLogin = true;
      _isRegister = false;
      checkSession();
      notifyListeners();
      return result;
    } else {
      checkSession();
      return result;
    }
  }

  // getCurrentUser() {
  //   _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
  //     _currentUser = account;
  //     if (account != null) {
  //       checkSession();
  //     } else {
  //       handleSignOut();
  //     }
  //   });
  //   _googleSignIn.signInSilently();
  // }

  List<JenisLayananMitra> _listJenisLayananMitra = [];

  List<JenisLayananMitra> get listJenisLayananMitra => _listJenisLayananMitra;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  setFcmToken(String id_mitra, String token) async {
    var deviceData = FlutterSession().get('deviceData');
    deviceData.then((value) async {
      var devices = value['name'] == null ? value['brand'] : value['name'];
      var system = value['systemName'] == null ? 'Android' : value['systemName'];
      var param = {
        'id_mitra': id_mitra.toString(),
        'fcm_token': token.toString(),
        'device_name': devices,
        'system_name': system,
        'model': value['model']
      };
      var result = await AuthRepository().setFcmToken(param);
      print(result);
    });
  }

  checkSession() async {
    checkVersionApp();
    _isLoading = false;
    getUserData();
    notifyListeners();
  }

  List<UserMitra> _detailMitra = [];

  List<UserMitra> get detailMitra => _detailMitra;

  getUserData() async {
    var queryString = {'no_hp': _phoneNumber};
    var result = await AuthRepository().getMitraByParam(queryString);
    print(result);
    if (result.toString() == '111' ||
        result.toString() == '101' ||
        result.toString() == 'Conncetion Error' ||
        result['data'] == null) {
      _connection = false;
      _isLoading = false;
      notifyListeners();
      return false;
    } else {
      if (result['meta']['success']) {
        if (result['data']['aktif'] != '1') {
          print('nonaktif');
          _isNonActive = true;
          _isLoading = false;
          _connection = true;
          _isLogin = false;
          _isMitra = false;
          notifyListeners();
          return true;
        } else {
          setFirestore(result);
          print('aktif');
          Iterable list = result['jenis_layanan_mitra'];
          _listJenisLayananMitra = list.map((model) => JenisLayananMitra.fromMap(model)).toList();
          Iterable listMitra = [result['data']];
          _detailMitra = listMitra.map((model) => UserMitra.fromMap(model)).toList();
          _connection = true;
          _token = result['token'];
          _idToko = result['data']['id_toko'].toString();
          LocalStorage.sharedInstance.writeValue(key: 'survey', value: result['data']['survey']);
          _survey = result['data']['survey'] == "1" ? true : false;
          LocalStorage.sharedInstance
              .writeValue(key: 'id_jenis_layanan', value: _listJenisLayananMitra.map((e) => e.id).toString());
          LocalStorage.sharedInstance.writeValue(key: 'id_mitra_login', value: result['data']['id']);
          _idUser = result['data']['id'];
          _id_mitra = result['data']['id_mitra'];
          _isRegister = false;
          _isLoading = false;
          _isLogin = true;
          _isMitra = true;
          notifyListeners();
          return true;
          // }
        }
      } else {
        print('meta');
        _connection = true;
        _isRegister = true;
        _isLoading = false;
        _isLogin = false;
        _isMitra = false;
        notifyListeners();
        return false;
      }
    }
  }

  double _currentVersion;
  double _newVersion;
  bool _showVersionDialog = false;

  bool get showVersionDialog => _showVersionDialog;

  double get currentVersion => _currentVersion;

  double get newVersion => _newVersion;

  setShowVersionDialog(bool) {
    _showVersionDialog = bool;
  }

  checkVersionApp() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    _currentVersion = double.parse(info.version.trim().replaceAll(".", ""));
    notifyListeners();
    var param = {'': ''};
    var result = await AuthRepository().checkVersionApp(param);
    print(result);
    if (result.toString() == '111' || result.toString() == '101' || result.toString() == 'Conncetion Error') {
      _connection = false;
      _isLoading = false;
      notifyListeners();
      return result;
    } else {
      _newVersion = double.parse(result['data'][0]['versi_nomor'].trim().replaceAll(".", ""));
      if (newVersion > currentVersion) {
        _showVersionDialog = true;
        _connection = false;
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  List _listNotification = [];

  List get listNotification => _listNotification;

  getNotification() async {
    _isLoading = true;
    var param = {'id_mitra': _id_mitra.toString(), 'limit': '20'};
    var result = await AuthRepository().getNotification(param);
    print(result);
    if (result.toString() == '111' || result.toString() == '101' || result.toString() == 'Conncetion Error') {
      _connection = false;
      _isLoading = false;
      notifyListeners();
      return result;
    } else {
      if (result['meta']['success']) {
        _isLoading = false;
        _connection = true;
        _listNotification = [];
        Iterable list = result['data'];
        _listNotification = result['data'];
        notifyListeners();
        getNotificationUnread();
        return result['data'];
      } else {
        getNotificationUnread();
        _connection = false;
        _isLoading = false;
        _listNotification = [];
        notifyListeners();
        return result['data'];
      }
    }
  }

  int _coundNotification = 0;

  int get coundNotification => _coundNotification;

  getNotificationUnread() async {
    var param = {'id_mitra': _id_mitra.toString(), 'status': 'unread', "limit": '20'};
    var result = await AuthRepository().getNotification(param);
    print(result);
    if (result.toString() == '111' || result.toString() == '101' || result.toString() == 'Conncetion Error') {
      _connection = false;
      _isLoading = false;
      notifyListeners();
      return result;
    } else {
      if (result['meta']['success']) {
        _coundNotification = result['data'].length;
        notifyListeners();
      } else {
        _coundNotification = result['data'].length;
      }
    }
  }

  updateNotification(param) async {
    var result = await AuthRepository().updateNotification(param);
    print(result);
    getNotification();
    notifyListeners();
  }

  String _phoneNumber = '';

  String get phoneNumber => _phoneNumber;

  setPhoneNumber(phoneNumber) {
    _phoneNumber = phoneNumber;
    notifyListeners();
  }

  ChatUser _currentUserChat;

  ChatUser get currentUserChat => _currentUserChat;

  setFirestore(result) async {
    var dataUser = result['data'];
    var userCheck = await FirebaseFirestore.instance.collection('users').doc(dataUser['no_hp']).get();
    final ChatUser data = ChatUser(
      name: dataUser['nama'].toString(),
      avatar: dataUser['foto'] == null ? 'https://mbangun.id//api-v2//assets/kategori/worker.png' : dataUser['foto'],
      uid: dataUser['no_hp'].toString().replaceAll('+', ''),
    );
    if (!userCheck.exists) {
      await FirebaseFirestore.instance.collection('users').document(data.uid).set(data.toJson());
      _currentUserChat = data;
      notifyListeners();
    } else {
      _currentUserChat = data;
      notifyListeners();
    }
  }
}
