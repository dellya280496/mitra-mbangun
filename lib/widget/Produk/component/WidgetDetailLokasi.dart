import 'package:apps/providers/DataProvider.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

class WidgetDetailLokasi extends StatelessWidget {
  const WidgetDetailLokasi({
    Key key,
    @required this.dataProvider,
  }) : super(key: key);

  final DataProvider dataProvider;

  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
      elevation: 2,
      colorCurve: Curves.easeInExpo,
      initiallyExpanded: true,
      leading: Icon(
        Icons.place,
        color: Colors.red,
      ),
      title: Text('Lokasi'),
      children: <Widget>[
        Divider(
          thickness: 1.0,
          height: 1.0,
        ),
        Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: dataProvider.getdataProdukById == null
                  ? Text('')
                  : Text(
                      '${dataProvider.getdataProdukById['data'][0]['produkalamat']} \n${dataProvider.getdataProdukById['data'][0]['nama_kabkota']}, ${dataProvider.getdataProdukById['data'][0]['nama_propinsi']}',
                    ),
            ))
      ],
    );
  }
}
