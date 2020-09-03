import 'package:apps/Repository/OrderRepository.dart';
import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/models/Cart.dart';
import 'package:apps/models/Order.dart';
import 'package:apps/models/OrderProduk.dart';
import 'package:apps/models/Ulasan.dart';
import 'package:flutter/cupertino.dart';

class BlocOrder extends ChangeNotifier {
  BlocOrder() {
    getCart();
    setIdUser();
  }

  getOrderByIdUser(idUser) async {
    getCountOrderByParam();
  }

  String _id_user_login;

  String get id_user_login => _id_user_login;

  bool _errorShippingAddres = false;

  bool get errorShippingAddres => _errorShippingAddres;

  bool _errorMethodeTransfer = false;

  bool get errorMethodeTransfer => _errorMethodeTransfer;

  setErrorShippingAddres(bool value) {
    _errorShippingAddres = value;
    // print(_errorShippingAddres);
    notifyListeners();
  }

  setErrorMethodeTransfer(bool value) {
    _errorMethodeTransfer = value;
    notifyListeners();
  }

  setIdUser() async {
    var id = await LocalStorage.sharedInstance.readValue('id_user_login');
    var idToko = await LocalStorage.sharedInstance.readValue('id_toko');
    print(idToko);
    if (id != null) {
      _id_user_login = id;
      getOrderByIdUser(id);
      getCountSaleByParam({'id_toko': idToko.toString()});
      getCart();
    } else {
      _id_user_login = '0';
    }
    notifyListeners();
  }

  bool _connection = false;
  bool _isLoading = false;
  int _jumlah = 1;
  String _catatan = '';

  int get jumlah => _jumlah;

  String get catatan => _catatan;

  setJumlah(int value) {
    _jumlah = value;
    notifyListeners();
  }

  setCatatan(String value) {
    _catatan = value;
    notifyListeners();
  }

  bool get connection => _connection;

  bool get isLoading => _isLoading;

  removeCart(id) async {
    var body = new Map<String, String>();
    body['id'] = id.toString();
    var result = await OrderRepository().removeCart(body);
//    print(result);
    if (result['meta']['success']) {
      getCart();
    }
    notifyListeners();
  }

  updateCart(body) async {
    var result = await OrderRepository().updateCart(body);
    if (result['meta']['success']) {
      getCart();
      notifyListeners();
    }
  }

  clearCart() {
    _listCart = [];
    notifyListeners();
  }

  addToCart(body) async {
    var result = await OrderRepository().addToCart(body);
    if (result.toString() == '111' || result.toString() == '101' || result.toString() == 'Conncetion Error') {
      _connection = false;
      getCart();
      notifyListeners();
      return false;
    } else {
      if (result['meta']['success']) {
        getCart();
        _connection = true;
        notifyListeners();
        return true;
      } else {
        _connection = false;
        notifyListeners();
        return false;
      }
    }
  }

  List<Cart> _listCart = [];

  List<Cart> get listCart => _listCart;

  Future<dynamic> getCart() async {
    _isLoading = true;
    notifyListeners();
    var id = await LocalStorage.sharedInstance.readValue('id_user_login');
    var param = {'id_user_login': id.toString()};
    var result = await OrderRepository().getCart(param);
    if (result.toString() == '111' || result.toString() == '101' || result.toString() == 'Conncetion Error') {
      _connection = false;
      _isLoading = false;
      _listCart = [];
      notifyListeners();
      return result['data'];
    } else {
      if (result['meta']['success']) {
        _isLoading = false;
        _connection = true;
        _listCart = [];
        Iterable list = result['data'];
        _listCart = list.map((model) => Cart.fromMap(model)).toList();
        notifyListeners();
        return result['data'];
      } else {
        _connection = false;
        _isLoading = false;
        _listCart = [];
        notifyListeners();
        return result['data'];
      }
    }
  }

  List _listMetodePembayaran = [];

  List get listMetodePembayaran => _listMetodePembayaran;

  getMetodePembayaran() async {
    var param = {'': ''};
    var result = await OrderRepository().getMetodePembayaran(param);
    print(result);
    _listMetodePembayaran = result['data'];
    notifyListeners();
  }

  List _listCost = [];

  List get listCost => _listCost;

  getCost(param) async {
    _isLoading = true;
    _listCost = [];
    notifyListeners();
    var result = await OrderRepository().getCost(param);
    if (result != null) {
      _listCost = result;
      _isLoading = false;
      notifyListeners();
    }
  }

  Map<String, dynamic> _listMetodePembayaranSelected = {};

  Map<String, dynamic> get listMetodePembayaranSelected => _listMetodePembayaranSelected;

  onChangeMetodePembayaran(Map<String, dynamic> body) {
    _listMetodePembayaranSelected = body;
  }

  Map<String, dynamic> _listCostSelected = {};

  Map<String, dynamic> get listCostSelected => _listCostSelected;

  onChangeCost(Map<String, dynamic> body) {
    _listCostSelected = body;
    notifyListeners();
  }

  clearCost() {
    _listCostSelected = {};
    _isLoading = false;
    notifyListeners();
  }

  insert(body) async {
    _isLoading = true;
    notifyListeners();
    var result = await OrderRepository().insert(body);
    if (result['meta']['success']) {
      _isLoading = false;
      notifyListeners();
      return result;
    } else {
      _isLoading = false;
      notifyListeners();
      return result;
    }
  }

  List<Order> _listOrder = [];

  List<Order> get listOrder => _listOrder;

  List<Order> _listCountOrder = [];

  List<Order> get listCountOrder => _listCountOrder;

  List<Order> _listSaleCountOrder = [];

  List<Order> get listSaleCountOrder => _listSaleCountOrder;

  int _countMenunggu = 0;
  int _countTerbayar = 0;
  int _countMenungguKonfirmasi = 0;
  int _countDikemas = 0;
  int _countDikirim = 0;
  int _countUlasan = 0;
  int _countSelesai = 0;
  int _countBatal = 0;

  int _countSaleMenungguKonfirmasi = 0;
  int _countSaleDikemas = 0;
  int _countSaleDikirim = 0;
  int _countSaleUlasan = 0;
  int _countSaleSelesai = 0;
  int _countSaleBatal = 0;

  int get countMenunggu => _countMenunggu;

  int get countMenungguKonfirmasi => _countMenungguKonfirmasi;

  int get countDikemas => _countDikemas;

  int get countDikirim => _countDikirim;

  int get countUlasan => _countUlasan;

  int get countSelesai => _countSelesai;

  int get countTerbayar => _countTerbayar;

  int get countBatal => _countBatal;

  int get countSaleMenungguKonfirmasi => _countSaleMenungguKonfirmasi;

  int get countSaleDikemas => _countSaleDikemas;

  int get countSaleDikirim => _countSaleDikirim;

  int get countSaleUlasan => _countSaleUlasan;

  int get countSaleSelesai => _countSaleSelesai;

  int get countSaleBatal => _countSaleBatal;

  setCountPembelian() {
    _countMenunggu = _listCountOrder.where((element) => element.statusPembayaran == 'menunggu').length;
    _countTerbayar = _listCountOrder.where((element) => element.statusPembayaran == 'terbayar').length;
    _countMenungguKonfirmasi = _listCountOrder.where((element) => element.statusOrder == 'menunggu konfirmasi').length;
    _countDikemas = _listCountOrder.where((element) => element.statusOrder == 'dikemas').length;
    _countDikirim = _listCountOrder.where((element) => element.statusOrder == 'dikirim').length;
    _countUlasan = _listCountOrder.where((element) => element.statusOrder == 'ulasan').length;
    _countSelesai = _listCountOrder.where((element) => element.statusOrder == 'selesai').length;
    _countBatal = _listCountOrder.where((element) => element.statusOrder == 'batal').length;
    notifyListeners();
  }

  setCountPenjualan() {
//    print(_countSaleMenungguKonfirmasi);
    _countSaleMenungguKonfirmasi = _listSaleCountOrder.where((element) => element.statusOrder == 'menunggu konfirmasi').length;
    _countSaleDikemas = _listSaleCountOrder.where((element) => element.statusOrder == 'dikemas').length;
    _countSaleDikirim = _listSaleCountOrder.where((element) => element.statusOrder == 'dikirim').length;
    _countSaleUlasan = _listSaleCountOrder.where((element) => element.statusOrder == 'ulasan').length;
    _countSaleSelesai = _listSaleCountOrder.where((element) => element.statusOrder == 'selesai').length;
    _countSaleBatal = _listSaleCountOrder.where((element) => element.statusOrder == 'batal').length;
    notifyListeners();
  }

  clearCountOrder() {
    _countMenunggu = 0;
    _countTerbayar = 0;
    _countMenungguKonfirmasi = 0;
    _countDikemas = 0;
    _countDikirim = 0;
    _countUlasan = 0;
    _countSelesai = 0;
    _countBatal = 0;
    _listCountOrder = [];
    notifyListeners();
  }

  getCountOrderByParam() async {
    _isLoading = true;
    notifyListeners();
    var param = {'id_pembeli': _id_user_login.toString()};
    var result = await OrderRepository().getOrderByParam(param);
    if (result.toString() == '111' || result.toString() == '101' || result.toString() == 'Conncetion Error') {
      _connection = false;
      _isLoading = false;
      _listCart = [];
      notifyListeners();
      return false;
    } else {
      if (result['meta']['success']) {
        _isLoading = false;
        Iterable list = result['data'];
        _listCountOrder = list.map((model) => Order.fromMap(model)).toList();
        setCountPembelian();
        notifyListeners();
        return true;
      } else {
        _listCountOrder = [];
        _isLoading = false;
        setCountPembelian();
        notifyListeners();
        return false;
      }
    }
  }

  getCountSaleByParam(param) async {
    imageCache.clear();
    _isLoading = true;
    notifyListeners();
    var result = await OrderRepository().getOrderByParam(param);
    if (result.toString() == '111' || result.toString() == '101' || result.toString() == 'Conncetion Error') {
      _connection = false;
      _isLoading = false;
      _listCart = [];
      notifyListeners();
      return false;
    } else {
      if (result['meta']['success']) {
        _isLoading = false;
        Iterable list = result['data'];
        _listSaleCountOrder = list.map((model) => Order.fromMap(model)).toList();
        setCountPenjualan();
        notifyListeners();
        return true;
      } else {
        _listSaleCountOrder = [];
        _isLoading = false;
        setCountPenjualan();
        notifyListeners();
        return false;
      }
    }
  }

  getOrderByParam(param) async {
    imageCache.clear();
    _isLoading = true;
    notifyListeners();
    var result = await OrderRepository().getOrderByParam(param);
    if (result['meta']['success']) {
      _isLoading = false;
      Iterable list = result['data'];
      _listOrder = list.map((model) => Order.fromMap(model)).toList();
      notifyListeners();
      return true;
    } else {
      _listOrder = [];
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  List<Order> _listOrderDetail = [];

  List<Order> get listOrderDetail => _listOrderDetail;

  Future<bool> getOrderTagihanByParam(param) async {
    imageCache.clear();
    _isLoading = true;
    notifyListeners();
    var result = await OrderRepository().getOrderByParam(param);
    if (result['meta']['success']) {
      _isLoading = false;
      Iterable list = result['data'];
      _listOrderDetail = list.map((model) => Order.fromMap(model)).toList();
      notifyListeners();
      return true;
    } else {
      _listOrderDetail = [];
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  List<OrderProduk> _listOrderDetailProduk = [];

  List<OrderProduk> get listOrderDetailProduk => _listOrderDetailProduk;

  getOrderProdukByParam(param) async {
    imageCache.clear();
    clearDetailOrderProduk();
    _isLoading = true;
    var order = await OrderRepository().getOrderProdukByParam(param);
    Iterable list = order['data'];
    _listOrderDetailProduk = list.map((model) => OrderProduk.fromMap(model)).toList();
    _isLoading = false;
    notifyListeners();
  }

  List<Ulasan> _listUlasan = [];

  List<Ulasan> get listUlasan => _listUlasan;

  clearDetailOrderProduk() {
    _listOrderDetail = [];
    notifyListeners();
  }

  getUlasanProduByParam(param) async {
    imageCache.clear();
    _isLoading = true;
    notifyListeners();
    var result = await OrderRepository().getUlasanProdukByParam(param);
//    print(result);
    if (result['meta']['success']) {
      _isLoading = false;
      Iterable list = result['data'];
      _listUlasan = list.map((model) => Ulasan.fromMap(model)).toList();
      notifyListeners();
      return true;
    } else {
      _listUlasan = [];
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateOrder(body) async {
    _isLoading = true;
    notifyListeners();
    var result = await OrderRepository().updateOrder(body);
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

  Future<bool> insertUlasan(body) async {
    _isLoading = true;
    var result = await OrderRepository().insertUlasan(body);
    _ulasan = null;
    if (result['meta']['success']) {
      return true;
    } else {
      return true;
    }
  }

  Future<bool> insertUlasanToko(body) async {
    _isLoading = true;
    var result = await OrderRepository().insertUlasanToko(body);
    _ulasan = '';
    if (result['meta']['success']) {
      return true;
    } else {
      return true;
    }
  }

  String _rating;
  String _ulasan;

  String get rating => _rating;

  String get ulasan => _ulasan;

  changeUlasan(value) {
    _ulasan = value;
  }

  changeRating(value) {
    _rating = value;
  }

  Future<dynamic> makePayment(body) async {
    _isLoading = true;
    notifyListeners();
    var result = await OrderRepository().makePayment(body);
    _isLoading = false;
    notifyListeners();
    return result;
  }

  Map<String, dynamic> _detailMidtransTransaksi = {};

  Map<String, dynamic> get detailMidtransTransaksi => _detailMidtransTransaksi;

  Future<dynamic> getTransaksiStatus(param) async {
    _isLoading = true;
    var result = await OrderRepository().getTransaksiStatus(param);
    print(result);
    _detailMidtransTransaksi = result;
    notifyListeners();
    _isLoading = false;
    return result;
  }
}
