import 'package:apps/providers/DataProvider.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';

class WidgetDeskripsiProduk extends StatelessWidget {
  final String harga, created, lokasi, kategori, subKategori;

  const WidgetDeskripsiProduk({Key key, this.harga, this.kategori, this.created, this.lokasi, this.subKategori}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    var data = dataProvider.getdataProdukById;
    final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
    var harga = data['data'][0]['produkharga'];
    var hargaFormat = Money.fromInt(harga == null ? 0 : int.parse(harga), IDR);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(19.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                data == null
                    ? Text('')
                    : Text(
                        dataProvider.getdataProdukById['data'][0]['produknama'],
                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    data == null
                        ? Text('')
                        : Text(
                      hargaFormat.toString(),
                            style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                    Spacer(),
                    Icon(
                      Icons.label,
                      color: Colors.green,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    data == null
                        ? Text('')
                        : Text(
                            Jiffy(dataProvider.getdataProdukById['data'][0]['produkcreate']).fromNow(),
                            style: TextStyle(color: Colors.grey),
                          ),
                    Spacer(),
                    Icon(
                      Icons.access_time,
                      color: Colors.orange,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    data == null ? Text('') : Text('${dataProvider.getdataProdukById['data'][0]['produkkategorisubnama']}'),
                    Spacer(),
                    Icon(
                      Icons.business,
                      color: Colors.red,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    data == null ? Text('') : Text('${dataProvider.getdataProdukById['data'][0]['produkwaktupengerjaan']}'),
                    Spacer(),
                    Icon(
                      Icons.date_range,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
