import 'package:apps/Utils/BottomAnimation.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocProyek.dart';
import 'package:apps/widget/Login/LoginWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final String param;

  LoginScreen({Key key, this.param}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 100)).then((_) async {
      BlocAuth blocAuth = Provider.of<BlocAuth>(context);
      if(blocAuth.isLogin){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomAnimateBar()));
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Login'),
      ),
      body: LoginWidget(
        primaryColor: Color(0xFFb16a085),
        backgroundColor: Colors.white,
        page: this.widget.param,
      ),
    );
  }
}
