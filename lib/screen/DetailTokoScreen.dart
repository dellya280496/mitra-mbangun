import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/widget/Toko/WidgetKategoriByToko.dart';
import 'package:apps/widget/Toko/WidgetProdukTerjual.dart';
import 'package:apps/widget/home/WidgetOffialStore.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';
import 'package:sliverbar_with_card/sliverbar_with_card.dart';

class DetailTokoScreen extends StatefulWidget {
  DetailTokoScreen({Key key, this.id, this.image}) : super(key: key);
  final image;
  final String id;

  @override
  _DetailTokoScreenState createState() => _DetailTokoScreenState();
}

class _DetailTokoScreenState extends State<DetailTokoScreen> {
  bool favorito = false;
  bool expandText = false;
  final controller = PageController();
  PaletteGenerator paletteGenerator;
  Rect region;
  Rect dragRegion;
  Color bannerColor;

  @override
  void initState() {
    super.initState();
    region = Offset.zero & Size(256.0, 170.0);
    setColor();
  }

  setColor() async {
    var a = _updatePaletteGenerator(region, 'https://m-bangun.com/api-v2/assets/toko/' + widget.image);
    a.then((value) {
      setState(() {
        bannerColor = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AppBar appBar = AppBar(
      elevation: 0.0,
      backgroundColor: bannerColor,
      leading: Container(),
      title: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Container(
          padding: EdgeInsets.all(5),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              isScrollable: true,
              labelColor: bannerColor,
              unselectedLabelColor: Colors.white,
              indicatorPadding: EdgeInsets.all(10),
              indicatorColor: Color(0xffb16a085),
              indicator: new BubbleTabIndicator(
                indicatorHeight: 30.0,
                indicatorColor: Colors.grey[200],
                tabBarIndicatorSize: TabBarIndicatorSize.tab,
              ),
              tabs: [
                Tab(
                  child: Text(
                    'Produk',
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
//                Tab(
//                  child: Text(
//                    'Tentang Toko',
//                    style: TextStyle(fontWeight: FontWeight.w400),
//                  ),
//                ),
              ],
            ),
          ),
        ),
      ),
    );
    BlocProduk blocProduk = Provider.of(context);
    return Material(
      child: blocProduk.isLoading
          ? Center(
              child: PKCardListSkeleton(),
            )
          : RefreshIndicator(
              onRefresh: () => blocProduk.getProdukTerjual(widget.id),
              child: CardSliverAppBar(
                height: 200,
                background: Image.network(
                  "https://m-bangun.com/api-v2/assets/toko/" + blocProduk.detailStore[0].fotoSampul,
                  fit: BoxFit.cover,
                  errorBuilder: (context, urlImage, error) {
                    print(error.hashCode);
                    return Image.asset('assets/logo.png');
                  },
                ),
                title: Text(blocProduk.detailStore[0].namaToko, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                titleDescription: Text(blocProduk.detailStore[0].jenisToko, style: TextStyle(color: Colors.black, fontSize: 11)),
                card: NetworkImage(
                  'https://m-bangun.com/api-v2/assets/toko/' + blocProduk.detailStore[0].foto,
                ),
                backButton: true,
                backButtonColors: [Colors.white, Colors.black],
                action: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.person_outline,
                          color: bannerColor,
                        ),
                        Text(
                          'Follow',
                          style: TextStyle(color: bannerColor, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                body: Container(
                  alignment: Alignment.topLeft,
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: <Widget>[
                      Divider(),
                      Expanded(
                        flex: 2,
                        child: DefaultTabController(
                          length: 1,
                          child: Scaffold(
                            appBar: appBar,
                            body: TabBarView(
                              children: [
                                Column(
                                  children: [
                                    Expanded(flex: 0, child: WidgetKategoriByToko()),
                                    Expanded(
                                      flex: 0,
                                      child: WidgetProdukTerjual(
                                        blocProduk: blocProduk,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
//                        height: MediaQuery.of(context).size.height * 0.3,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(left: 10, top: 10),
                              child: Text("Toko Lainnya", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              child: WidgetOffialStore(
                                blocProduk: blocProduk,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _ratingIcon(Icon icon, Text text) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50)), color: Colors.grey),
            child: IconButton(
              onPressed: () {},
              icon: icon,
              color: Colors.white,
              iconSize: 30,
            ),
          ),
          Divider(),
          text
        ],
      ),
    );
  }

  Future<Color> _updatePaletteGenerator(Rect newRegion, String image) async {
    ImageProvider imageBanner = NetworkImage(
      image,
    );
    paletteGenerator = await PaletteGenerator.fromImageProvider(
      imageBanner,
      size: Size(256.0, 170.0),
      region: newRegion,
      maximumColorCount: 20,
    );
    return paletteGenerator.dominantColor.color;
  }

  Widget _exampleRelatedShow() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.grey,
      ),
      width: 80,
      height: 100,
    );
  }
}
