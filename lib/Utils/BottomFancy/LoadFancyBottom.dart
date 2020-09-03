import 'package:flutter/material.dart';
import 'package:apps/Utils/BottomFancy/FancyTabBar.dart';

class LoadFancyBottom extends StatefulWidget {
  LoadFancyBottom({Key key}) : super(key: key);

  @override
  _LoadFancyBottomState createState() {
    return _LoadFancyBottomState();
  }
}

class _LoadFancyBottomState extends State<LoadFancyBottom> {
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
    return Scaffold(
      bottomNavigationBar: FancyTabBar(),
    );
  }
}
