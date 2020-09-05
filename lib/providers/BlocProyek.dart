import 'dart:io';

import 'package:apps/Repository/RajaOngkirRepository.dart';
import 'package:apps/Repository/UserRepository.dart';
import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/models/Bids.dart';
import 'package:apps/models/Iklan.dart';
import 'package:apps/models/OfficialStore.dart';
import 'package:apps/models/Proyek.dart';
import 'package:apps/models/Toko.dart';
import 'package:flutter/cupertino.dart';

class BlocProyek extends ChangeNotifier {
  int _limit = 10;
  int _offset = 0;
  int _totalProduk = 0;

  int get totalProduk => _totalProduk;

  int _totalProyek = 0;

  int get totalProyek => _totalProyek;

  bool _isLoading = false;
  bool _connection = false;

  bool get connection => _connection;

  bool get isLoading => _isLoading;

  BlocProyek() {
    initLoad();
  }

  initLoad() async {
    imageCache.clear();
    var idJenisLayanan = await LocalStorage.sharedInstance.readValue('id_jenis_layanan');
    var survey = await LocalStorage.sharedInstance.readValue('survey');
    if (survey == '1') {
      var param = {
        'aktif': '1',
        'status': "('survey','setuju')",
        'status_pembayaran_survey': 'terbayar',
        'limit': '6',
        'offset': offset.toString(),
      };
      getRecentProyek(param);
    } else {
      var param = {
        'aktif': '1',
        'status': "('setuju')",
        'status_pembayaran_survey': 'terbayar',
        'limit': '6',
        'offset': offset.toString(),
        'id_jenis_layanan': idJenisLayanan.toString()
      };
     getRecentProyek(param);
    }
    getIklan();
  }

  List<Toko> _toko = [
    Toko('https://m-bangun.com/wp-content/uploads/2020/07/contarctor.png', 'Boat roackerz 400 On-Ear Bluetooth Headphones', 'description', 120000, 2),
    Toko('https://m-bangun.com/wp-content/uploads/2020/07/properti-2.png', 'Boat roackerz 100 On-Ear Bluetooth Headphones', 'description', 122222, 1),
  ];

  List<Toko> get toko => _toko;

  remove(index) {
    _listProyeks.remove(index);
    notifyListeners();
  }

  add(value, index) {
    _listProyeks.forEach((element) {
      if (element.budget == index.price) {
//        element.stok = value;
        notifyListeners();
      }
      ;
    });
  }

  subTotal(index) {}

  List<Proyek> _listProyeks = [];

  int get limit => _limit;

  int get offset => _offset;

  setDefaultLimitAndOffset() {
    _limit = 10;
    _offset = 0;
    notifyListeners();
  }

  List<Proyek> get listProyeks => _listProyeks;

  getAllProyekByParam(param) async {
    setDefaultLimitAndOffset();
    imageCache.clear();
    _isLoading = true;
    notifyListeners();
    var result = await UserRepository().getAllProyek(param);
    if (result.toString() == '111' || result.toString() == '101' || result.toString() == '8') {
      _connection = false;
      _isLoading = false;
      _listProyeks = [];
      notifyListeners();
    } else {
      Iterable list = result['data'];
      _totalProyek = int.parse(result['meta']['total']);
      _listProyeks = list.map((model) => Proyek.fromMap(model)).toList();
      _isLoading = false;
      _connection = true;
      notifyListeners();
    }
  }

  loadMoreProyek(param) async {
    setDefaultLimitAndOffset();
    imageCache.clear();
    _isLoading = true;
    notifyListeners();
    var result = await UserRepository().getAllProyek(param);
    if (result.toString() == '111' || result.toString() == '101' || result.toString() == '8') {
      _connection = false;
      _isLoading = false;
      _listProyeks = [];
      notifyListeners();
    } else {
      Iterable list = result['data'];
      print(result['data']);
      _listProyeks.addAll(list.map((model) => Proyek.fromMap(model)).toList());
//      _listProyeks = list.map((model) => Proyek.fromMap(model)).toList();
      _isLoading = false;
      _connection = true;
      notifyListeners();
    }
  }

  clearDetailProduk() {
    _detailProyek = [];
    notifyListeners();
  }

  addCountViewProduk(body) async {
    var result = await UserRepository().addCountViewProduk(body);
  }

  List<Proyek> _detailProyek = [];

  List<Proyek> get detailProyek => _detailProyek;

  getDetailProyekByParam(param) async {
    imageCache.clear();
    _isLoading = true;
    _detailProyek = [];
    notifyListeners();
    var result = await UserRepository().getAllProyek(param);
    if (result.toString() == '111' || result.toString() == '101' || result.toString() == 'Conncetion Error') {
      _connection = false;
      _detailProyek = [];
      _isLoading = false;
      notifyListeners();
      return result['data'];
    } else {
      var id = await LocalStorage.sharedInstance.readValue('id_user_login');
      var body = {'id_user_login': '1', 'id_produk': param['id'], 'id_user_login': id.toString()};
      addCountViewProduk(body);
      Iterable list = result['data'];
      _detailProyek = list.map((model) => Proyek.fromMap(model)).toList();
      _connection = true;
      _isLoading = false;
      notifyListeners();
      return result['data'];
    }
  }

  Future<dynamic> getCurrentStokProduk(param) async {
    var result = await UserRepository().getAllProyek(param);
    return result['data'][0];
  }

  getFavoriteProyekByParam(param) async {
    imageCache.clear();
    _isLoading = true;
    notifyListeners();
    var result = await UserRepository().getFavoriteProyek(param);
//    print(result);
    if (result.toString() == '111' || result.toString() == '101' || result.toString() == 'Conncetion Error') {
      _connection = false;
      _isLoading = false;
      _listProyeks = [];
      notifyListeners();
    } else {
      Iterable list = result['data'];
      _listProyeks = list.map((model) => Proyek.fromMap(model)).toList();
      _isLoading = false;
      _connection = true;
      notifyListeners();
    }
  }

  List<OfficialStore> _listOfficialStore = [];

  List<OfficialStore> get listOfficialStore => _listOfficialStore;

  getOfficialStore() async {
    imageCache.clear();
    _isLoading = true;
    notifyListeners();
    var param = {'': ''};
    var result = await UserRepository().getOfficialStore(param);

    if (result.toString() == '111' || result.toString() == '101' || result.toString() == 'Conncetion Error') {
      _isLoading = false;
      _connection = false;
      _listOfficialStore = [];
      notifyListeners();
    } else {
      Iterable list = result['data'];
      _listOfficialStore = list.map((model) => OfficialStore.fromMap(model)).toList();
      _connection = true;
      _isLoading = false;
      notifyListeners();
    }
  }

  List<Iklan> _listIklan = [];

  List<Iklan> get listIklan => _listIklan;

  getIklan() async {
    imageCache.clear();
    _isLoading = true;
    notifyListeners();
    var param = {'': ''};
    var result = await UserRepository().getAllIklan(param);
    if (result.toString() == '111' || result.toString() == '101' || result.toString() == 'Conncetion Error') {
      _isLoading = false;
      _connection = false;
      _listIklan = [];
      notifyListeners();
    } else {
      Iterable list = result['data'];
      _listIklan = list.map((model) => Iklan.fromMap(model)).toList();
      _connection = true;
      _isLoading = false;
      notifyListeners();
    }
  }

  List<Proyek> _listRecentProyek = [];

  List<Proyek> get listRecentProyek => _listRecentProyek;

  getRecentProyek(param) async {
    imageCache.clear();
    _isLoading = true;
    notifyListeners();
    var result = await UserRepository().getAllProyek(param);
    print(param);
    if (result.toString() == '111' || result.toString() == '101' || result.toString() == 'Conncetion Error') {
      _connection = false;
      _isLoading = false;
      _listRecentProyek = [];
      notifyListeners();
    } else {
      Iterable list = result['data'];
      _listRecentProyek = list.map((model) => Proyek.fromMap(model)).toList();
      _isLoading = false;
      _connection = true;
      notifyListeners();
    }
  }

  Future<bool> addBidding(body) async {
    imageCache.clear();
    _isLoading = true;
    notifyListeners();
    var result = await UserRepository().addBidding(body);
    if (result.toString() == '111' || result.toString() == '101' || result.toString() == 'Conncetion Error') {
      _connection = false;
      _isLoading = false;
      notifyListeners();
      return false;
    } else {
      if (result['meta']['success']) {
        _isLoading = false;
        _connection = true;
        notifyListeners();
        return true;
      } else {
        _isLoading = false;
        _connection = true;
        notifyListeners();
        return false;
      }
    }
  }

  List<Bids> _listBids = [];

  List<Bids> get listBids => _listBids;

  Future<bool> getBidsByParam(param) async {
    imageCache.clear();
    _isLoading = true;
    notifyListeners();
    var result = await UserRepository().getBidsByParam(param);
    print(param);
    if (result['meta']['success']) {
      _isLoading = false;
      Iterable list = result['data'];
      _listBids = list.map((model) => Bids.fromMap(model)).toList();
      notifyListeners();
      return true;
    } else {
      _listBids = [];
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  updateProyek(List<File> files, body) async {
    _isLoading = true;
    notifyListeners();
    var result = await UserRepository().updateProyek(files, body);
    if (result.toString() == '111' || result.toString() == '101' || result.toString() == '405' || result.toString() == 'Conncetion Error') {
      _connection = false;
      _isLoading = false;
      notifyListeners();
      return result;
    } else {
      if (result['meta']['success']) {
        _isLoading = false;
        _connection = true;
        notifyListeners();
        return result;
      } else {
        _isLoading = false;
        notifyListeners();
        return result;
      }
    }
  }
}
