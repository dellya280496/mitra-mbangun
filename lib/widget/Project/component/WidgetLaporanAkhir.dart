  import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocProyek.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';

import 'WidgetViewPdfPengajuan.dart';

class WidgetLaporanAkhir extends StatelessWidget {
  WidgetLaporanAkhir({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProyek blocProyek = Provider.of<BlocProyek>(context);
    return ExpansionTileCard(
      elevation: 2,
      colorCurve: Curves.ease,
      initiallyExpanded: true,
      leading: Icon(
        Icons.report,
        color: Colors.blue,
      ),
      title: Text('Laporan'),
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
              Text('Laporan akhir'),
              Container(
                height: 20,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ListTile(
                    title: InkWell(
                      onTap: () {
                        imageCache.clear();
                        var url = baseURL + pathUrl + 'assets/laporan_proyek/' + blocProyek.detailProyek[0].fileLaporanAkhir;
                        var title = 'Laporan';
                        Navigator.push(context, SlideRightRoute(page: WidgetViewPdfPengajuan(urlPdf: url, title: title)));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.attach_file,
                            color: Colors.blue,
                          ),
                          Text('Buka Laporan')
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