import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';

class WidgetDetailLokasi extends StatelessWidget {
  final alamatLengkap;

  const WidgetDetailLokasi({
    Key key,
    @required this.alamatLengkap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    var provinsi = blocProfile.listProvice.isNotEmpty ? blocProfile.listProvice[0].rajaongkir.results[0].province : '';
    var kota = blocProfile.listCity.isNotEmpty ? blocProfile.listCity[0].rajaongkir.results[0].cityName : '';
    var kecamatan = blocProfile.listSubDistrict.isNotEmpty ? blocProfile.listSubDistrict[0].rajaongkir.results[0].subdistrictName : '';
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
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Text(
                alamatLengkap + '\n$kecamatan\n$kota\n$provinsi',
              ),
            )),
        FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            color: Colors.orange[600],
            minWidth: MediaQuery.of(context).size.width * 0.85,
            onPressed: () {
          MapsLauncher.launchQuery(
              alamatLengkap);
          }, child: Text('Buka Maps', style: TextStyle(color: Colors.white),))
      ],
    );
  }
}
