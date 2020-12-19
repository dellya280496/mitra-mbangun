import 'package:apps/Utils/BottomAnimation.dart';
import 'package:apps/screen/LoginScreen.dart';
import 'package:apps/screen/ProfileScreen.dart';
import 'package:apps/screen/RequestScreen.dart';
import 'package:apps/widget/Aktivity/Pengajuan/WidgetPengajuanByParamList.dart';
import 'package:flutter/cupertino.dart';

final Map<String, WidgetBuilder> routes = {
  '/login': (context) => LoginScreen(),
  '/request': (context) => RequestScreen(),
  '/profile': (context) => ProfileScreen(),
  '/BottomNavBar': (context) => BottomAnimateBar(),
  '/New': (context) => WidgetPengajuanByParamList(),
};
