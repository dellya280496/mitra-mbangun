import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/widget/Tagihan/WidgetTagihan.dart';
import 'package:apps/widget/WidgetProgress/WidgetProgress.dart';
import 'package:flutter/material.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';

class WidgetInvoice extends StatelessWidget {
  WidgetInvoice({Key key, this.flag}) : super(key: key);
  final String flag;

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Invoice ${flag}'),
      ),
      body: dataProvider.isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: ListView.builder(
            itemCount: dataProvider.invoiceListData.length,
            itemBuilder: (context, index) {
              final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
                    var invoiceStatus = dataProvider.invoiceListData[index].invoiceStatus;
                    var invoiceNominal =
                        Money.fromInt(dataProvider.invoiceListData[index].invoiceNominal == null ? 0 : int.parse(dataProvider.invoiceListData[index].invoiceNominal), IDR);
                    return //              Card(
                        InkWell(
                      onTap: () {
                        if (flag == 'worker') {
                          Navigator.push(context, SlideRightRoute(page: WidgetProgress()));
                        } else {
                          if (dataProvider.invoiceListData[index].invoiceStatus == 'Pending') {
                            dataProvider.getAllBank();
                            dataProvider.getAllMetodeTransfer();
                            Navigator.push(context, SlideRightRoute(page: WidgetTagihan()));
                          } else {
                            Navigator.push(context, SlideRightRoute(page: WidgetProgress()));
                          }
                        }
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(
                                invoiceNominal.toString()),
                            subtitle: Text(dataProvider.invoiceListData[index].invoiceDeskripsi),
                            trailing: Text(
                              dataProvider.invoiceListData[index].invoiceStatus,
                              style: TextStyle(color: invoiceStatus == 'Pending' ? Colors.red : Colors.green),
                            ),
                            leading: Icon(
                              Icons.transfer_within_a_station,
                              size: 35,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
          ),
        ),
      ),
    );
  }
}
