import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/widget/ShippingAddress/WidgetUpdateAddress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetListAddress extends StatelessWidget {
  WidgetListAddress({Key key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    return SingleChildScrollView(
      child: blocProfile.isLoading
          ? Container(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  padding: EdgeInsets.only(left: 5, right: 5, top: 10),
                  itemCount: blocProfile.listUserAddress.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: InkWell(
                        onTap: () {
                          print('dsad');
                          var body = {"id": blocProfile.listUserAddress[index].id.toString(), "id_user": blocAuth.idUser.toString()};
                          var result = blocProfile.setDefaultAlamat(body);
                          result.then((value) async {
                            if (value) {
                              blocProfile.getAllUserAddress(blocAuth.idUser);
                              blocProfile.getUserAddressDefault(blocAuth.idUser);
                            } else {}
                          });
                        },
                        child: ListTile(
                          enabled: blocProfile.listUserAddress[index].defaultAlamat == '1' ? true : false,
                          title: Row(
                            children: [
                              Text('#' + blocProfile.listUserAddress[index].namaAlamat),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                '(' + blocProfile.listUserAddress[index].namaPenerima + ')  ',
                                style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                              ),
                              blocProfile.listUserAddress[index].defaultAlamat == '1'
                                  ? Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.green),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'default',
                                          style: TextStyle(fontSize: 12, color: Colors.white),
                                        ),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: RichText(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  text: TextSpan(style: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.normal), text: blocProfile.listUserAddress[index].alamatLengkap),
                                ),
                              ),
                            ],
                          ),
                          selected: blocProfile.listUserAddress[index].defaultAlamat == '1' ? true : false,
                          trailing: PopupMenuButton(
                            elevation: 3.2,
                            itemBuilder: (BuildContext context) {
                              return [
                                PopupMenuItem(
                                  child: InkWell(
                                    child: Text("Jadikan alamat utama"),
                                    onTap: () {
                                      Navigator.pop(context, "Replay Game");
                                      var body = {"id": blocProfile.listUserAddress[index].id.toString(), "id_user": blocAuth.idUser.toString()};
                                      var result = blocProfile.setDefaultAlamat(body);
                                      result.then((value) async {
                                        if (value) {
                                          blocProfile.getAllUserAddress(blocAuth.idUser);
                                          blocProfile.getUserAddressDefault(blocAuth.idUser);
                                        } else {}
                                      });
                                    },
                                  ),
                                ),
                                PopupMenuItem(
                                  value: "Replay Game",
                                  child: InkWell(
                                    child: Container(width: MediaQuery.of(context).size.width * 0.5, child: Text("Ubah")),
                                    onTap: () {
                                      Navigator.pop(context, "Replay Game");
                                      blocProfile.clearDataCity();
                                      blocProfile.clearDetailAddress();
                                      blocProfile.getUserAddressById(blocProfile.listUserAddress[index].id);
                                      blocProfile.getSubDistrictById(blocProfile.listUserAddress[index].idKecamatan);
                                      Navigator.push(context, SlideRightRoute(page: WidgetUpdateAddress(id: blocProfile.listUserAddress[index].id))).then((value) {
                                        blocProfile.getAllUserAddress(blocAuth.idUser);
                                        blocProfile.clearDataCity();
                                      });
                                    },
                                  ),
                                ),
                                PopupMenuItem(
                                  value: "Replay Game",
                                  child: InkWell(
                                    child: Container(width: MediaQuery.of(context).size.width * 0.5, child: Text("Hapus")),
                                    onTap: () {
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
    );
  }

  void _showToast(String message, context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(message),
      ),
    );
  }

}
