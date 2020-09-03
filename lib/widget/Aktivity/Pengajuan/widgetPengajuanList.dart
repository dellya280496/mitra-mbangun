import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/widget/Aktivity/Pengajuan/WidgetPengajuanByParamList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetPengajuanList extends StatefulWidget {
  WidgetPengajuanList({Key key}) : super(key: key);

  @override
  _WidgetPengajuanListState createState() {
    return _WidgetPengajuanListState();
  }
}

class _WidgetPengajuanListState extends State<WidgetPengajuanList> {
  var dataList = ['New', 'Review', 'Publish', 'Negosiasi', 'Kontrak', 'Progress', 'Finish', 'Tolak'];

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
    return Container(
      width: MediaQuery.of(context).size.height,
      margin: EdgeInsets.only(bottom: 50),
      child: ListView.builder(
//        shrinkWrap: true,
        itemCount: dataList.length,
        padding: EdgeInsets.all(10),
        itemBuilder: (context, index) {
          return Card(
            child: InkWell(
              onTap: () => _openPengajuan(dataList[index]),
              child: ListTile(
                  title: Text(dataList[index]),
                  leading: dataList[index] == 'New'
                      ? Icon(
                          Icons.new_releases,
                          color: Colors.blue,
                        )
                      : dataList[index] == 'Review'
                          ? Icon(
                              Icons.watch_later,
                              color: Colors.amber,
                            )
                          : dataList[index] == 'Publish'
                              ? Icon(
                                  Icons.backup,
                                  color: Colors.green,
                                )
                              : dataList[index] == 'Negosiasi'
                                  ? Icon(
                                      Icons.assignment,
                                      color: Color(0xffff7675),
                                    )
                                  : dataList[index] == 'Kontrak'
                                      ? Icon(Icons.event_note, color: Colors.red)
                                      : dataList[index] == 'Progress'
                                          ? Icon(
                                              Icons.work,
                                              color: Color(0xffff7675),
                                            )
                                          : dataList[index] == 'Finish'
                                              ? Icon(
                                                  Icons.done_all,
                                                  color: Color(0xff00cec9),
                                                )
                                              : Icon(Icons.delete, color: Colors.red),
                  trailing: Icon(Icons.arrow_forward_ios)),
            ),
          );
        },
      ),
    );
  }

  _openPengajuan(param) {
    for (int i = 0; i < dataList.length; i++) {
      if (param == dataList[i]) {
        Provider.of<DataProvider>(context).getProdukListByUserId(param);
        Navigator.push(
            context,
            SlideRightRoute(
                page: WidgetPengajuanByParamList(
              param: param,
            )));
      }
    }
  }
}
