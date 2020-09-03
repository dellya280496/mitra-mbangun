import 'package:apps/Utils/values/radii.dart';
import 'package:apps/Utils/values/shadows.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SettingWidget extends StatelessWidget {
  void darkSwitchControll(BuildContext context) {}

  void onControlsSwitchSwitchOn1ValueChanged(BuildContext context) {}

  void onChatCustomizePressed(BuildContext context) {}

  void onNotificationPressed(BuildContext context) {}

  void onPrivacyPressed(BuildContext context) {}

  void onLogoutPressed(BuildContext context) {}
  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 200,
              margin: EdgeInsets.only(left: 15, top: 15, right: 15),
              decoration: BoxDecoration(
                boxShadow: [
                  Shadows.primaryShadow,
                ],
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 36,
                    margin: EdgeInsets.only(left: 20, top: 14, right: 9),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(179, 27, 26, 26),
                            borderRadius: Radii.k15pxRadius,
                          ),
                          child: Image.asset(
                            "assets/images/group-623.png",
                            fit: BoxFit.none,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            "Dark Mode",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "SF Pro Display",
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 51,
                          height: 32,
                          margin: EdgeInsets.only(right: 3),
                          child: Switch.adaptive(
                            value: true,
                            inactiveTrackColor: Color.fromARGB(60, 0, 0, 0),
                            onChanged: (value) {},
                            activeColor: Color.fromARGB(255, 1, 163, 164),
                            activeTrackColor: Color.fromARGB(255, 0, 128, 255),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 30,
                    margin: EdgeInsets.only(left: 20, top: 10, right: 19),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(180, 1, 57, 241),
                            borderRadius: Radii.k15pxRadius,
                          ),
                          child: Image.asset(
                            "assets/images/speech-bubbles.png",
                            fit: BoxFit.none,
                          ),
                        ),
                        Container(
                          width: 104,
                          height: 18,
                          margin: EdgeInsets.only(left: 10),
                          child: FlatButton(
                            onPressed: () =>
                                this.onChatCustomizePressed(context),
                            color: Color.fromARGB(0, 0, 0, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0)),
                            ),
                            textColor: Color.fromARGB(255, 0, 0, 0),
                            padding: EdgeInsets.all(0),
                            child: Text(
                              "Chat Customize",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: "SF Pro Display",
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 8,
                          height: 13,
                          child: Image.asset(
                            "assets/images/arrow-point-to-right.png",
                            fit: BoxFit.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 30,
                    margin: EdgeInsets.only(left: 20, top: 15, right: 19),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(194, 248, 41, 41),
                            borderRadius: Radii.k15pxRadius,
                          ),
                          child: Image.asset(
                            "assets/images/notifications-on.png",
                            fit: BoxFit.none,
                          ),
                        ),
                        Container(
                          width: 75,
                          height: 18,
                          margin: EdgeInsets.only(left: 10),
                          child: FlatButton(
                            onPressed: () =>
                                this.onNotificationPressed(context),
                            color: Color.fromARGB(0, 0, 0, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0)),
                            ),
                            textColor: Color.fromARGB(255, 0, 0, 0),
                            padding: EdgeInsets.all(0),
                            child: Text(
                              "Notification",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: "SF Pro Display",
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 8,
                          height: 13,
                          child: Image.asset(
                            "assets/images/arrow-point-to-right.png",
                            fit: BoxFit.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 30,
                    margin: EdgeInsets.only(
                        left: 20, right: 19, bottom: 20, top: 15),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(184, 173, 74, 237),
                            borderRadius: Radii.k15pxRadius,
                          ),
                          child: Image.asset(
                            "assets/images/shield.png",
                            fit: BoxFit.none,
                          ),
                        ),
                        Container(
                          width: 48,
                          height: 18,
                          margin: EdgeInsets.only(left: 10),
                          child: FlatButton(
                            onPressed: () => this.onPrivacyPressed(context),
                            color: Color.fromARGB(0, 0, 0, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0)),
                            ),
                            textColor: Color.fromARGB(255, 0, 0, 0),
                            padding: EdgeInsets.all(0),
                            child: Text(
                              "Privacy",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: "SF Pro Display",
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 8,
                          height: 13,
                          child: Image.asset(
                            "assets/images/arrow-point-to-right.png",
                            fit: BoxFit.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              margin: EdgeInsets.only(left: 15, top: 7, right: 15, bottom: 15),
              decoration: BoxDecoration(
                boxShadow: [
                  Shadows.primaryShadow,
                ],
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: FlatButton(
                onPressed: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: 87,
                      height: 30,
                      margin: EdgeInsets.only(left: 17, top: 11),
                      child: Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(221, 238, 211, 38),
                              borderRadius: Radii.k15pxRadius,
                            ),
                            child: Image.asset(
                              "assets/images/lock.png",
                              fit: BoxFit.none,
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: 46,
                            height: 18,
                            margin: EdgeInsets.only(right: 15),
                            child: Text(
                              "Keluar",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: "SF Pro Display",
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
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
    );
  }
}
