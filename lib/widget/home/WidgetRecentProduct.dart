import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/providers/BlocProyek.dart';
import 'package:apps/screen/ProdukDetailScreen.dart';
import 'package:apps/screen/ProdukScreen.dart';
import 'package:apps/screen/ProyekScreen.dart';
import 'package:flutter/material.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class WidgetRecentProduct extends StatelessWidget {
  WidgetRecentProduct({
    Key key,
    @required this.blocProyek,
  }) : super(key: key);
  final BlocProyek blocProyek;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Proyek Terbaru',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          )),
                      Text(
                        'Rekomendasi proyek terbaru',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    String currentIdProvinsi = await LocalStorage.sharedInstance.readValue('idProvinsi');
                    String currentIdKota = await LocalStorage.sharedInstance.readValue('idKota');
                    String currentIdKecamatan = await LocalStorage.sharedInstance.readValue('idKecamatan');
                    var param = {
                      'aktif': '1',
                      'limit': blocProyek.limit.toString(),
                      'offset': blocProyek.offset.toString(),
                      'status':'setuju',
                      'status_pembayaran_survey':'terbayar'
                    };
                    blocProyek.getAllProyekByParam(param);
                    Navigator.push(
                        context,
                        SlideRightRoute(
                            page: ProyekScreen(
                              namaKategori: 'Semua',
                                param: param)));
                  },
                  child: Text(
                    'Semua',
                    style: TextStyle(fontSize: 12, color: Color(0xffb16a085)),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.5,
          child: GridView.count(
            childAspectRatio: 0.8,
            crossAxisCount: 3,
            shrinkWrap: false,
            physics: new NeverScrollableScrollPhysics(),
            children: List.generate(blocProyek.listRecentProyek.length, (j) {
              final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
              var budget = blocProyek.listRecentProyek.isEmpty ? '0' : blocProyek.listRecentProyek[j].budget;
              var budgetFormat = Money.fromInt(budget == null ? 0 : int.parse(budget), IDR);
             return Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: InkWell(
                  onTap: () {
                    blocProyek.getDetailProyekByParam({'id': blocProyek.listRecentProyek[j].id, 'aktif': '1'});
                    blocProfile.getCityParam({'id': blocProyek.listRecentProyek[j].idKota.toString()});
                    blocOrder.getUlasanProduByParam({'id_produk': blocProyek.listRecentProyek[j].id});
                    Navigator.push(context, SlideRightRoute(page: ProdukDetailScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: getPostImages(blocProyek.listRecentProyek[j].foto1),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 100,
                                    child: RichText(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 12), text: blocProyek.listRecentProyek[j].nama),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    child: RichText(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      text: TextSpan(
                                          style: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          text: budgetFormat.toString()),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        blocProyek.listRecentProyek.isEmpty
                                            ? Container()
                                            :  Image.asset(
                                                    'assets/icons/verified.png',
                                                    height: 10,
                                                  )
                                               ,
                                        Container(
                                          margin: EdgeInsets.only(left: 2),
                                          width: MediaQuery.of(context).size.width * 0.20,
                                          child: RichText(
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            text: TextSpan(
                                                style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.normal, fontStyle: FontStyle.italic),
                                                text: blocProyek.listRecentProyek[j].nama + ' '),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1,
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                elevation: 2,
                margin: EdgeInsets.all(10),
              );
            }),
          ),
        ),
      ],
    );
  }

  getPostImages(String url) {


    if (url == null) {
      return SizedBox();
    }else{
      var urlImage = 'https://m-bangun.com/api-v2/assets/toko/' + url;
      return Image.network(
        urlImage,
        fit: BoxFit.cover,
        errorBuilder: (context, urlImage, error) {
          print(error.hashCode);
          return Image.network('https://m-bangun.com/api-v2/assets/toko/No-image-found.jpg');
        },
      );
    }

  }
}
