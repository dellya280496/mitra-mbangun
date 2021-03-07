import 'dart:math';

import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/screen/PhoneAuth/presentation/manager/countries.dart';
import 'package:apps/screen/PhoneAuth/presentation/manager/phone_auth.dart';
import 'package:apps/screen/PhoneAuth/presentation/pages/firebase/auth/phone_auth/select_country.dart';
import 'package:apps/screen/PhoneAuth/presentation/pages/firebase/auth/phone_auth/verify.dart';
import 'package:apps/screen/PhoneAuth/presentation/widgets/bezierContainer.dart';
import 'package:apps/screen/PhoneAuth/presentation/widgets/utils/widgets.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
 *  PhoneAuthUI - this file contains whole ui and controllers of ui
 *  Background code will be in other class
 *  This code can be easily re-usable with any other service type, as UI part and background handling are completely from different sources
 *  code.dart - Class to control background processes in phone auth verification using Firebase
 */

class PhoneAuthGetPhone extends StatefulWidget {
  /*
   *  cardBackgroundColor & logo values will be passed to the constructor
   *  here we access these params in the _PhoneAuthState using "widget"
   */
  final Color cardBackgroundColor = Color(0xFF6874C2);
  final String logo = 'assets/logo.png';
  final String appName = "Mbangun";

  @override
  _PhoneAuthGetPhoneState createState() => _PhoneAuthGetPhoneState();
}

class _PhoneAuthGetPhoneState extends State<PhoneAuthGetPhone> {
  /*
   *  _height & _width:
   *    will be calculated from the MediaQuery of widget's context
   *  countries:
   *    will be a list of Country model, Country model contains name, dialCode, flag and code for various countries
   *    and below params are all related to StreamBuilder
   */
  double _height, _width, _fixedPadding;

  /*
   *  _searchCountryController - This will be used as a controller for listening to the changes what the user is entering
   *  and it's listener will take care of the rest
   */

  /*
   *  This will be the index, we will modify each time the user selects a new country from the dropdown list(dialog),
   *  As a default case, we are using India as default country, index = 31
   */

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: "scaffold-get-phone");

  @override
  Widget build(BuildContext context) {
    //  Fetching height & width parameters from the MediaQuery
    //  _logoPadding will be a constant, scaling it according to device's size
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _fixedPadding = _height * 0.025;
    final countriesProvider = Provider.of<CountryProvider>(context);
    final loader = Provider.of<PhoneAuthDataProvider>(context).loading;
    /*  Scaffold: Using a Scaffold widget as parent
     *  SafeArea: As a precaution - wrapping all child descendants in SafeArea, so that even notched phones won't loose data
     *  Center: As we are just having Card widget - making it to stay in Center would really look good
     *  SingleChildScrollView: There can be chances arising where
     */

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('test'),
      // ),
      key: scaffoldKey,
      backgroundColor: Colors.white.withOpacity(0.95),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: -MediaQuery.of(context).size.height * .15,
                right: -MediaQuery.of(context).size.width * .4,
                child: BezierContainer(),
              ),
              _getBody(countriesProvider),
            ],
          ),
        ),
      ),
    );
  }

  /*
   *  Widget hierarchy ->
   *    Scaffold -> SafeArea -> Center -> SingleChildScrollView -> Card()
   *    Card -> FutureBuilder -> Column()
   */
  Widget _getBody(CountryProvider countriesProvider) => Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        height: _height,
        // elevation: 2.0,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: countriesProvider.countries.length > 0
            ? _getColumnBody(countriesProvider)
            : Center(child: CircularProgressIndicator()),
      );

  Widget _getColumnBody(CountryProvider countriesProvider) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          //  Logo: scaling to occupy 2 parts of 10 in the whole height of device
          Padding(
            padding: EdgeInsets.all(_fixedPadding),
            child: PhoneAuthWidgets.getLogo(
                logoPath: widget.logo, height: _height * 0.2),
          ),

          // AppName:
          Text(widget.appName,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700)),

          Padding(
            padding: EdgeInsets.only(top: _fixedPadding, left: _fixedPadding),
            child: SubTitle(text: 'Pilih negara anda'),
          ),

          /*
           *  Select your country, this will be a custom DropDown menu, rather than just as a dropDown
           *  onTap of this, will show a Dialog asking the user to select country they reside,
           *  according to their selection, prefix will change in the PhoneNumber TextFormField
           */
          Padding(
              padding:
                  EdgeInsets.only(left: _fixedPadding, right: _fixedPadding),
              child: ShowSelectedCountry(
                country: countriesProvider.selectedCountry,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SelectCountry()),
                  );
                },
              )),

          //  Subtitle for Enter your phone
          Padding(
            padding: EdgeInsets.only(top: 10.0, left: _fixedPadding),
            child: SubTitle(text: 'Masukkan nomor anda'),
          ),
          //  PhoneNumber TextFormFields
          Padding(
            padding: EdgeInsets.only(
                left: _fixedPadding,
                right: _fixedPadding,
                bottom: _fixedPadding),
            child: PhoneNumberField(
              controller: Provider.of<PhoneAuthDataProvider>(context)
                  .phoneNumberController,
              prefix: countriesProvider.selectedCountry.dialCode ?? "+62",
            ),
          ),

          /*
           *  Some informative text
           */
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(width: _fixedPadding),
              Icon(Icons.info, color: Colors.orange, size: 20.0),
              SizedBox(width: 10.0),
              Expanded(
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'Kami akan mengirim ',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w400)),
                  TextSpan(
                      text: 'Kode OTP ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700)),
                  TextSpan(
                      text:
                          ' ke nomor handphone anda, mohon tidak memberitahukan kode kepada orang lain',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w400)),
                ])),
              ),
              SizedBox(width: _fixedPadding),
            ],
          ),

          /*
           *  Button: OnTap of this, it appends the dial code and the phone number entered by the user to send OTP,
           *  knowing once the OTP has been sent to the user - the user will be navigated to a new Screen,
           *  where is asked to enter the OTP he has received on his mobile (or) wait for the system to automatically detect the OTP
           */
          SizedBox(height: _fixedPadding * 1.5),
          RaisedButton(
            elevation: 16.0,
            onPressed: startPhoneAuth,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Masuk',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
            color: Colors.cyan[800],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
          ),
        ],
      );

  _showSnackBar(String text, Color color) {
    final snackBar = SnackBar(
      backgroundColor: color,
      content: Text('$text'),
    );
//    if (mounted) Scaffold.of(context).showSnackBar(snackBar);
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  startPhoneAuth() async {
    final phoneAuthDataProvider = Provider.of<PhoneAuthDataProvider>(context);
    final blocAuth = Provider.of<BlocAuth>(context);
    int min = 1000; //min and max values act as your 6 digit range
    int max = 9999;
    var randomizer = new Random();
    var rNum = min + randomizer.nextInt(max - min);
    var body = {
      "code_otp": rNum.toString(),
      'no_telp':
          '62' + phoneAuthDataProvider.phoneNumberController.text.toString()
    };
    if (phoneAuthDataProvider.phoneNumberController.text != '') {
      var result = await phoneAuthDataProvider.sendOtp(body);
      if (result['otp'] != 'REJECTED') {
        Flushbar(
          title: "OTP SEND",
          message: 'OTP SEND',
          duration: Duration(seconds: 5),
          backgroundColor: Colors.green,
          flushbarPosition: FlushbarPosition.BOTTOM,
          icon: Icon(
            Icons.send,
            color: Colors.white,
          ),
        )..show(context);
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (BuildContext context) => PhoneAuthVerify(
              phoneNumber: phoneAuthDataProvider.phoneNumberController.text,
            ),
          ),
        );
      } else {
        Flushbar(
          title: "OTP NOT SEND",
          message: result['otp'] + ' Invalid nomor telepon',
          duration: Duration(seconds: 5),
          backgroundColor: Colors.black,
          flushbarPosition: FlushbarPosition.BOTTOM,
          icon: Icon(
            Icons.error,
            color: Colors.white,
          ),
        )..show(context);
      }
    }
  }
}
