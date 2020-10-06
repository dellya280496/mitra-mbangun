import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/providers/BlocProyek.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/screen/ProfileWorkerScreen.dart';
import 'package:apps/widget/Helper/WidgetFotoCircular.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class WidgetListPekerja extends StatefulWidget {
  const WidgetListPekerja({Key key, this.param}) : super(key: key);
  final param;

  @override
  _WidgetListPekerjaState createState() => _WidgetListPekerjaState();
}

class _WidgetListPekerjaState extends State<WidgetListPekerja> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    BlocProyek blocProyek = Provider.of<BlocProyek>(context);
    final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
    return ExpansionTileCard(
      elevation: 2,
      colorCurve: Curves.ease,
      initiallyExpanded: true,
      leading: Icon(
        Icons.group_work,
        color: Colors.orange,
      ),
      title: Text('Daftar Pekerja'),
      children: <Widget>[
        Divider(
          thickness: 1.0,
          height: 1.0,
        ),
        blocProyek.listPekerja.isEmpty ? Container( height:50,child: Center(child: Text('Belum ada mitra yang bid nih!'),)): Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: ListView.builder(
                    itemCount: blocProyek.listPekerja.length,
                    itemBuilder: (context, index) {
                      var jenisMitra = blocProyek.listPekerja[index].jenisMitra;
                      print(blocProyek.listPekerja[index].status);
                      return Column(
                        children: [
                          ListTile(
                            leading: WidgetFotoCircular(
                              userFoto: blocProyek.listPekerja[index].fotoMitra,
                            ),
                            title: Text(blocProyek.listPekerja[index].namaMitra + ' (' + blocProyek.listPekerja[index].waktuPengerjaan + ' Hari' + ')'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(blocProyek.listPekerja[index].deskripsi),
//                                Text(blocProyek.listPekerja[index].bidwaktupengerjaan + ' Hari'),
                                Text(
                                  jenisMitra.toString().toUpperCase(),
                                  style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.grey),
                                ),
                              ],
                            ),
                            trailing: blocProyek.listPekerja[index].status == '1'
                                ? Icon(
                                    Icons.done_all,
                                    color: Colors.green,
                                  )
                                : Icon(
                                    Icons.done_all,
                                    color: Colors.grey[300],
                                  ),
                          ),
                          Divider()
                        ],
                      );
                    }),
              ),
            ],
          ),
        )
      ],
    );
  }

  void _showDialog(param) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    BlocProyek blocProyek = Provider.of<BlocProyek>(context);
    if (!blocAuth.isLogin) {
      Flushbar(
        title: "Error",
        message: "Silahkan login / daftar member",
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        flushbarPosition: FlushbarPosition.BOTTOM,
        icon: Icon(
          Icons.assignment_turned_in,
          color: Colors.white,
        ),
      )..show(context);
    } else {
      Future<void> future = showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Form(
            key: _formKey,
            autovalidate: false,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              padding: EdgeInsets.only(top: 10, left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Apakah Anda Yakin?',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.clear))
                      ],
                    ),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Pilih Sebagai pekerja?'),
                        Container(
                          child: Container(
                            height: 40.0,
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: FlatButton(
                              height: 30,
                              onPressed: () {
//                                blocProfile.getMitraByParam({'id': param.idMitra.toString()});
//                                blocProfile.getJenisLayananByParam({'id_mitra': param.idMitra.toString()});
//                                blocProyek.getBidsByParam({'id_mitra': param.idMitra.toString(), 'status_proyek': 'selesai'});
//                                Navigator.push(context, SlideRightRoute(page: ProfileWorkerScreen())).then((value) {
//                                  blocProyek.getBidsByParam({"id_projek": param.idProjek.toString(), 'id_user': param.idUser.toString()});
//                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.perm_contact_calendar,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  Text(
                                    'Profile',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RoundedLoadingButton(
                      height: 40,
                      child: Text('Setuju', style: TextStyle(color: Colors.white)),
                      color: Colors.green,
                      controller: _btnController,
                      onPressed: () => updateBidToKontrak(param),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
      future.then((value) {
//        blocProyek.getProjectByOrder({
//          'no_order': blocProyek.listProjectDetail[0].noOrder.toString(),
//        });
      });
    }
  }

  updateBidToKontrak(param) async {
    BlocProyek blocProyek = Provider.of<BlocProyek>(context);
    var map = new Map<String, dynamic>();
    map['id_user'] = param.idUser;
    map['id'] = param.id;
//    var result = blocProyek.updateSelectedBid(map);
//    result.then((value) async {
//      if (value) {
//        _btnController.success();
//        await new Future.delayed(const Duration(seconds: 2));
//        Navigator.pop(context);
//      } else {
//        _btnController.error();
//        await new Future.delayed(const Duration(seconds: 2));
//        Navigator.pop(context);
//      }
//    });
  }
}
