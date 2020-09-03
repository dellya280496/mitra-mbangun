import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/widget/ShippingAddress/WidgetAddAddress.dart';
import 'package:apps/widget/ShippingAddress/WidgetListAddress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShippingAddressScreen extends StatefulWidget {
  ShippingAddressScreen({Key key}) : super(key: key);

  @override
  _ShippingAddressScreenState createState() {
    return _ShippingAddressScreenState();
  }
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Daftar alamat'),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () {
              blocProfile.clearDataCity();
              Navigator.push(context, SlideRightRoute(page: WidgetAddAddress())).then((value) {
                blocProfile.getAllUserAddress(blocAuth.idUser);
              });
            },
          )
        ],
      ),
      body: WidgetListAddress(),
    );
  }
}
