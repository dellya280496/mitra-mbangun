import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocProyek.dart';
import 'package:apps/widget/Login/LoginWidget.dart';
import 'package:apps/widget/Pendaftaran/WidgetTunggu.dart';
import 'package:apps/widget/Project/WidgetListProyek.dart';
import 'package:apps/widget/filter/WIdgetFilter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:sup/sup.dart';

class ProyekScreen extends StatefulWidget {
  final String namaKategori;
  final String status;
  final param;

  ProyekScreen({Key key, this.namaKategori, this.status, this.param}) : super(key: key);

  @override
  _ProyekScreenState createState() => _ProyekScreenState();
}

class _ProyekScreenState extends State<ProyekScreen> with TickerProviderStateMixin {
  AnimationController _hideFabAnimation;

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        _hideFabAnimation.forward();
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            if (userScroll.metrics.maxScrollExtent != userScroll.metrics.minScrollExtent) {
              _hideFabAnimation.forward();
            }
            break;
          case ScrollDirection.reverse:
            if (userScroll.metrics.maxScrollExtent != userScroll.metrics.minScrollExtent) {
              _hideFabAnimation.reverse();
            }
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _hideFabAnimation = AnimationController(vsync: this, duration: kThemeAnimationDuration);
    _hideFabAnimation.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _hideFabAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BlocProyek blocProyek = Provider.of<BlocProyek>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    return !blocAuth.isLogin
        ? Container(
            color: Colors.white,
            child: LoginWidget(
              primaryColor: Color(0xFFb16a085),
              backgroundColor: Colors.white,
              page: '/BottomNavBar',
            ),
          )
        : !blocAuth.isMitra
            ? WidgetTunggu()
            : NotificationListener<ScrollNotification>(
                onNotification: _handleScrollNotification,
                child: Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    title: Text(widget.namaKategori),
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.info,
                          color: Colors.grey,
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                  body: blocProyek.listProyeks.isEmpty
                      ? Center(
                          child: Sup(
                            title: Text('Proyek tidak tersedia'),
                            subtitle: InkWell(
                                onTap: () {
                                  if (blocAuth.survey) {
                                    var param = {
                                      'aktif': '1',
                                      'status': "('survey','setuju')",
                                      'status_pembayaran_survey': 'terbayar',
                                      'limit': blocProyek.limit.toString(),
                                      'offset': blocProyek.offset.toString(),
                                    };
                                    blocProyek.getAllProyekByParam(param);
                                  } else {
                                    var idJenisLayanan = blocAuth.listJenisLayananMitra.map((e) => e.id).toString();
                                    if (idJenisLayanan != '()') {
                                      var param = {
                                        'aktif': '1',
                                        'status': "('setuju')",
                                        'status_pembayaran_survey': 'terbayar',
                                        'limit': blocProyek.limit.toString(),
                                        'offset': blocProyek.offset.toString(),
                                        'id_jenis_layanan': idJenisLayanan
                                      };
                                      blocProyek.getAllProyekByParam(param);
                                    }
                                  }
                                },
                                child: Text('Muat Ulang')),
                            image: Image.asset(
                              'assets/img/sad.png',
                              height: 250,
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.all(0),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: WidgetListProyek(
                                  param: widget.param,
                                  namaKategori: this.widget.namaKategori,
                                  status:widget.status
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              );
  }
}
