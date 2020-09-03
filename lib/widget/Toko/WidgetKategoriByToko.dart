import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/widget/Toko/component/WidgetGridKategoriByToko.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetKategoriByToko extends StatelessWidget {
  WidgetKategoriByToko({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BlocProduk blocProduk = Provider.of<BlocProduk>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Kategori',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        )),
                  ],
                ),
              ),
              InkWell(
                child: Text(
                  '',
                  style: TextStyle(fontSize: 12, color: Color(0xffb16a085)),
                ),
              ),
            ],
          ),
        ),
        WidgetGridKategoriByToko(blocProduk: blocProduk),
      ],
    );
  }
}
