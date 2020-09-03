import 'package:apps/Utils/SnacbarLauncher.dart';
import 'package:apps/Utils/TextBold.dart';
import 'package:apps/Utils/TitleHeader.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/screen/PendaftaranScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginWidget extends StatefulWidget {
  final Color primaryColor;
  final Color backgroundColor;
  final String page;

  LoginWidget({Key key, this.primaryColor, this.backgroundColor, this.page});

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    return blocAuth.isLoading
        ? Center(
            child: CircularProgressIndicator(
            backgroundColor: Colors.transparent,
          ))
        : blocAuth.isRegister
            ? PendaftaranScreen()
            : Container(
                child: Form(
                  key: _formKey,
                  autovalidate: false,
                  child: blocAuth.isNonActive
                      ? Container(
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: Image.asset(
                                  'assets/img/sad.png',
                                  height: 300,
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Akun telah di nonaktifkan',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    'Periksa email anda untuk keterangan lebih lanjut',
                                    style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                              SnackBarLauncher(error: 'Akun anda telah di non aktifkan', color: Colors.red),
                            ],
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            new ClipPath(
                              clipper: MyClipper(),
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(top: 50.0, bottom: 50.0),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child: new Image(width: 100, fit: BoxFit.fill, image: new AssetImage('assets/logo.png')),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TitleHeader(
                                      title: 'm-Bangun',
                                      color: Colors.black,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Center(
                              child: Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    height: 50,
                                    decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.all(Radius.circular(30))),
                                    child: IconButton(
                                      color: Colors.white,
                                      iconSize: 18,
                                      onPressed: () async {
                                        BlocAuth blocAuth = Provider.of<BlocAuth>(context);
                                        var result = await blocAuth.handleSignIn();
                                        if (widget.page == 'product') {
                                          Navigator.pop(context);
                                          blocAuth.checkSession();
                                        }
                                        blocAuth.checkSession();
                                      },
                                      icon: Icon(FontAwesomeIcons.google),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [Text('Selamat datang di', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)), TextBold(title: ' m-Bangun')],
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        'Login dengan akun Google anda, mudah dan gampang',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = new Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height * 0.85);
    p.arcToPoint(
      Offset(0.0, size.height * 0.85),
      radius: const Radius.elliptical(50.0, 10.0),
      rotation: 0.0,
    );
    p.lineTo(0.0, 0.0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
