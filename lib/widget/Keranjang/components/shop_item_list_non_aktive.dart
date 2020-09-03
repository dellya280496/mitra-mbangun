import 'package:apps/models/Cart.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:flutter/material.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';

const List<BoxShadow> shadow = [BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)];

class ShopItemListNonAtif extends StatefulWidget {
  final Function onRemove;
  final int index;
  ChilrdernBean chilrdern;

  ShopItemListNonAtif({Key key, this.onRemove, this.index, this.chilrdern}) : super(key: key);

  @override
  _ShopItemListNonAtifState createState() => _ShopItemListNonAtifState();
}

class _ShopItemListNonAtifState extends State<ShopItemListNonAtif> {
  int quantity = 1;
  final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
  var oldValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocOrder blocOrder = Provider.of(context);
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 0, left: 5, right: 5),
        child: Container(
          color: Colors.white38,
          child: Column(
            children: [
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 0),
                          child: Image.network(
                            'https://m-bangun.com/api-v2/assets/toko/' + widget.chilrdern.foto,
                            width: 80,
                            height: 80,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        widget.chilrdern.jenisOngkir == 'include_dalam_kota'
                            ? Text(
                                'Free ongkir \ndalam kota',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 10, color: Colors.grey),
                              )
                            : widget.chilrdern.jenisOngkir == 'include' ? Text('Free ongkir') : Text('')
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          margin: EdgeInsets.only(top: 0),
                          child: Text(
                            'Produk ' + widget.chilrdern.nama + ' tidak tersedia',
                            maxLines: 2,
                            style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    Container(
                        child: InkWell(
                            onTap: () {
                              widget.onRemove();
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            )))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
