import 'package:apps/Utils/BottomAnimation.dart';
import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/screen/PendaftaranScreen.dart';
import 'package:apps/screen/PhoneAuth/presentation/pages/firebase/auth/phone_auth/get_phone.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  Animation<double> opacity;
  AnimationController controller;
  List<Slide> slides = new List();

  Function goToTab;

  @override
  void initState() {
    super.initState();
    checkSession();
  }

  setSlide() {
    slides.add(
      new Slide(
        title: "Inovasi",
        description:
            "Sebuah terobosan baru didunia kontruksi \n - Renovasi Rumah\n- Custom Interior\n- Desain kontruksi rumah",
        pathImage: "assets/slide1.png",
        backgroundColor: Color(0xfff5a623),
      ),
    );
    slides.add(
      new Slide(
        title: "PENCIL",
        description: "Ye indulgence unreserved connection alteration appearance",
        pathImage: "assets/slide2.png",
        backgroundOpacity: 0.1,
        backgroundColor: Colors.red[700],
      ),
    );
    slides.add(
      new Slide(
        title: "RULER",
        description:
            "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
        pathImage: "assets/slide1.png",
        backgroundColor: Color(0xff9932CC),
      ),
    );
  }

  checkSession() async {
    final provider = await Provider.of<BlocAuth>(context, listen: false);
    var noTelp = await LocalStorage.sharedInstance.readValue('no_telp');
    print(noTelp.toString() + ' notelp');
    if (noTelp != null) {
      provider.setPhoneNumber(noTelp);
      final result = Provider.of<BlocAuth>(context).getUserData();
      result.then((value) {
        print(value.toString() + ' respons data');
        if (value) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => BottomAnimateBar()), (Route<dynamic> route) => false);
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PendaftaranScreen()));
        }
      });
    } else {
      await setSlide();
    }
  }

  void onDonePress() {
    // Back to the first tab
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PhoneAuthGetPhone()));
  }

  void onTabChangeCompleted(index) {
    // Index of current tab is focused
    print('complate');
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Color(0xffffcc5c),
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Color(0xffffcc5c),
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Color(0xffffcc5c),
    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = new List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 60.0, top: 60.0),
          child: ListView(
            children: <Widget>[
              GestureDetector(
                  child: Image.asset(
                currentSlide.pathImage,
                width: 200.0,
                height: 200.0,
                fit: BoxFit.contain,
              )),
              Container(
                child: Text(
                  currentSlide.title,
                  style: currentSlide.styleTitle,
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
              Container(
                child: Text(
                  currentSlide.description,
                  style: currentSlide.styleDescription,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  void navigationPage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => PhoneAuthGetPhone()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this.slides.length == 0
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/logo.png',
                      height: 100,
                      width: 100,
                    ),
                  ),
                  Text(
                    'Mbangun',
                    style: Theme.of(context).textTheme.title,
                  )
                ],
              ),
            )
          : IntroSlider(
              // List slides
              slides: this.slides,
              onDonePress: this.onDonePress,
            ),
    );
  }
}
