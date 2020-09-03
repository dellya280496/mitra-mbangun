import 'package:apps/providers/BlocOrder.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';

class WidgetLisCourier extends StatelessWidget {
  WidgetLisCourier({Key key}) : super(key: key);
  List _elements = [
    {'name': 'OKE', 'group': 'jne'},
    {'name': 'REG', 'group': 'jne'},
    {'name': 'OKE', 'group': 'jnt'},
    {'name': 'OKE', 'group': 'jnt'},
    {'name': 'OKE', 'group': 'wahana'},
    {'name': 'OKE', 'group': 'wahana'},
  ];
  final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Pilih jasa pengiriman'),
      ),
      body: blocOrder.listCost.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GroupedListView<dynamic, String>(
              padding: EdgeInsets.all(8),
              groupBy: (element) => element['code'],
              elements: blocOrder.listCost,
              order: GroupedListOrder.DESC,
              useStickyGroupSeparators: true,
              groupSeparatorBuilder: (String value) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  value.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
            ),
        itemBuilder: (c, element) {
          return Card(
            elevation: 1.0,
            child: ListTile(
              onTap: () {
                var body = {
                  'kode_kurir': element['code'],
                  'nama_kurir': element['name'],
                  'estimasi_pengiriman': element['etd'],
                  'total_ongkir': element['cost'],
                  'jenis_service': element['service']
                };
                blocOrder.onChangeCost(body);
                Navigator.pop(context);
              },
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              leading: Icon(
                Icons.directions_car,
                size: 30,
              ),
              title: Text(
                element['service'],
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(Money.fromInt(int.parse(element['cost'].toString()), IDR).toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                  Text('Estimasi ' + element['etd'], style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black)),
                ],
              ),
              trailing: Icon(
                Icons.arrow_forward,
                size: 20,
                color: Colors.cyan[700],
              ),
            ),
          );
        },
      ),
    );
  }
}
