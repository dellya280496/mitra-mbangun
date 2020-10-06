import 'dart:convert';
import 'dart:io';

import 'package:apps/Api/Api.dart';
import 'package:apps/Utils/BottomAnimation.dart';
import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/models/GroupKategoriM.dart';
import 'package:apps/models/InvoiceM.dart';
import 'package:apps/models/KategoriFlagM.dart';
import 'package:apps/models/KategoriM.dart';
import 'package:apps/models/KecamatanM.dart';
import 'package:apps/models/KotaM.dart';
import 'package:apps/models/MetodeTransferM.dart';
import 'package:apps/models/ProdukListM.dart';
import 'package:apps/models/ProvinsiM.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info/package_info.dart';

class DataProvider extends ChangeNotifier {
  DataProvider() {
////    versionCheck();
//    getToken();
//    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
//      _currentUser = account;
//      notifyListeners();
//    });
//    _googleSignIn.signInSilently();
  }


  File _file;

  File get file => _file;

  setFile(File file) {
    _file = file;
    notifyListeners();
  }

  bool _upload = false;

  bool get upload =>_upload;

  setUpload(bool upload){
    _upload = upload;
    notifyListeners();
  }

  bool isFavorite = false;
  bool _isLoading = false;
  bool _isBid = false;
  bool _connection = true;

  bool get connection => _connection;

  bool get isBid => _isBid;

  bool _isLogin = false;

  bool get isLogin => _isLogin;
  static String username = 'm-bangun';
  static String password = 'admin9876s';
  static String str = '$username:$password';
  static String basicAuth = base64Encode(utf8.encode(str));

  bool get isLoading => _isLoading;

  GoogleSignInAccount _currentUser;

  GoogleSignInAccount get currentUser => _currentUser;

  Future<void> handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      chekSession();
    } catch (error) {
      print(error);
    }
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>['email'],
  );

  Future<void> handleSignOut() async {
    _googleSignIn.disconnect().then((value) {
      _googleSignIn.isSignedIn().then((value) {
        if (!value) {
          chekSession();
        }
      });
    });
  }

  setLoading(bool Boolean) {
    _isLoading = Boolean;
    notifyListeners();
  }

  setLogin(bool Boolean) {
    _isLogin = Boolean;
    notifyListeners();
  }

  String userId;

  String get userId_ => userId;
  String _title;
  String token = '';

  String get getTokenData => token;

  String get getTitle => this._title;

  List<ProdukListM> _produkListById = [];

  List<ProdukListM> get getProdukListByIdUser => this._produkListById;

  setProdukListById(List<ProdukListM> param) {
    this._produkListById = param;
    notifyListeners();
  }

  setTitle(String param) {
    this._title = param;
    notifyListeners();
  }

  List<KategoriM> _dataKategori = [];

  List<KategoriM> get getDataKategori => _dataKategori;

  setDataKategori(List<KategoriM> data) {
    _dataKategori = data;
    notifyListeners();
  }

  void getToken() async {
    _connection = true;
//    notifyListeners();
//    try {
//      final result = await InternetAddress.lookup('google.com');
//      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//        Api.getToken().then((value) async {
////          print(value);
//          if (value.statusCode == 200) {
//            var data = json.decode(value.body);
//            LocalStorage.sharedInstance.writeValue(key: 'token', value: data['data']['token']);
//            token = await LocalStorage.sharedInstance.readValue('token');
//            if (token != null) {
//              chekSession();
////              versionCheck();
////              getGroupKatgori();
//              _connection = true;
//              notifyListeners();
//            }
//          } else {
//            _connection = false;
//            notifyListeners();
//          }
//        });
//      }
//    } on SocketException catch (_) {
//      print('not connected');
//      _connection = false;
//      notifyListeners();
//    }
  }

  chekSession() async {
    _googleSignIn.isSignedIn().then((value) {
      print(value);
      if (value) {
        _currentUser = _googleSignIn.currentUser;
        getCurrentLocation();
        _isLogin = true;
        getProfile();
        notifyListeners();
      } else {
        _isLogin = false;
        _verified = false;
        _userKategori = null;
        notifyListeners();
      }
    });
//    token = await LocalStorage.sharedInstance.readValue('token');
//    String dataSession = await LocalStorage.sharedInstance.readValue('session');
////    print(dataSession);
//    if (dataSession != null) {
//      userId = json.decode(dataSession)['data']['data_user']['userid'];
//      getCurrentLocation();
//      _isLogin = true;
//      getProfile();
//      getAllKategori();
//      notifyListeners();
//    } else {
////      print('test');
//      _isLogin = false;
//      _verified = false;
//      _userKategori = null;
//      notifyListeners();
//      getAllKategori();
//    }
  }

  String _userNama, _userEmail, _userNotelp, _userFoto, _userPengalamanKerja;
  String _fotoNull =
      'https://previews.123rf.com/images/urfandadashov/urfandadashov1809/urfandadashov180901275/109135379-photo-not-available-vector-icon-isolated-on-transparent-background-photo-not-available-logo-concept.jpg';

  String get userPengalamanKerja => _userPengalamanKerja;

  String get fotoNull => _fotoNull;

  String get userNama => _userNama;

  String get userEmail => _userEmail;

  String get userNotelp => _userNotelp;

  String get userFoto => _userFoto;

//  void getUserData() async {
//    print(_isLoading);
//    imageCache.clear();
//    String dataSession = await LocalStorage.sharedInstance.readValue('session');
//    _userEmail = json.decode(dataSession)['data']['data_user']['useremail'];
//    _userNama = json.decode(dataSession)['data']['data_user']['usernamalengkap'];
//    _userNotelp = json.decode(dataSession)['data']['data_user']['usertelp'];
//    _userFoto = json.decode(dataSession)['data']['data_user']['userfoto'];
//    _isLoading = false;
//    notifyListeners();
//  }

  String _userSiup, _userAkte, _userKategori, _userProdukKategoriSubId, _userSubKategori, _userPremium;
  bool _verified = false;

  String get userSiup => _userSiup;

  String get userAkte => _userAkte;

  String get userKategori => _userKategori;

  String get userProdukKategoriSubId => _userProdukKategoriSubId;

  String get userSubKategori => _userSubKategori;

  String get userPremium => _userPremium;

  bool get verified => _verified;

  getProfile() async {
    try {
      imageCache.clear();
      Api.getUserById(token, userId).then((response) {
        var data = json.decode(response.body);
        print(data['data']['data_user']['produkkategorisubid']);
        LocalStorage.sharedInstance.writeValue(key: 'session', value: json.encode(data));
        _userEmail = data['data']['data_user']['useremail'];
        _userNama = data['data']['data_user']['usernamalengkap'];
        _userNotelp = data['data']['data_user']['usertelp'];
        _userFoto = data['data']['data_user']['userfoto'];
//        print(data);
//        if (data['data']['data_user']['produkkategoriid'] != null) {
        _userSiup = data['data']['data_user']['usersiup'];
        _userAkte = data['data']['data_user']['userakteperusahaan'];
        _userKategori = data['data']['data_user']['produkkategorinama'];
        _userProdukKategoriSubId = data['data']['data_user']['produkkategorisubid'];
        _userSubKategori = data['data']['data_user']['produkkategorisubnama'];
        _userEmail = data['data']['data_user']['useremail'];
        _userNama = data['data']['data_user']['usernamalengkap'];
        _userNotelp = data['data']['data_user']['usertelp'];
        _userFoto = data['data']['data_user']['userfoto'];
        _userPengalamanKerja = data['data']['data_user']['userpengalamankerja'];
        getRecentProject();
        _isLoading = false;
        notifyListeners();
//        }
//        _userKategori = data['data']['data_user']['produkkategorinama'];
//        print(data['data']['data_user']['useraktivasiakunpremium'] == '1');
        if (data['data']['data_user']['useraktivasiakunpremium'] == '1') {
          _verified = true;
          _isLoading = false;
          notifyListeners();
        } else {
          _verified = false;
          _isLoading = false;
          notifyListeners();
        }
      });
    } catch (err) {
      print(err);
    }
  }

  getProfileWorker(workerId) async {
    try {
      imageCache.clear();
      Api.getUserById(token, workerId.toString()).then((response) {
//        print(response.body);
        var data = json.decode(response.body);
//        LocalStorage.sharedInstance.writeValue(key: 'session', value: json.encode(data));
        _userEmail = data['data']['data_user']['useremail'];
        _userNama = data['data']['data_user']['usernamalengkap'];
        _userNotelp = data['data']['data_user']['usertelp'];
        _userFoto = data['data']['data_user']['userfoto'];
//        print(data);
        if (data['data']['data_user']['produkkategoriid'] != null) {
          _userSiup = data['data']['data_user']['usersiup'];
          _userAkte = data['data']['data_user']['userakteperusahaan'];
          _userKategori = data['data']['data_user']['produkkategorinama'];
          _userSubKategori = data['data']['data_user']['produkkategorisubnama'];
          _userEmail = data['data']['data_user']['useremail'];
          _userNama = data['data']['data_user']['usernamalengkap'];
          _userNotelp = data['data']['data_user']['usertelp'];
          _userFoto = data['data']['data_user']['userfoto'];
          _userPengalamanKerja = data['data']['data_user']['userpengalamankerja'];
          _isLoading = false;
          notifyListeners();
        }
//        print(data['data']['data_user']['useraktivasiakunpremium'] == '1');
        if (data['data']['data_user']['useraktivasiakunpremium'] == '1') {
          _verified = true;
          _isLoading = false;
          notifyListeners();
        } else {
          _verified = false;
          _isLoading = false;
          notifyListeners();
        }
      });
    } catch (err) {
      print(err);
    }
  }

  String _selectedKategori = null;

  String get getSelectedKategori => _selectedKategori;

  setSelectedKategori(String data) {
    _selectedKategori = data;
    notifyListeners();
  }


  String _selectedSubKategori = null;

  String get getSelectedSubKategori => _selectedSubKategori;

  setSelectedSubKategori(String data) {
    _selectedSubKategori = data;
    notifyListeners();
  }

  List<ProvinsiM> _dataProvinsi = [];

  List<ProvinsiM> get getDataProvinsi => _dataProvinsi;

  setDataProvinsi(List<ProvinsiM> data) {
    _dataProvinsi = data;
    notifyListeners();
  }

  String _selectedProvinsi = null;

  String get getSelectedProvinsi => _selectedProvinsi;

  setSelectedProvinsi(String data) {
    _selectedProvinsi = data;
    notifyListeners();
  }

  List<KotaM> _dataKota = [];

  List<KotaM> get getDataKota => _dataKota;

  setDataKota(List<KotaM> data) {
    _dataKota = data;
    notifyListeners();
  }

  String _selectedKota = null;

  String get getSelectedKota => _selectedKota;

  setSelectedKota(String data) {
    _selectedKota = data;
    notifyListeners();
  }

  List<KecamatanM> _dataKecamatan = [];

  List<KecamatanM> get getDataKecamatan => _dataKecamatan;

  setDataKecamatan(List<KecamatanM> data) {
    _dataKecamatan = data;
    notifyListeners();
  }

  String _selectedKecamatan = null;

  String get getSelectedKecamatan => _selectedKecamatan;

  setSelectedKecamatan(String data) {
    _selectedKecamatan = data;
    notifyListeners();
  }

  String _alamatLengkap;

  String get getAlamatLengkap => _alamatLengkap;

  setAlamatLengkap(String alamat) {
    _alamatLengkap = alamat;
    notifyListeners();
  }

  bool _reload = false;
  String key = '';

  String get keySearch => key;

  setKeySearch(String query) {
    notifyListeners();
    if (query.isEmpty) {
      dataProdukListByParam = [];
      key = '';
      notifyListeners();
    } else {
      getAllProdukListByParam();
      notifyListeners();
    }
  }

  String idSubKategori = '';

  setidSubKategori(String id) {
    idSubKategori = id;
    notifyListeners();
  }

  List<ProdukListM> dataProdukListByParam = [];

  bool get getReloadProduk => _reload;

  List<ProdukListM> get getProdukListByParam => dataProdukListByParam;

  getAllProdukListByParam() async {
    imageCache.clear();
    _isLoading = true;
    String currentIdProvinsi = await LocalStorage.sharedInstance.readValue('idProvinsi');
    String currentIdKota = await LocalStorage.sharedInstance.readValue('idKota');
    String currentIdKecamatan = await LocalStorage.sharedInstance.readValue('idKecamatan');
    notifyListeners();
    var queryParameters = {
      'sub': idSubKategori.toString(),
      'kec': currentIdKecamatan.toString() == 'null' ? '' : currentIdKecamatan.toString(),
      'kota': currentIdKota.toString() == 'null' ? '' : currentIdKota.toString(),
      'prov': currentIdProvinsi.toString() == 'null' ? '' : currentIdProvinsi.toString(),
      'key': key.toString(),
    };
    Api.getAllProdukByParam(token, queryParameters).then((response) {
//      print(response.body);
      var result = json.decode(response.body);
      if (result['status'] == true) {
        Iterable list = json.decode(response.body)['data'];
        dataProdukListByParam = list.map((model) => ProdukListM.fromMap(model)).toList();
        _isLoading = false;
        notifyListeners();
      }
    });
  }

  List<ProdukListM> _dataRecentProject = [];

  List<ProdukListM> get dataRecentProject => _dataRecentProject;

  getRecentProject() async {
    imageCache.clear();
    _isLoading = true;
    String currentIdProvinsi = await LocalStorage.sharedInstance.readValue('idProvinsi');
    String currentIdKota = await LocalStorage.sharedInstance.readValue('idKota');
    String currentIdKecamatan = await LocalStorage.sharedInstance.readValue('idKecamatan');
    notifyListeners();
    var queryParameters = {
      'sub': _userProdukKategoriSubId.toString(),
      'kec': currentIdKecamatan.toString() == 'null' ? '' : currentIdKecamatan.toString(),
      'kota': currentIdKota.toString() == 'null' ? '' : currentIdKota.toString(),
      'prov': currentIdProvinsi.toString() == 'null' ? '' : currentIdProvinsi.toString(),
      'key': key.toString(),
      'limit': '5'
    };
    Api.getAllProdukByParam(token, queryParameters).then((response) {
//      print(response.body);
      var result = json.decode(response.body);
      if (result['status'] == true) {
        Iterable list = json.decode(response.body)['data'];
        _dataRecentProject = list.map((model) => ProdukListM.fromMap(model)).toList();
        _isLoading = false;
        notifyListeners();
      }
    });
  }

  getAllFavoriteProdukByUserId() async {
    imageCache.clear();
    var queryParameters = {'userid': userId, 'produkaktif': '1'};
    Api.getAllFavoriteByParam(token, queryParameters).then((response) {
      var result = json.decode(response.body);
      print(result);
      if (result['status'] == true) {
        Iterable list = json.decode(response.body)['data'];
        dataProdukListByParam = list.map((model) => ProdukListM.fromMap(model)).toList();
        notifyListeners();
      }
    });
  }

  String _namaProvinsi = '';
  String _namaKecamatan;
  String _namaKota;

  String get namaProvinsi => _namaProvinsi;

  String get namaKota => _namaKota;

  String get namaKecamatan => _namaKecamatan;

  getCurrentLocation() async {
    String currentIdProvinsi = await LocalStorage.sharedInstance.readValue('idProvinsi');
    if (currentIdProvinsi == null) {
    } else {
      Api.getProvinsiById(token, currentIdProvinsi).then((value) {
        var result = json.decode(value.body);
        _namaProvinsi = result['data']['nama_propinsi'];
        notifyListeners();
      });
      String currentIdKota = await LocalStorage.sharedInstance.readValue('idKota');
      if (currentIdKota != 'null') {
        Api.getKotaById(token, currentIdKota).then((value) {
          var result = json.decode(value.body);
          _namaKota = result['data']['nama_kabkota'];
          notifyListeners();
        });
      } else {
        _namaKota = null;
      }
      String currentIdKecamatan = await LocalStorage.sharedInstance.readValue('idKecamatan');
      if (currentIdKecamatan != 'null') {
        Api.getKecamatanById(token, currentIdKecamatan).then((value) {
          var result = json.decode(value.body);
          _namaKecamatan = result['data']['nama_kecamatan'];
          notifyListeners();
        });
      } else {
        _namaKecamatan = null;
      }
    }
  }

  Map<String, dynamic> dataProdukById;

  Map<String, dynamic> get getdataProdukById => dataProdukById;

  getProdukById(String produkId) {
    imageCache.clear();
    var queryParameters = {'pro_id': produkId.toString()};
    _isLoading = true;
    notifyListeners();
    Api.getAllProdukByParam(token, queryParameters).then((value) {
      var result = json.decode(value.body);
//      print(produkId);
      if (result['status']) {
        if (userId != null) {
          getFavoriteByProdukIdAndUserId(produkId);
          _isLoading = false;
          imageCache.clear();
          notifyListeners();
        }
        _isLoading = false;
        dataProdukById = result;
        notifyListeners();
      } else {
        _isLoading = false;
        notifyListeners();
      }
    });
  }

  bool get favoriteProduk => isFavorite;

  getFavoriteByProdukIdAndUserId(produkId) {
    var queryParameters = {'pro_id': produkId.toString(), 'userid': userId};
    Api.getAllFavoriteByParam(token, queryParameters).then((value) {
      var result = json.decode(value.body);
      if (result['data'].length == 1) {
        isFavorite = true;
        _isLoading = false;
        notifyListeners();
      } else {
        isFavorite = false;
        _isLoading = false;
        notifyListeners();
      }
      notifyListeners();
    });
  }

  setFavoriveByUserId(produkId) {
    var map = new Map<String, dynamic>();
    map['userid'] = userId;
    map['produkid'] = produkId;
    Api.createFavoriteByUserId(token, map).then((value) {
      print(value.body);
      var result = json.decode(value.body);
      if (result['status']) {
        isFavorite = !isFavorite;
        getFavoriteByProdukIdAndUserId(produkId);
        notifyListeners();
      }
    });
  }

  deleteFavoriteByUserId(produkId) {
    var map = new Map<String, dynamic>();
    map['userid'] = userId;
    map['produkid'] = produkId;
    Api.deleteFavoriteByUserIdAndProdukId(token, map).then((value) {
      var result = json.decode(value.body);
      if (result['status']) {
        isFavorite = !isFavorite;
        getFavoriteByProdukIdAndUserId(produkId);
        notifyListeners();
      }
    });
  }

  void logout(context) {
    LocalStorage.sharedInstance.deleteValue('session');
    Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
          return BottomAnimateBar();
        }, transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
          return new SlideTransition(
            position: new Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        }),
        (Route route) => false);
    chekSession();
    _userProdukKategoriSubId = null;
  }

  void getProdukListByUserId(param) async {
    var queryParameters = {
      'stp': param.toString(),
      'userid': userId.toString(),
    };
    _isLoading = true;
    Api.getAllProdukByParam(token, queryParameters).then((response) {
      var result = json.decode(response.body);
//      print(result);
      if (result['status'] == true) {
        Iterable list = json.decode(response.body)['data'];
        _produkListById = list.map((model) => ProdukListM.fromMap(model)).toList();
        _isLoading = false;
        notifyListeners();
      } else {
        _isLoading = false;
        notifyListeners();
      }
    });
  }

//  var kategoriFlag = new List<KategoriFlagM>();
  var kategoriGroupByFlag = new List<KategoriFlagM>();

  List<KategoriFlagM> get dataKategoriGroupByFlag => kategoriGroupByFlag;

  void getKategoriGroupFlag() async {
    var queryParameters = {'produkkategoriaktif': '1'};
    Api.getAllGroupByParam(token, queryParameters).then((response) {
      Iterable list = json.decode(response.body)['data'];
      kategoriGroupByFlag = list.map((model) => KategoriFlagM.fromMap(model)).toList();
      notifyListeners();
    });
  }

  void chekUserBidding(produkId) {
    var queryParameters = {
      'produkId': produkId.toString(),
      'userId': userId.toString(),
    };
    Api.getBidByParam(token, queryParameters).then((response) {
      _isBid = json.decode(response.body)['isBid'];
      notifyListeners();
    });
  }



  Map<String, dynamic> _dataKontrak;

  Map<String, dynamic> get dataKontrak => _dataKontrak;

  void getKontrakByProdukId(produkId) {
    var queryParameters = {'produkId': produkId.toString()};
    Api.getKontrakByParam(token, queryParameters).then((response) {
      var result = json.decode(response.body);
      _dataKontrak = result;
//      print(response.body);
      notifyListeners();
    });
  }

  List<InvoiceM> _invoiceListData = [];

  List<InvoiceM> get invoiceListData => _invoiceListData;

  void getAllInvoice(produkId) {
    _isLoading = true;
    var queryParameters = {'produkId': produkId.toString(), 'userId': userId.toString()};
    Api.getAllInvoiceByParam(token, queryParameters).then((response) {
      var result = json.decode(response.body);
      Iterable list = result['data'];
      _invoiceListData = list.map((model) => InvoiceM.fromMap(model)).toList();
      _isLoading = false;
      notifyListeners();
    });
  }

  List<GroupKategoriM> _groupData = [];

  List<GroupKategoriM> get groupData => _groupData;

  void getGroupKatgori() {
    _isLoading = true;
    var queryParameters = {'group_aktif': '1'};
    Api.getAllGroupKategori(token, queryParameters).then((response) {
//      versionCheck();
      var result = json.decode(response.body);
      Iterable list = result['data'];
      _groupData = list.map((model) => GroupKategoriM.fromMap(model)).toList();
      _isLoading = false;
      notifyListeners();
    });
  }

  List<MetodeTransferM> _dataMetodeTransfer = [];

  List<MetodeTransferM> get dataMetodeTransfer => _dataMetodeTransfer;

  void getAllMetodeTransfer() {
    _isLoading = true;
    Api.getAllMetodeTransfer(token).then((response) {
      var result = json.decode(response.body);
//      print(response.body);
      Iterable list = result['data'];
      _dataMetodeTransfer = list.map((model) => MetodeTransferM.fromMap(model)).toList();
      _isLoading = false;
      notifyListeners();
    });
  }

  createSignature(map) {
    _isLoading = true;
    Api.createSignature(token, map).then((response) {
      var result = json.decode(response.body);
      if (result['status']) {
        _isLoading = false;
        notifyListeners();
      }
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

  versionCheck() async {
    //Get Current installed version of app
    final PackageInfo info = await PackageInfo.fromPlatform();
    _currentVersion = double.parse(info.version.trim().replaceAll(".", ""));
    notifyListeners();
    Api.getNewVersion(token).then((response) {
      final result = json.decode(response.body)['data'][0];
      _newVersion = double.parse(result['version_number'].trim().replaceAll(".", ""));
      if (newVersion > currentVersion) {
        _showVersionDialog = true;
        notifyListeners();
      }
      notifyListeners();
    });
  }

  updateToKontrak(body) {
    _isLoading = true;
    notifyListeners();
    Api.updateBidToKontrakByIdUser(token, body).then((response) {
      final result = json.decode(response.body);
      if (result['status']) {
        _isLoading = false;
//        print(body);
        notifyListeners();
      }
    });
  }
}
