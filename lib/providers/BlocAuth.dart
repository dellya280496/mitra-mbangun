import 'package:apps/Repository/AuthRepository.dart';
import 'package:apps/Repository/UserRepository.dart';
import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/models/JenisLayananMitra.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info/package_info.dart';

class BlocAuth extends ChangeNotifier {
  BlocAuth() {
    getCurrentUser();
  }

  bool _isLoading = true;
  bool _isLogin = false;
  String _statusToko = '0';
  String _idToko = '0';
  bool _isRegister = false;
  bool _isMitra = false;
  String _errorMessage, _idUser, _token;
  bool _connection = true;
  bool _isNonActive = false;

  bool get isNonActive => _isNonActive;

  String get statusToko => _statusToko;

  String get idToko => _idToko;

  bool get connection => _connection;

  String get errorMessage => _errorMessage;

  bool get isRegister => _isRegister;

  bool get isMitra => _isMitra;

  bool get isLoading => _isLoading;

  String get idUser => _idUser;

  bool get isLogin => _isLogin;
  GoogleSignInAccount _currentUser;

  GoogleSignInAccount get currentUser => _currentUser;

  handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      checkSession();
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>['email'],
  );

  handleSignOut() async {
    _googleSignIn.disconnect().then((value) {
      _googleSignIn.isSignedIn().then((value) {
        if (value) {
          checkSession();
          return true;
        } else {
          _isLogin = false;
          _idToko = '0';
          _idUser = '0';
          _connection = true;
          _isNonActive = false;
          _isRegister = false;
          notifyListeners();
          LocalStorage.sharedInstance.deleteValue('id_user_login');
          LocalStorage.sharedInstance.deleteValue('id_toko');
          return false;
        }
      });
    });
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

  getCurrentUser() {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      _currentUser = account;
      if (account != null) {
        checkSession();
      } else {
        handleSignOut();
      }
    });
    _googleSignIn.signInSilently();
  }

  List<JenisLayananMitra> _listJenisLayananMitra = [];

  List<JenisLayananMitra> get listJenisLayananMitra => _listJenisLayananMitra;

  checkSession() async {
    checkVersionApp();
    _isLoading = false;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 1), () {
      _googleSignIn.isSignedIn().then((value) async {
        if (value) {
          if (_currentUser == null) {
            getCurrentUser();
            _connection = true;
            _isLoading = false;
            _isLogin = false;
            notifyListeners();
            return false;
          } else {
            var queryString = {'username': _currentUser.email, 'id_google': _currentUser.id};
            var result = await AuthRepository().googleSign(queryString);
            if (result.toString() == '111' || result.toString() == '101' || result.toString() == 'Conncetion Error') {
              _connection = false;
              _isLoading = false;
              notifyListeners();
              return false;
            } else {
              if (result['meta']['success']) {
                _statusToko = result['data']['status_toko'];
                if (result['data']['aktif'] != '1') {
                  _isNonActive = true;
                  _connection = true;
                  _isLogin = false;
                  notifyListeners();
                  await Future.delayed(Duration(milliseconds: 1), () {
                    handleSignOut();
                  });
                  return true;
                } else {
                  if (result['data']['aktif_mitra'] != '1') {
                    Iterable list = result['jenis_layanan_mitra'];
                    _listJenisLayananMitra = list.map((model) => JenisLayananMitra.fromMap(model)).toList();
                    _connection = true;
                    _token = result['token'];
                    _idToko = result['data']['id_toko'].toString();
                    LocalStorage.sharedInstance.writeValue(key: 'id_toko', value: result['data']['id_toko']);
                    LocalStorage.sharedInstance.writeValue(key: 'id_jenis_layanan', value: _listJenisLayananMitra.map((e) => e.id).toString());
                    LocalStorage.sharedInstance.writeValue(key: 'id_user_login', value: result['data']['id']);
                    _idUser = result['data']['id'];
                    _isMitra = false;
                    _isRegister = false;
                    _isLoading = false;
                    _isLogin = true;
                    notifyListeners();
                    return true;
                  } else {
                    Iterable list = result['jenis_layanan_mitra'];
                    _listJenisLayananMitra = list.map((model) => JenisLayananMitra.fromMap(model)).toList();
                    _connection = true;
                    _token = result['token'];
                    _idToko = result['data']['id_toko'].toString();
                    LocalStorage.sharedInstance.writeValue(key: 'id_toko', value: result['data']['id_toko']);
                    LocalStorage.sharedInstance.writeValue(key: 'id_jenis_layanan', value: _listJenisLayananMitra.map((e) => e.id).toString());
                    LocalStorage.sharedInstance.writeValue(key: 'id_user_login', value: result['data']['id']);
                    _idUser = result['data']['id'];
                    _isRegister = false;
                    _isLoading = false;
                    _isLogin = true;
                    _isMitra = true;
                    notifyListeners();
                    return true;
                  }
                }
              } else {
                _connection = true;
                _isRegister = true;
                _isLoading = false;
                _isLogin = false;
                notifyListeners();
                return false;
              }
            }
          }
        } else {
          getCurrentUser();
          _connection = true;
          _isLogin = false;
          _isLoading = false;
          notifyListeners();
          return false;
        }
      });
    });
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
    if (result.toString() == '111' || result.toString() == '101' || result.toString() == 'Conncetion Error') {
      _connection = false;
      _isLoading = false;
      notifyListeners();
      return result;
    } else {
      _newVersion = double.parse(result['data'][0]['versi_nomor'].trim().replaceAll(".", ""));
      if (newVersion > currentVersion) {
        _showVersionDialog = true;
        notifyListeners();
      }
    }
  }
}
