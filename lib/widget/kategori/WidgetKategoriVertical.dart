import 'dart:convert';

import 'package:apps/Api/Api.dart';
import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/models/KategoriM.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/screen/LoginScreen.dart';
import 'package:apps/screen/SubKategoriScreen.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';

class WidgetKategoriVertical extends StatefulWidget {
  WidgetKategoriVertical({Key key}) : super(key: key);

  @override
  _WidgetKategoriVerticalState createState() {
    return _WidgetKategoriVerticalState();
  }
}

class _WidgetKategoriVerticalState extends State<WidgetKategoriVertical> {
  var dataKategori = new List<KategoriM>();

  @override
  void initState() {
    super.initState();
    _getToken();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getToken() async {
    Api.getToken().then((value) {
      var data = json.decode(value.body);
      LocalStorage.sharedInstance.writeValue(key: 'token', value: data['data']['token']);
      _getKategori();
    }).catchError((onError) {
      print(onError);
    });
  }

  void _getKategori() async {
    String tokenValid = await LocalStorage.sharedInstance.readValue('token');
    Api.getAllKategori(tokenValid).then((response) {
      Iterable list = json.decode(response.body)['data'];
      setState(() {
        dataKategori = list.map((model) => KategoriM.fromMap(model)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return dataKategori.isEmpty
        ? SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: PKCardPageSkeleton(
                totalLines: 4,
              ),
            ),
          )
        : Container(
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                padding: EdgeInsets.only(left: 5, right: 5, top: 10),
                itemCount: dataKategori.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: InkWell(
                      onTap: () => openSubkategori(dataKategori[index]),
                      child: Container(
                        width: 100,
                        padding: EdgeInsets.all(8),
                        child: ListTile(
                          leading: Image.network(
                            dataKategori[index].kategoriThumbnail,
                            width: 45,
                          ),
                          title: Text(dataKategori[index].kategoriNama),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          );
  }

  void openSubkategori(param) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    print(param.produkkategorinama == 'Bahan Bangunan');
    if (param.produkkategorinama == 'Bahan Bangunan') {
      Navigator.push(
          context,
          SlideRightRoute(
              page: SubKategoriScreen(
            namaKategori: param.produkkategorinama,
          )));
    } else {
      print(dataProvider.isLogin);
      if (dataProvider.isLogin) {
        if (dataProvider.userKategori == param.produkkategorinama) {
          Navigator.push(
              context,
              SlideRightRoute(
                  page: SubKategoriScreen(
                namaKategori: param.produkkategorinama,
              )));
        } else {
          Flushbar(
            title: "Error",
            message: "Silahkan login / member anda tidak sesuai",
            duration: Duration(seconds: 5),
            backgroundColor: Colors.red,
            flushbarPosition: FlushbarPosition.BOTTOM,
            icon: Icon(
              Icons.assignment_turned_in,
              color: Colors.white,
            ),
          )..show(context);
        }
      } else {
        Navigator.push(context, SlideRightRoute(page: LoginScreen()));
      }
    }
  }
}
