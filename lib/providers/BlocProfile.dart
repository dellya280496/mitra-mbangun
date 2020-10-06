import 'dart:io';

import 'package:apps/Repository/RajaOngkirRepository.dart';
import 'package:apps/Repository/UserRepository.dart';
import 'package:apps/models/City.dart';
import 'package:apps/models/Penghasilan.dart';
import 'package:apps/models/Provice.dart';
import 'package:apps/models/SubDistricById.dart';
import 'package:apps/models/SubDistrict.dart';
import 'package:apps/models/UserAddress.dart';
import 'package:flutter/material.dart';

class BlocProfile extends ChangeNotifier {
  BlocProfile() {
    getProvince();
  }

  getProfileUser(id) async {
    var param = {'id': id.toString()};
    var result = await UserRepository().getUserByParam(param);
  }

  String _id_provice, _id_city, _id_subdistrict;
  bool _isLoading = false;

  String get id_provice => _id_provice;

  String get id_city => _id_city;

  String get id_subdistrict => _id_subdistrict;

  bool get isLoading => _isLoading;

  setIdProvince(String value) {
    _id_provice = value;
    _listSubDistrict = [];
    _id_city = null;
    _id_subdistrict = null;
    getCity();
    notifyListeners();
  }

  setIdCity(String value) {
    _id_city = value;
    _id_subdistrict = null;
    getSubDistrict();
    notifyListeners();
  }

  setIdSubistrict(String value) {
    _id_subdistrict = value;
    notifyListeners();
  }

  clearDataCity() {
    _listCity = [];
    _listProvince = [];
    _listSubDistrict = [];
    _id_city = null;
    _id_provice = null;
    _id_subdistrict = null;
    getProvince();
    notifyListeners();
  }

  List<Provice> _listProvince = [];

  List<Provice> get listProvice => _listProvince;

  getProvince() async {
    _isLoading = true;
    notifyListeners();
    var param = {'': ''};
    var result = await RajaOngkirRepository().getProvince(param);
    Iterable list = [result];
    _listProvince = list.map((model) => Provice.fromMap(model)).toList();
    _isLoading = false;
    notifyListeners();
  }

  List<City> _listCity = [];

  List<City> get listCity => _listCity;

  getCity() async {
    _isLoading = true;
    notifyListeners();
    var param = {'province': _id_provice.toString()};
    var result = await RajaOngkirRepository().getCity(param);
    Iterable list = [result];
    _listCity = list.map((model) => City.fromMap(model)).toList();
    _isLoading = false;
    notifyListeners();
  }

  var _alamatToko = {};

  get alamatToko => _alamatToko;

  getCityParam(param) async {
    _isLoading = true;
    notifyListeners();
    var result = await RajaOngkirRepository().getCity(param);
    _alamatToko = result['rajaongkir']['results'];
    _isLoading = false;
    notifyListeners();
  }

  List<SubDistrict> _listSubDistrict = [];

  List<SubDistrict> get listSubDistrict => _listSubDistrict;

  getSubDistrict() async {
    _isLoading = true;
    notifyListeners();
    var param = {'city': _id_city.toString()};
    var result = await RajaOngkirRepository().getSubDistrict(param);
    Iterable list = [result];
    _listSubDistrict = list.map((model) => SubDistrict.fromMap(model)).toList();
    _isLoading = false;
    notifyListeners();
  }

  List<SubDistricById> _listSubDistrictById = [];

  List<SubDistricById> get listSubDistrictById => _listSubDistrictById;

  getSubDistrictById(id) async {
    _isLoading = true;
    notifyListeners();
    var param = {'id': id.toString()};
    var result = await RajaOngkirRepository().getSubDistrict(param);
    Iterable list = [result['rajaongkir']['results']];
    _listSubDistrictById = list.map((model) => SubDistricById.fromMap(model)).toList();
    _id_provice = _listSubDistrictById[0].provinceId;
    _id_city = _listSubDistrictById[0].cityId;
    _id_subdistrict = _listSubDistrictById[0].subdistrictId;
    getProvince();
    getCity();
    getSubDistrict();
    _isLoading = false;
    notifyListeners();
  }

  List<UserAddress> _listUserAddress = [];

  List<UserAddress> get listUserAddress => _listUserAddress;

  getAllUserAddress(id_user) async {
    _isLoading = true;
    notifyListeners();
    var param = {'id_user': id_user.toString()};
    var result = await UserRepository().getUserAddress(param);
    Iterable list = result['data'];
    _listUserAddress = list.map((model) => UserAddress.fromMap(model)).toList();
    if (_listUserAddress.isNotEmpty) {
      _isLoading = false;
    }
    _isLoading = false;
    notifyListeners();
  }

  List<UserAddress> _listUserDetailAddress = [];

  List<UserAddress> get listUserDetailAddress => _listUserDetailAddress;

  clearDetailAddress() {
    _listUserDetailAddress = [];
  }

  getUserAddressById(id) async {
    _isLoading = true;
    notifyListeners();
    var param = {'id': id.toString()};
    var result = await UserRepository().getUserAddress(param);
    Iterable list = result['data'];
    if (result['data'] != null) {
      _listUserDetailAddress = list.map((model) => UserAddress.fromMap(model)).toList();
      _isLoading = false;
    }
    notifyListeners();
  }

  List<UserAddress> _listUserAddressDefault = [];

  List<UserAddress> get listUserAddressDefault => _listUserAddressDefault;

  getUserAddressDefault(idUser) async {
    _isLoading = true;
    notifyListeners();
    var param = {'default': "1", "id_user": idUser.toString()};
    var result = await UserRepository().getUserAddress(param);
    Iterable list = result['data'];
    _listUserAddressDefault = list.map((model) => UserAddress.fromMap(model)).toList();
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> createShippingAddress(body) async {
    _isLoading = true;
    notifyListeners();
    var result = await UserRepository().createShippingAddress(body);
    if (result['meta']['success']) {
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _isLoading = false;
      notifyListeners();
      return result;
    }
  }

  Future<bool> updateShippingAddress(body) async {
    _isLoading = true;
    notifyListeners();
    var result = await UserRepository().updateShippingAddress(body);
    if (result['meta']['success']) {
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> setDefaultAlamat(body) async {
    _isLoading = true;
    notifyListeners();
    var result = await UserRepository().setDefaultAlamat(body);
    if (result['meta']['success']) {
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Map<String, dynamic> _dataToko = {};

  Map<String, dynamic> get dataToko => _dataToko;

  Future<dynamic> getTokoByParam(param) async {
    _isLoading = true;
    notifyListeners();
    var result = await UserRepository().getTokoByParam(param);
    print(result);
    if (result.toString() == '111' || result.toString() == '101' || result.toString() == '405' || result.toString() == 'Conncetion Error') {
      _connection = false;
      _isLoading = false;
      notifyListeners();
      return result;
    } else {
      if (result['meta']['success']) {
        _dataToko = result['data'][0];
        _isLoading = false;
        notifyListeners();
      } else {
        _isLoading = false;
        notifyListeners();
      }
    }
    return result;
  }

  bool _connection = false;

  bool get connection => _connection;

  updateToko(List<File> files, body) async {
    _isLoading = true;
    notifyListeners();
    var result = await UserRepository().updateToko(files, body);
    if (result.toString() == '111' || result.toString() == '101' || result.toString() == '405' || result.toString() == '8') {
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

  updateProfil(body) async {
    _isLoading = true;
    notifyListeners();
    var result = await UserRepository().updateProfil(body);
    print(result);
    if (result.toString() == '111' || result.toString() == '101' || result.toString() == '405' || result.toString() == '8') {
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

  List<Penghasilan> _listPenghasilan = [];

  List<Penghasilan> get listPenghasilan => _listPenghasilan;

  getPenghasilanByParam(param) async {
    _isLoading = true;
    notifyListeners();
    var result = await UserRepository().getPenghasilanByParam(param);
    if (result.toString() == '111' || result.toString() == '101' || result.toString() == '405') {
      _connection = false;
      _isLoading = false;
      notifyListeners();
      return result;
    } else {
      if (result['meta']['success']) {
        Iterable list = result['data'];
        _listPenghasilan = list.map((model) => Penghasilan.fromMap(model)).toList();
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
