import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/screen/NewsDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'package:jiffy/jiffy.dart';

class PropertiAds extends StatelessWidget {
  PropertiAds({Key key}) : super(key: key);
  wp.WordPress wordPress = wp.WordPress(
    baseUrl: baseURL+ '',
  );

  int count = 0;

  iklanTop() {
    Future<List<wp.Post>> iklanTop = wordPress.fetchPosts(
      postParams: wp.ParamsPostList(
        context: wp.WordPressContext.view,
        pageNum: 1,
        includeCategories: [6],
        perPage: 10,
        order: wp.Order.desc,
        orderBy: wp.PostOrderBy.date,
      ),
      fetchAuthor: true,
      fetchFeaturedMedia: true,
      fetchComments: true,
    );
//    iklanTop.then((value){
//      count = value.length;
//    });
    return iklanTop;
  }

  getPostImages(wp.Post post) {
    if (post.featuredMedia == null) {
      return SizedBox();
    }
    return Image.network(
      post.featuredMedia.sourceUrl,
      fit: BoxFit.cover,
      width: 200,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print(count);
    return Column(
      children: <Widget>[
        FutureBuilder(
          future: iklanTop(),
          builder: (BuildContext context, AsyncSnapshot<List<wp.Post>> snapshot) {
            if (snapshot.connectionState == ConnectionState.none) {
              return Container();
            }
            return snapshot.data == null
                ? Container()
                : snapshot.data.length == 0
                    ? Container()
                    : Container(
                        color: Color(0xffea8685),
                        padding: EdgeInsets.only(bottom: 15),
                        child: Column(
                          children: [
                            snapshot.data == null
                                ? Container()
                                : snapshot.data.length == 0
                                    ? Container()
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(context).size.width * 0.6,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Properti', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white)),
                                                    Text(
                                                      'Temukan properti terbaik di m-bangun',
                                                      style: TextStyle(fontSize: 12, color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                  child: Icon(
                                                Icons.stars,
                                                color: Colors.white,
                                              )),
                                            ],
                                          ),
                                        ),
                                      ),
                            snapshot.data == null
                                ? Container()
                                : snapshot.data.length == 0
                                    ? Container()
                                    : Container(
                                        height: 270,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          padding: EdgeInsets.only(left: 5, right: 5, top: 10),
                                          itemCount: snapshot.data.length,
                                          itemBuilder: (context, index) {
                                            count = snapshot.data.length;
                                            wp.Post post = snapshot.data[index];
                                            return Card(
                                              semanticContainer: true,
                                              clipBehavior: Clip.antiAliasWithSaveLayer,
                                              child: InkWell(
                                                onTap: () => _openDetailNews(post.link, post.title.rendered, context),
                                                child: Column(
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 2,
                                                      child: getPostImages(post),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                          children: [
                                                            Container(
                                                              width: 180,
                                                              child: RichText(
                                                                overflow: TextOverflow.ellipsis,
                                                                maxLines: 4,
                                                                strutStyle: StrutStyle(fontSize: 10.0),
                                                                text: TextSpan(
                                                                    style: TextStyle(color: Colors.grey[800], fontSize: 12, fontWeight: FontWeight.bold),
                                                                    text: post.title.rendered),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 180,
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text(
                                                                        post.author.name,
                                                                        style: TextStyle(fontSize: 10, fontStyle: FontStyle.normal, color: Colors.grey[400]),
                                                                      ),
                                                                      Text(
                                                                        Jiffy(post.date).fromNow(),
                                                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 9, color: Colors.grey),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Icon(
                                                                    Icons.stars,
                                                                    color: Colors.amber,
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                              elevation: 2,
                                              margin: EdgeInsets.all(10),
                                            );
                                          },
                                        ),
                                      ),
                          ],
                        ),
                      );
          },
        )
      ],
    );
  }

  _openDetailNews(link, title, context) {
    Navigator.push(
        context,
        SlideRightRoute(
            page: NewsDetailScreen(
          link: link,
          title: title,
        )));
  }
}
