import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetErrorConection extends StatelessWidget {
  const WidgetErrorConection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProduk blocProduk = Provider.of<BlocProduk>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    return Container(
      color: Colors.white,
      child: Center(
        child: InkWell(
            onTap: () {
              blocProduk.initLoad();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.network_check,
                  color: Colors.grey,
                  size: 50,
                ),
                Text('Tidak Ada Koneksi Internet'),
                Container(
                  height: 10,
                ),
                Container(
                  height: 35.0,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: FlatButton(
                    onPressed: () {
                      blocProduk.initLoad();
                    },
                    child: Text(
                      'Coba Lagi',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
