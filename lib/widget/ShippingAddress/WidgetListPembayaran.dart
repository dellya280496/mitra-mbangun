import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';

class WidgetListPembayaran extends StatelessWidget {
  WidgetListPembayaran({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Pembayaran'),
      ),
      body: GroupedListView<dynamic, String>(
        groupBy: (element) => element['nama'],
        elements: blocOrder.listMetodePembayaran,
        order: GroupedListOrder.DESC,
        useStickyGroupSeparators: true,
        groupSeparatorBuilder: (String value) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        itemBuilder: (c, element) {
          print(element['kode']);
          return InkWell(
            onTap: () {
              var body = {
                'metode_pembayaran': element['nama'],
                'payment_type': element['tipe_pembayaran'],
                'no_rekening': element['no_rekening'],
                'nama_rekening': element['atas_nama'],
                'nama_bank': element['nama_bank'],
                'kode': element['kode']
              };
              blocOrder.onChangeMetodePembayaran(body);
              Navigator.pop(context);
            },
            child: Card(
              elevation: 8.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                padding: EdgeInsets.all(2),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Image.network(
                    baseURL+ '/api-v2/assets/bank/' + "${element['icon']}",
                    height: 50,
                    width: 50,
                  ),
                  title: Text(
                    element['nama_bank'],
                    style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 16),
                  ),
                  subtitle: Text(element['deskripsi_bank'], style: TextStyle()),
                  trailing: Icon(
                    Icons.arrow_forward,
                    size: 20,
                    color: Colors.cyan[700],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
