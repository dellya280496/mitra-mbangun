import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/screen/NewsDetailScreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';

class WidgetSlide extends StatelessWidget {
  WidgetSlide({Key key}) : super(key: key);
  wp.WordPress wordPress =
      wp.WordPress(baseUrl: baseURL+ '', authenticator: wp.WordPressAuthenticator.ApplicationPasswords, adminKey: 'admin9876', adminName: 'm-bangun');

  fetchPost() {
    Future<List<wp.Post>> posts = wordPress.fetchPosts(
      postParams: wp.ParamsPostList(
        context: wp.WordPressContext.view,
        pageNum: 1,
        includeCategories: [6],
        perPage: 20,
        order: wp.Order.desc,
        orderBy: wp.PostOrderBy.date,
      ),
      fetchAuthor: true,
      fetchFeaturedMedia: true,
      fetchComments: true,
    );
    return posts;
  }

  auth() {
    Future<wp.User> response = wordPress.authenticateUser(
      username: 'm-bangun',
      password: '123456',
    );
    response.then((user) {
      print(user);
      createPost(user);
    }).catchError((err) {
      print('Failed to fetch user: $err');
    });
  }

  getPostImages(wp.Post post) {
    if (post.featuredMedia == null) {
      return SizedBox();
    }
    return Image.network(
      post.featuredMedia.sourceUrl,
      fit: BoxFit.cover,
    );
  }

  void createPost(wp.User user) {
    print(user.id);
    final post = wordPress.createPost(
      post: new wp.Post(
        title: 'First post as a Chief Editor',
        content: 'Blah! blah! blah!',
        excerpt: 'Discussion about blah!',
        password: user.password,
        authorID: user.id,
        categoryIDs: [6],
        commentStatus: wp.PostCommentStatus.closed,
        pingStatus: wp.PostPingStatus.closed,
        status: wp.PostPageStatus.publish,
        format: wp.PostFormat.standard,
        sticky: true,
      ),
    );

    post.then((p) {
      print('Post created successfully with ID: ${p.id}');
    }).catchError((err) {
      print('Failed to create post: $err');
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    DataProvider dataProvider = Provider.of(context);
    return FutureBuilder(
        future: fetchPost(),
        builder: (BuildContext context, AsyncSnapshot<List<wp.Post>> snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return Container();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SingleChildScrollView(
                child: Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  child: PKCardListSkeleton(),
                ),
              ),
            );
          }
          if (snapshot.data == null) {
            return Container();
          }
          return Container(
            margin: EdgeInsets.only(top: 10),
            child: CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 2.5,
                autoPlay: true,
              ),
              items: snapshot.data.map((i) {
                wp.Post post = i;
                return Builder(
                  builder: (BuildContext context) {
                    return InkWell(
                      onTap: () {
                        _openDetailNews(post.link, post.title.rendered, context);
                      },
                      child: Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Container(width: MediaQuery.of(context).size.width * 0.75, child: getPostImages(post)),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          );
        });
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
