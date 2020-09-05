import 'package:apps/providers/BlocAuth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sup/sup.dart';

class WidgetTunggu extends StatelessWidget {
  WidgetTunggu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Verifikasi Data'),
        actions: [
          IconButton(
            onPressed: () {
              blocAuth.handleSignOut();
            },
            icon: Icon(Icons.exit_to_app, color: Colors.grey[400], size: 20.0),
          ),
        ],
      ),
      body: Center(
        child: Sup(
          image: Image.asset('assets/img/verifcation.jpg'),
          title: Text('Data anda sedang di verifikasi') ,
          subtitle: Text(' Proses berlangsung sekitar 2-7 hari kerja.\n'
              'Anda akan dihubungi oleh M-Bangun melalui email untuk proses selanjutnya.'),
        ),
      ),
    );
  }
}
