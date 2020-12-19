import 'dart:async';

import 'package:apps/Utils/BottomAnimation.dart';
import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/screen/PendaftaranScreen.dart';
import 'package:apps/screen/PhoneAuth/presentation/manager/phone_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class PhoneAuthVerify extends StatefulWidget {
  PhoneAuthVerify({Key key, this.phoneNumber}) : super(key: key);

  final phoneNumber;

  /*
   *  cardBackgroundColor & logo values will be passed to the constructor
   *  here we access these params in the _PhoneAuthState using "widget"
   */
  final Color cardBackgroundColor = Color(0xFFFCA967);
  final String logo = 'assets/logo.png';
  final String appName = "Mbangun";

  @override
  _PhoneAuthVerifyState createState() => _PhoneAuthVerifyState();
}

class _PhoneAuthVerifyState extends State<PhoneAuthVerify> {
  double _height, _width, _fixedPadding;

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();
  FocusNode focusNode5 = FocusNode();
  FocusNode focusNode6 = FocusNode();
  String code = "";
  final scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: "scaffold-verify-phone");
  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();

  // ..text = "123456";

  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    // errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    // errorController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //  Fetching height & width parameters from the MediaQuery
    //  _logoPadding will be a constant, scaling it according to device's size
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _fixedPadding = _height * 0.025;

    // final phoneAuthDataProvider = Provider.of<PhoneAuthDataProvider>(context);

    // phoneAuthDataProvider.setMethods(
    //   onStarted: onStarted,
    //   onError: onError,
    //   onFailed: onFailed,
    //   onVerified: onVerified,
    //   onCodeResent: onCodeResent,
    //   onCodeSent: onCodeSent,
    //   onAutoRetrievalTimeout: onAutoRetrievalTimeOut,
    // );

    /*
     *  Scaffold: Using a Scaffold widget as parent
     *  SafeArea: As a precaution - wrapping all child descendants in SafeArea, so that even notched phones won't loose data
     *  Center: As we are just having Card widget - making it to stay in Center would really look good
     *  SingleChildScrollView: There can be chances arising where
     */
    final provider = Provider.of<PhoneAuthDataProvider>(context);
    final blocAuth = Provider.of<BlocAuth>(context);
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      key: scaffoldKey,
      body: ModalProgressHUD(
        inAsyncCall: provider.loading || blocAuth.isLoading,
        child: GestureDetector(
          onTap: () {},
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              children: <Widget>[
                SizedBox(height: 30),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  child: FlareActor(
                    "assets/otp.flr",
                    animation: "otp",
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.center,
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Verifikasi nomor telepon',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                  child: RichText(
                    text: TextSpan(
                        text: "Masukkan kode yang dikirim ke ",
                        children: [
                          TextSpan(
                              text: '+62' + widget.phoneNumber,
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15)),
                        ],
                        style: TextStyle(color: Colors.black54, fontSize: 15)),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: formKey,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                      child: PinCodeTextField(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        appContext: context,
                        pastedTextStyle: TextStyle(
                          color: Colors.green.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 4,
                        obscureText: false,
                        obscuringCharacter: '*',
                        animationType: AnimationType.fade,
                        validator: (v) {
                          if (v.length < 3) {
                            return "I'm from validator";
                          } else {
                            return null;
                          }
                        },
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.underline,
                          borderRadius: BorderRadius.circular(5),
                          inactiveColor: Colors.white,
                          fieldHeight: 45,
                          fieldWidth: 45,
                          activeFillColor: hasError ? Colors.orange : Colors.white,
                        ),
                        cursorColor: Colors.black,
                        animationDuration: Duration(milliseconds: 300),
                        textStyle: TextStyle(fontSize: 20, height: 1.6),
                        backgroundColor: Colors.blue.shade50,
                        enableActiveFill: true,
                        errorAnimationController: errorController,
                        controller: textEditingController,
                        keyboardType: TextInputType.number,
                        boxShadows: [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: Colors.black12,
                            blurRadius: 10,
                          )
                        ],
                        onCompleted: (v) {
                          print("Completed");
                        },
                        onChanged: (value) {
                          // print(value);
                          setState(() {
                            currentText = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    hasError ? "*Please fill up all the cells properly" : "",
                    style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "Tidak menerima kode?",
                      style: TextStyle(color: Colors.black54, fontSize: 15),
                      children: [
                        TextSpan(
                            text: " KIRIM ULANG",
                            recognizer: onTapRecognizer,
                            style: TextStyle(color: Color(0xFF91D3B3), fontWeight: FontWeight.bold, fontSize: 16))
                      ]),
                ),
                SizedBox(
                  height: 14,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                  child: ButtonTheme(
                    height: 50,
                    child: FlatButton(
                      onPressed: () {
                        formKey.currentState.validate();
                        // conditions for validating
                        if (currentText.length != 4) {
                          // errorController.add(ErrorAnimationType
                          //     .shake); // Triggering error shake animation
                          setState(() {
                            hasError = true;
                          });
                        } else {
                          setState(() {
                            signIn();
                            hasError = false;
                          });
                        }
                      },
                      child: Center(
                          child: Text(
                        "VERIFY".toUpperCase(),
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  decoration:
                      BoxDecoration(color: Colors.green.shade300, borderRadius: BorderRadius.circular(5), boxShadow: [
                    BoxShadow(color: Colors.green.shade200, offset: Offset(1, -2), blurRadius: 5),
                    BoxShadow(color: Colors.green.shade200, offset: Offset(-1, 2), blurRadius: 5)
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showSnackBar(String text) {
    final snackBar = SnackBar(
      content: Text('$text'),
      duration: Duration(seconds: 5),
    );
//    if (mounted) Scaffold.of(context).showSnackBar(snackBar);
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  signIn() async {
    final provider = Provider.of<PhoneAuthDataProvider>(context);
    final blocAuth = Provider.of<BlocAuth>(context);
    var body = {'code_otp': textEditingController.text, 'expired': 'f'};
    var result = await provider.verifyOTPAndLogin(body);
    if (result['meta']['success']) {
      LocalStorage.sharedInstance.writeValue(key: 'no_telp', value: "62" + provider.phoneNumberController.text);
      Flushbar(
        title: "Verified",
        message: result['meta']['status_message'],
        duration: Duration(seconds: 5),
        backgroundColor: Colors.green,
        flushbarPosition: FlushbarPosition.BOTTOM,
        icon: Icon(
          Icons.verified,
          color: Colors.white,
        ),
      )..show(context);
      blocAuth.setPhoneNumber("62" + provider.phoneNumberController.text);
      var userData = await Provider.of<BlocAuth>(context).getUserData();
      print(userData.toString()+ ' chek data');
      if (userData) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => BottomAnimateBar()), (Route<dynamic> route) => false);
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PendaftaranScreen()));
      }
    } else {
      Flushbar(
        title: "Error",
        message: result['meta']['status_message'],
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        flushbarPosition: FlushbarPosition.BOTTOM,
        icon: Icon(
          Icons.close,
          color: Colors.white,
        ),
      )..show(context);
    }
  }

  // This will return pin field - it accepts only single char
  Widget getPinField({String key, FocusNode focusNode}) => SizedBox(
        height: 40.0,
        width: 35.0,
        child: TextField(
          key: Key(key),
          expands: false,
//          autofocus: key.contains("1") ? true : false,
          autofocus: false,
          focusNode: focusNode,
          onChanged: (String value) {
            if (value.length == 1) {
              code += value;
              switch (code.length) {
                case 1:
                  FocusScope.of(context).requestFocus(focusNode2);
                  break;
                case 2:
                  FocusScope.of(context).requestFocus(focusNode3);
                  break;
                case 3:
                  FocusScope.of(context).requestFocus(focusNode4);
                  break;
                case 4:
                  FocusScope.of(context).requestFocus(focusNode5);
                  break;
                case 5:
                  FocusScope.of(context).requestFocus(focusNode6);
                  break;
                default:
                  FocusScope.of(context).requestFocus(FocusNode());
                  break;
              }
            }
          },
          maxLengthEnforced: false,
          textAlign: TextAlign.center,
          cursorColor: Colors.white,

          keyboardType: TextInputType.number,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.white),
          // decoration: InputDecoration(
          //     contentPadding: const EdgeInsets.only(
          //         bottom: 10.0, top: 10.0, left: 4.0, right: 4.0),
          //     fillColor: Colors.cyan,
          //     focusedBorder: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(5.0),
          //         borderSide:
          //             BorderSide(color: Colors.blueAccent, width: 2.25)),
          //     border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(5.0),
          //         borderSide: BorderSide(color: Colors.white))),
        ),
      );
}
