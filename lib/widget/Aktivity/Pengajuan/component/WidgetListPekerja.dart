import 'package:apps/Utils/navigation_right.dart';
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
    DataProvider dataProvider = Provider.of<DataProvider>(context);
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
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(dataProvider.listBidding.length == 0 ? 'Belum ada yang memilih pekerjaan anda' : 'Silahkan pilih pekerja salah satu rekomendasi dari kami'),
              dataProvider.listBidding.length == 0
                  ? Container()
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      child: ListView.builder(
                          itemCount: dataProvider.listBidding.length,
                          itemBuilder: (context, index) {
                            var harga = dataProvider.listBidding[index].bidprice;
                            var hargaFormat = Money.fromInt(harga == null ? 0 : int.parse(harga), IDR);
                            print(dataProvider.listBidding[index].statusnama);
                            return InkWell(
                              onTap: () {
                                if (widget.param == 'Negosiasi') {
                                  _showDialog(dataProvider.listBidding[index]);
                                }
                              },
                              child: Column(
                                children: [
                                  ListTile(
                                      leading: WidgetFotoCircular(
                                        dataProvider: dataProvider,
                                        userFoto: dataProvider.listBidding[index].userfoto,
                                      ),
                                      title: Text(dataProvider.listBidding[index].userbidnama + ' (' + dataProvider.listBidding[index].bidwaktupengerjaan + ' Hari' + ')'),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(dataProvider.listBidding[index].biddeskripsi),
//                                Text(dataProvider.listBidding[index].bidwaktupengerjaan + ' Hari'),
                                          Text(
                                            hargaFormat.toString(),
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      trailing: dataProvider.listBidding[index].statusnama == 'Kontrak' || dataProvider.listBidding[index].statusnama == 'Progress'
                                          ? Icon(
                                              Icons.done_all,
                                              color: Colors.green,
                                            )
                                          : Icon(
                                              Icons.done_all,
                                              color: Colors.grey[300],
                                            )),
                                  Divider()
                                ],
                              ),
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
    if (dataProvider.userId_ == null) {
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
      showModalBottomSheet(
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
                              onPressed: () {
                                dataProvider.getProfileWorker(param.userid);
                                Navigator.push(context, SlideRightRoute(page: ProfileWorkerScreen())).then((value) {
                                  dataProvider.getProfile();
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(Icons.perm_contact_calendar, color: Colors.white,),
                                  Text(
                                    'Profile',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    RoundedLoadingButton(
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
    }
  }

  updateBidToKontrak(param) async {
    var map = new Map<String, dynamic>();
    map['userid'] = param.userid;
    map['produkid'] = param.produkid;
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    dataProvider.updateToKontrak(map);
    if (dataProvider.isLoading) {
      _btnController.success();
    } else {
      _btnController.error();
    }
//    dataProvider.getBiddingByProdukId(param.produkid);
//    await new Future.delayed(const Duration(seconds: 1));
    Navigator.pop(context);
  }
}
