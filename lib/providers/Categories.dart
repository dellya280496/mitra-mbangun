import 'package:apps/models/Categories.dart';
import 'package:flutter/material.dart';

class BlogCategories extends ChangeNotifier {
  BlogCategories() {}

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<Categories> _dataKategoriHome = [];

  List<Categories> get dataKategoriHome => _dataKategoriHome;
}
