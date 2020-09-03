import 'dart:convert';
import 'dart:io';

import 'package:apps/Api/Api.dart';
import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class WidgetProfile extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<WidgetProfile> with SingleTickerProviderStateMixin {
  bool _status = true;
  File _imageFile;

  final FocusNode myFocusNode = FocusNode();
  TextEditingController inputEmailController = new TextEditingController();
  TextEditingController inputNamaController = new TextEditingController();
  TextEditingController inputNoTelpController = new TextEditingController();
  TextEditingController inputPasswordController = new TextEditingController();
  TextEditingController inputPinController = new TextEditingController();
  TextEditingController inputAlamatController = new TextEditingController();

  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeNama = FocusNode();
  final FocusNode myFocusNodeNoTelp = FocusNode();
  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodePin = FocusNode();
  final FocusNode myFocusNodeAlamat = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  void _getImage(BuildContext context, ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source, maxWidth: 250, maxHeight: 250, imageQuality: 50);
    simpanFoto(image);
    setState(() {
      _imageFile = image;
    });
    // Closes the bottom sheet
    Navigator.pop(context);
  }

  void _openImagePickerModal(BuildContext context) {
    final flatButtonColor = Theme.of(context).primaryColor;
    print('Image Picker Modal Called');
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Pick an image',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                FlatButton(
                  textColor: Colors.red,
                  child: Text('Use Camera'),
                  onPressed: () {
                    _getImage(context, ImageSource.camera);
                  },
                ),
                FlatButton(
                  textColor: Colors.red,
                  child: Text('Use Gallery'),
                  onPressed: () {
                    _getImage(context, ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        });
  }

  void getUserData() async {
    await new Future.delayed(const Duration(seconds: 1));
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    setState(() {
//      inputEmailController.text = blocProfile;
//      inputNamaController.text = dataProvider.userNama;
//      inputNoTelpController.text = dataProvider.userNotelp;
    });
  }

  Widget _buildTitle() {
    return Text(
      "Edit Account",
      style: TextStyle(
          fontSize: 25,
//          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'WorkSansSemiBold'),
    );
  }

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    return new Scaffold(
        appBar: AppBar(
          title: _buildTitle(),
          elevation: 0,
//          backgroundColor: Color(0xff10ac84),
        ),
        body: new ModalProgressHUD(
            inAsyncCall: dataProvider.isLoading,
            child: Container(
              child: new ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      new Container(
                        height: 180.0,
                        decoration: BoxDecoration(
//                        color: Color(0xff10ac84),
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(56), bottomLeft: Radius.circular(56))),
                        child: new Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 40.0),
                              child: new Stack(
                                fit: StackFit.loose,
                                children: <Widget>[
                                  new Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Container(
                                          width: 100.0,
                                          height: 100.0,
                                          child: ClipOval(
                                            child: Image.network(
                                              blocAuth.currentUser.photoUrl,
                                              fit: BoxFit.cover,
                                              width: 150,
                                            ),
                                          )),
                                    ],
                                  ),
//              Padding(
//                padding: EdgeInsets.only(top: 70.0, right: 70.0),
//                child: InkWell(
//                    onTap: () => _openImagePickerModal(context),
//                    child: new Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: <Widget>[
//                        new CircleAvatar(
//                          backgroundColor: Colors.red,
//                          radius: 25.0,
//                          child: new Icon(
//                            Icons.camera_alt,
//                            color: Colors.white,
//                          ),
//                        )
//                      ],
//                    )),
//              )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      new Container(
//                    color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 25.0, top: 10),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Parsonal Information',
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      new Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          _status ? _getEditIcon() : new Container(),
                                        ],
                                      )
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          _status
                                              ? new Text('Nama', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.grey))
                                              : new Text('Nama', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black))
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new TextField(
                                          focusNode: myFocusNodeNama,
                                          controller: inputNamaController,
                                          style: _status
                                              ? TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.grey)
                                              : TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black),
                                          decoration: const InputDecoration(
                                            hintText: "Enter Your Nama",
                                            hintStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.grey),
                                          ),
                                          enabled: !_status,
                                          autofocus: !_status,
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text('Email ID',
                                              style: _status
                                                  ? TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.grey)
                                                  : TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.grey)),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new TextField(
                                          focusNode: myFocusNodeEmail,
                                          controller: inputEmailController,
                                          keyboardType: TextInputType.text,
                                          style: _status
                                              ? TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.grey)
                                              : TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.grey),
                                          decoration: const InputDecoration(
                                              hintText: "Enter Email ID", hintStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.grey)),
                                          enabled: false,
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'No Telepon',
                                            style: _status
                                                ? TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.grey)
                                                : TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new TextField(
                                          focusNode: myFocusNodeNoTelp,
                                          controller: inputNoTelpController,
                                          keyboardType: TextInputType.number,
                                          style: _status
                                              ? TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.grey)
                                              : TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black),
                                          decoration:
                                              const InputDecoration(hintText: "Telepon", hintStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.grey)),
                                          enabled: !_status,
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          child: new Text(
                                            'Password',
                                            style: _status
                                                ? TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.grey)
                                                : TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black),
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: new TextField(
                                            obscureText: true,
                                            focusNode: myFocusNodePassword,
                                            controller: inputPasswordController,
                                            style: _status
                                                ? TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.grey)
                                                : TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black),
                                            decoration: const InputDecoration(
                                                hintText: "Kosongkan jika tidak ingin merubah password",
                                                hintStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.grey)),
                                            enabled: !_status,
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                    ],
                                  )),
                              !_status ? _getActionButtons() : new Container(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  void simpanFoto(image) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    dataProvider.setLoading(true);
    Api.uploadImage(image, dataProvider.userId).then((response) {
      var data = json.decode(response.body);
      print(data);
      if (data['status'] == true) {
        Flushbar(
          title: "Sukses",
          message: data['message'],
          duration: Duration(seconds: 5),
          backgroundColor: Colors.green,
          flushbarPosition: FlushbarPosition.TOP,
          icon: Icon(
            Icons.assignment_turned_in,
            color: Colors.white,
          ),
        )
          ..show(context);
        dataProvider.getProfile();
        dataProvider.setLoading(false);
      }
    });
  }

  void keluar() {
    LocalStorage.sharedInstance.deleteValue('session');
    Navigator.of(context).pushReplacementNamed('/main');
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: Container(
                child: new RaisedButton(
                  child: new Text("Batal"),
                  textColor: Colors.white,
                  color: Colors.red,
                  onPressed: () {
                    setState(() {
                      _status = true;
                      FocusScope.of(context).requestFocus(new FocusNode());
                    });
                  },
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                )),
            flex: 2,
          ),
          Expanded(
            child: Container(
                child: new RaisedButton(
                  child: new Text("Simpan"),
                  textColor: Colors.white,
                  color: Color(0xffb16a085),
                  onPressed: () {
                    setState(() {
                      _status = true;
                      FocusScope.of(context).requestFocus(new FocusNode());
                      simpanDataProfile();
                    });
                  },
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                )),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }

  void simpanDataProfile() {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    dataProvider.setLoading(true);
    var map = new Map<String, dynamic>();
    map['usernamalengkap'] = inputNamaController.text;
    map['userpassword'] = inputPasswordController.text;
    map['usertelp'] = inputNoTelpController.text;
    map['userid'] = dataProvider.userId;
    Api.simpanDataProfile(map).then((response) {
      var data = json.decode(response.body);
      print(data);
      if (data['status'] == true) {
        Flushbar(
          title: "Sukses",
          message: data['message'],
          duration: Duration(seconds: 5),
          backgroundColor: Colors.green,
          flushbarPosition: FlushbarPosition.TOP,
          icon: Icon(
            Icons.assignment_turned_in,
            color: Colors.white,
          ),
        )
          ..show(context);
        dataProvider.getProfile();
        dataProvider.setLoading(false);
      }
    });
  }
}
