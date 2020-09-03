import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/models/Cart.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/widget/ShippingAddress/WidgetListCourier.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money2/money2.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CardRajaOngkir extends StatefulWidget {
  const CardRajaOngkir({
    Key key,
    @required this.blocOrder,
    @required this.IDR,
    @required RoundedLoadingButtonController btnController,
    @required this.blocProfile,
    @required this.blocAuth,
    @required this.listCart,
  })  : _btnController = btnController,
        super(key: key);

  final BlocOrder blocOrder;
  final Currency IDR;
  final RoundedLoadingButtonController _btnController;
  final BlocProfile blocProfile;
  final BlocAuth blocAuth;
  final Cart listCart;

  @override
  _CardRajaOngkirState createState() => _CardRajaOngkirState();
}

class _CardRajaOngkirState extends State<CardRajaOngkir> {
  @override
  void didUpdateWidget(CardRajaOngkir oldWidget) {
    // TODO: implement didUpdateWidget
//    Provider.of<BlocProfile>(context).getUserAddressDefault(widget.blocAuth.idUser);
//    Provider.of<BlocProfile>(context).getSubDistrictById(widget.listCart.chilrdern[0].idKecamatan);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.blocOrder.listCostSelected.isEmpty ? Colors.red.withOpacity(0.2) : Colors.white,
      margin: const EdgeInsets.only(top: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Jasa Pengiriman'),
              Container(
                margin: EdgeInsets.only(top: 2),
                child: Text(
                  ' (Kurir)',
                  style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic, fontSize: 13),
                ),
              )
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.blocOrder.listCostSelected.isEmpty
                    ? '-'
                    : widget.blocOrder.listCostSelected['kode_kurir'].toString().toUpperCase() + ' ' + ' estimasi ' + widget.blocOrder.listCostSelected['estimasi_pengiriman'],
              ),
              Text(widget.blocOrder.listCostSelected.isEmpty ? '' : '#' + widget.blocOrder.listCostSelected['jenis_service'].toString()),
              Text(widget.blocOrder.listCostSelected.isEmpty ? '' : Money.fromInt(int.parse(widget.blocOrder.listCostSelected['total_ongkir'].toString()), widget.IDR).toString(),
                  style: TextStyle(color: Colors.redAccent)),
            ],
          ),
          leading: Icon(FontAwesomeIcons.carAlt),
          trailing: Container(
            height: 30,
            width: 80,
            child: new Row(
              children: <Widget>[
                new Expanded(
                    child: RoundedLoadingButton(
                  child: Text('Ubah', style: TextStyle(color: Colors.white, fontSize: 12)),
                  color: Colors.cyan[700],
                  controller: widget._btnController,
                  onPressed: () {
                    widget.blocProfile.getAllUserAddress(widget.blocAuth.idUser);
                    Navigator.push(context, SlideRightRoute(page: WidgetLisCourier())).then((value) {
//                      Provider.of<BlocProfile>(context).getUserAddressDefault(widget.blocAuth.idUser);
//                      Provider.of<BlocProfile>(context).getSubDistrictById(widget.listCart.chilrdern[0].idKecamatan);
                    });
                    widget._btnController.reset();
                  },
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
