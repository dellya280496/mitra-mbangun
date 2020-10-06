import 'package:apps/providers/BlocAuth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class WidgetDeskripsiProyek extends StatelessWidget {
  final String nama, created, lokasi, jenisLayanan, budget, noHp, status;

  const WidgetDeskripsiProyek({Key key, this.nama, this.noHp, this.status, this.budget, this.created, this.lokasi, this.jenisLayanan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    print(status);
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
                Text(
                  nama,
                  style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      budget,
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Icon(
                      Icons.credit_card,
                      color: Colors.green,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      Jiffy(created).fromNow(),
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
                    Text(jenisLayanan),
                    Spacer(),
                    Icon(
                      Icons.business,
                      color: Colors.red,
                    ),
                  ],
                ),
                !blocAuth.survey
                    ? Container()
                    : SizedBox(
                        height: 10,
                      ),
                !blocAuth.survey
                    ? Container()
                    : Row(
                        children: [
                          InkWell(
                              onTap: () async {
                                await FlutterPhoneDirectCaller.callNumber(noHp.toString());
                              },
                              child: Text(noHp)),
                          Spacer(),
                          Icon(
                            Icons.phone,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                status != 'proses'
                    ? Container()
                    : SizedBox(
                        height: 10,
                      ),
                blocAuth.survey
                    ? Container()
                    : Row(
                        children: [
                          InkWell(
                              onTap: () async {
                                await FlutterPhoneDirectCaller.callNumber(noHp.toString());
                              },
                              child: Text(noHp)),
                          Spacer(),
                          Icon(
                            Icons.phone,
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
