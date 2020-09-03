import 'package:apps/widget/News/WidgetNewsDetail.dart';
import 'package:flutter/material.dart';

class NewsDetailScreen extends StatelessWidget {
  final String link;
  final title;

  NewsDetailScreen({Key key, this.link, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WidgetNewDetail(link: link, title: title);
  }
}
