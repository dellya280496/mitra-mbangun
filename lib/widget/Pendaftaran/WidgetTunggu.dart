import 'package:flutter/material.dart';
import 'package:sup/sup.dart';

class WidgetTunggu extends StatelessWidget {
  WidgetTunggu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Sup(
        image: Image.asset('assets/img/verifcation.jpg'),
        title: Text('Data anda sedang di verifikasi') ,
        subtitle: Text(' Proses berlangsung sekitar 2-7 hari kerja.\n'
            'Anda akan dihubungi oleh M-Bangun melalui email untuk proses selanjutnya.'),
      ),
    );
  }
}
