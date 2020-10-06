import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/Utils/Signature.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocProyek.dart';
import 'package:apps/widget/Aktivity/Pengajuan/component/WidgetViewPdfPengajuan.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';

class WidgetKontrak extends StatelessWidget {
  const WidgetKontrak({Key key, this.param}) : super(key: key);
  final String param;

  @override
  Widget build(BuildContext context) {
    BlocProyek blocProyek = Provider.of<BlocProyek>(context);
    return ExpansionTileCard(
      elevation: 2,
      colorCurve: Curves.ease,
      initiallyExpanded: true,
      leading: Icon(
        Icons.mode_edit,
        color: Colors.red,
      ),
      title: Text('Tanda tangan Kontrak'),
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
              blocProyek.detailProyek[0].status == 'selesai' ? Text('Kontrak kerja') : Text('Silahkan dibaca kontrak kerja dengan jelas, jika sudah memahami silahkan tanda tangan atau batal untuk membatalkan project'),
              Container(
                height: 20,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ListTile(
                    title: SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        child: Text("Tanda Tangan"),
                        color: blocProyek.detailProyek[0].status == 'selesai' ? Colors.grey : Color(0xffb16a085),
                        textColor: Colors.white,
                        padding: EdgeInsets.only(left: 11, right: 11, top: 15, bottom: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        onPressed: () {
                          blocProyek.detailProyek[0].status == 'selesai' ? null : Navigator.push(
                              context,
                              PageRouteTransition(
                                animationType: AnimationType.slide_up,
                                builder: (context) => WidgetSignature(
                                  idProjek: blocProyek.detailProyek[0].id,
                                  signature: this.param,
                                ),
                              ));
                        },
                      ),
                    ),
                    leading: InkWell(
                      onTap: () {
                        imageCache.clear();
                        var url = baseURLMobile + '/kontrak?id=' + blocProyek.detailProyek[0].id;
                        print(url);
                        var title = 'Kontrak';
                        Navigator.push(context, SlideRightRoute(page: WidgetViewPdfPengajuan(urlPdf: url, title: title)));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.attach_file,
                            color: Colors.blue,
                          ),
                          Text('Buka')
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        )
      ],
    );
  }
}
