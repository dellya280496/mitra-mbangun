import 'package:apps/Utils/BottomAnimation.dart';
import 'package:apps/screen/LoginScreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  Animation<double> opacity;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: Duration(milliseconds: 4500), vsync: this);
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward().then((_) {
      navigationPage();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void navigationPage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => BottomAnimateBar()));
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/splace-background.png'), fit: BoxFit.fitHeight)),
      child: Container(
        child: SafeArea(
          child: new Scaffold(
            backgroundColor: Colors.grey.withOpacity(0.1),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: Opacity(
                      opacity: opacity.value,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: new Image.asset(
                            'assets/logo.png',
                            width: 150,
                          )),
                          Text(
                            'Mbangun',
                            style: TextStyle(fontSize: 24, fontFamily: 'SUNDAY', letterSpacing: 2, fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [TextSpan(text: 'Powered by '), TextSpan(text: 'Mustika Bangun Teknologi', style: TextStyle(fontWeight: FontWeight.bold))]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
