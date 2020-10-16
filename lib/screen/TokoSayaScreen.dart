import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/Utils/values/colors.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/widget/Toko/component/WidgetAddProduk.dart';
import 'package:apps/widget/Toko/component/WidgetUpdateProduk.dart';
import 'package:apps/widget/Toko/component/WidgetUpdateToko.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';

class TokoSayaScreen extends StatelessWidget {
  TokoSayaScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    BlocProduk blocProduk = Provider.of<BlocProduk>(context);
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    double width = MediaQuery.of(context).size.width;
    AppBar appBar = AppBar(
//      backgroundColor: Colors.cyan[700],
      elevation: 0,
//      iconTheme: IconThemeData(color: Colors.white),
      title: Text(
        'Kelola Toko',
        style: TextStyle(color: Colors.black),
      ),
    );
    var appBarHeigh = appBar.preferredSize.height;
    return Scaffold(
      appBar: appBar,
      body: ModalProgressHUD(
        inAsyncCall: blocProduk.isLoading,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(0.0),
                      bottomLeft: Radius.circular(0.0),
                    )),
                height: (MediaQuery.of(context).size.height - appBarHeigh) * 0.15,
                width: width,
                child: ListTile(
                  title: Container(
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      strutStyle: StrutStyle(fontSize: 14.0),
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        text: blocProfile.dataToko['nama_toko'],
                      ),
                    ),
                  ),
                  leading: Container(
                    width: 60.0,
                    height: 60.0,
                    child: ClipOval(
                      child: Image.network(baseURL+ '/'+ pathUrl +'/assets/toko/' + blocProfile.dataToko['foto'].toString(), fit: BoxFit.contain,
//                            width: 30,
                          errorBuilder: (context, urlImage, error) {
                        print(error.hashCode);
                        return Image.asset('assets/logo.png');
                      }),
                    ),
                  ),
                  subtitle: Text(
                    blocProfile.dataToko.isEmpty ? '' : blocProfile.dataToko['jenis_toko'],
                    style: TextStyle(color: Colors.grey),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      blocProfile.getTokoByParam({'id_user': blocAuth.idUser.toString()});
                      blocProfile.clearDataCity();
                      if (blocProfile.dataToko.isNotEmpty) {
                        blocProfile.getSubDistrictById(blocProfile.dataToko['id_kecamatan']);
                        Navigator.push(context, SlideRightRoute(page: WidgetUpdateToko())).then((value) {
                          blocProfile.getTokoByParam({'id_user': blocAuth.idUser.toString()});
                        });
                      }
                    },
                  ),
                ),
              ),
              blocAuth.statusToko == '0'
                  ? Container()
                  : Container(
                      color: Colors.white,
                      height: (MediaQuery.of(context).size.height - appBarHeigh) * 0.85 - MediaQuery.of(context).padding.top,
                      child: SingleChildScrollView(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            onRefresh(context);
                          },
                          child: Column(
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        subheading('Produk Saya'),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(context, SlideRightRoute(page: WidgetAddProduk())).then((value) {
                                              blocProduk.getAllProductByParam({'id_toko': blocAuth.idToko.toString()});
                                            });
                                          },
                                          child: CircleAvatar(
                                            radius: 25.0,
                                            backgroundColor: Colors.white,
                                            child: Icon(
                                              Icons.add_circle,
                                              size: 40.0,
                                              color: Colors.cyan,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: (MediaQuery.of(context).size.height - appBarHeigh) * 0.8 - MediaQuery.of(context).padding.top - 40,
                                    child: ListView.builder(
                                        padding: EdgeInsets.only(left: 5, right: 5, top: 10),
                                        itemCount: blocProduk.listProducts.length,
                                        itemBuilder: (context, index) {
                                          return Card(
                                            color: blocProduk.listProducts[index].aktif == '0' ? Colors.grey[200] : Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: ListTile(
                                                // ignore: unrelated_type_equality_checks
                                                enabled: blocProduk.listProducts[index].aktif == '0' ? false : true,
                                                leading: Image.network(
                                                  baseURL+ '/'+ pathUrl +'/assets/toko/' + blocProduk.listProducts[index].foto,
                                                  width: 70,
                                                  height: 70,
                                                  errorBuilder: (context, urlImage, error) {
                                                    print(error.hashCode);
                                                    return Image.asset(
                                                      'assets/logo.png',
                                                      width: 40,
                                                      height: 40,
                                                    );
                                                  },
                                                ),
                                                title: Text(
                                                  blocProduk.listProducts[index].nama,
                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                ),
                                                subtitle: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          Money.fromInt(int.parse(blocProduk.listProducts[index].harga.toString()), IDR).toString(),
                                                          style: TextStyle(fontSize: 14, color: Colors.redAccent),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      'Stok : ' + blocProduk.listProducts[index].stok,
                                                      style: TextStyle(fontSize: 13),
                                                    ),
                                                    Text(
                                                      'Terjual : ' + blocProduk.listProducts[index].jumlahDibeli,
                                                      style: TextStyle(fontSize: 13),
                                                    ),
                                                    Text(
                                                      'Dilihat : ' + blocProduk.listProducts[index].jumlahDilihat,
                                                      style: TextStyle(fontSize: 13),
                                                    ),
                                                  ],
                                                ),
                                                trailing: PopupMenuButton(
                                                  elevation: 3.2,
                                                  itemBuilder: (BuildContext context) {
                                                    var aktif = blocProduk.listProducts[index].aktif;
                                                    return [
                                                      PopupMenuItem(
                                                        height: 0,
                                                        value: "Replay Game",
                                                        child: InkWell(
                                                          child: Container(
                                                              padding: EdgeInsets.symmetric(vertical: 12),
                                                              width: MediaQuery.of(context).size.width * 0.3,
                                                              child: Text(
                                                                "Ubah",
                                                                style: TextStyle(fontSize: 14),
                                                              )),
                                                          onTap: () {
                                                            Navigator.pop(context, "Replay Game");
                                                            var param = {'id': blocProduk.listProducts[index].id};
                                                            blocProduk.getDetailProductByParam(param);
                                                            blocProduk.clearDetailProduk();
                                                            Navigator.push(context, SlideRightRoute(page: WidgetUpdateProduk())).then((value) {
                                                              blocProduk.getAllProductByParam({'id_toko': blocAuth.idToko.toString()});
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      PopupMenuItem(
                                                        height: 0,
                                                        value: "Replay Game",
                                                        child: InkWell(
                                                          child: Container(
                                                              height: 40,
                                                              padding: EdgeInsets.symmetric(vertical: 12),
                                                              width: MediaQuery.of(context).size.width * 0.3,
                                                              child: Text(
                                                                aktif == '1' ? "Non Aktifkan" : 'Aktifkan',
                                                                style: TextStyle(fontSize: 14),
                                                              )),
                                                          onTap: () async {
                                                            var body = {'id': blocProduk.listProducts[index].id, 'aktif': aktif == '1' ? '0' : '1'};
                                                            var result = await blocProduk.updateStatus(body);
                                                            if (result) {
                                                              onRefresh(context);
                                                            } else {
                                                              onRefresh(context);
                                                            }
                                                            Navigator.pop(context, "Replay Game");
                                                          },
                                                        ),
                                                      ),
                                                    ];
                                                  },
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(color: AppColors.kDarkBlue, fontSize: 20.0, fontWeight: FontWeight.w700, letterSpacing: 1.2),
    );
  }

  void onRefresh(BuildContext context) {
    BlocProduk blocProduk = Provider.of<BlocProduk>(context);
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    blocProfile.getTokoByParam({'id_user': blocAuth.idUser.toString()});
    blocProduk.getAllProductByParam({'id_toko': blocAuth.idToko.toString()});
  }
}
