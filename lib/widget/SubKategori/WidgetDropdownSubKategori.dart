import 'package:apps/providers/DataProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetDropdownSubKategori extends StatelessWidget {
  WidgetDropdownSubKategori({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width - 10,
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffb16a085),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffb16a085),
                ),
              ),
            ),
            isDense: true,
            validator: (String arg) {
              if (arg == null)
                return 'jenis pekerjaan harus di isi';
              else
                return null;
            },
            hint: new Text(
              "Jenis pekerjaan",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            value: dataProvider.getSelectedSubKategori,
            onChanged: (String newValue) {
              dataProvider.setSelectedSubKategori(newValue);
            },
            items: dataProvider.getDataSubKategori.map((item) {
              return DropdownMenuItem<String>(
                value: item.produkkategorisubid.toString(),
                child: new Text(
                  item.produkkategorisubnama.toString(),
                  style: TextStyle(fontSize: 12),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
