//import 'package:apps/providers/BlocAuth.dart';
//import 'package:flutter/material.dart';
//import 'package:gender_selection/gender_selection.dart';
//import 'package:intl/intl.dart';
//import 'package:provider/provider.dart';
//import 'package:rounded_loading_button/rounded_loading_button.dart';
//
//class WidgetPendaftaran extends StatefulWidget {
//  WidgetPendaftaran({Key key}) : super(key: key);
//
//  @override
//  _WidgetPendaftaranState createState() {
//    return _WidgetPendaftaranState();
//  }
//}
//
//class _WidgetPendaftaranState extends State<WidgetPendaftaran> {
//  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
//  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//  String nama, email, no_hp, tempat_lahir, jenis_kelamin, password;
//  DateTime selectedDate = DateTime.now();
//  bool validEmail = false;
//  bool validTelp = false;
//
//  @override
//  void initState() {
//    super.initState();
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
//    return SingleChildScrollView(
//      child: Form(
//        key: _formKey,
//        autovalidate: true,
//        child: Padding(
//          padding: const EdgeInsets.only(top: 20.0, bottom: 70),
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            mainAxisSize: MainAxisSize.max,
//            children: <Widget>[
//              Padding(
//                padding: const EdgeInsets.only(left: 40.0),
//                child: Text(
//                  "Nama Lengkap",
//                  style: TextStyle(color: Colors.grey, fontSize: 16.0),
//                ),
//              ),
//              Container(
//                decoration: BoxDecoration(
//                  border: Border.all(
//                    color: Colors.grey.withOpacity(0.5),
//                    width: 1.0,
//                  ),
//                  borderRadius: BorderRadius.circular(20.0),
//                ),
//                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                child: Row(
//                  children: <Widget>[
//                    new Padding(
//                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
//                      child: Icon(
//                        Icons.person_outline,
//                        color: Colors.grey,
//                      ),
//                    ),
//                    Container(
//                      height: 30.0,
//                      width: 1.0,
//                      color: Colors.grey.withOpacity(0.5),
//                      margin: const EdgeInsets.only(left: 00.0, right: 10.0),
//                    ),
//                    new Expanded(
//                      child: TextFormField(
//                        onSaved: (value) {
//                          setState(() {
//                            nama = value;
//                          });
//                        },
//                        keyboardType: TextInputType.text,
//                        validator: (String arg) {
//                          if (arg.length < 1)
//                            return 'Nama Harus di isi';
//                          else
//                            return null;
//                        },
//                        decoration: InputDecoration(
//                          border: InputBorder.none,
//                          hintText: 'Enter your name',
//                          hintStyle: TextStyle(color: Colors.grey),
//                        ),
//                      ),
//                    )
//                  ],
//                ),
//              ),
//              Padding(
//                padding: const EdgeInsets.only(left: 40.0),
//                child: Text(
//                  "Email",
//                  style: TextStyle(color: Colors.grey, fontSize: 16.0),
//                ),
//              ),
//              Container(
//                decoration: BoxDecoration(
//                  border: Border.all(
//                    color: Colors.grey.withOpacity(0.5),
//                    width: 1.0,
//                  ),
//                  borderRadius: BorderRadius.circular(20.0),
//                ),
//                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                child: Row(
//                  children: <Widget>[
//                    new Padding(
//                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
//                      child: Icon(
//                        Icons.email,
//                        color: Colors.grey,
//                      ),
//                    ),
//                    Container(
//                      height: 30.0,
//                      width: 1.0,
//                      color: Colors.grey.withOpacity(0.5),
//                      margin: const EdgeInsets.only(left: 00.0, right: 10.0),
//                    ),
//                    new Expanded(
//                      child: TextFormField(
//                        enabled: false,
//                        initialValue: blocAuth.currentUser.email,
//                        keyboardType: TextInputType.emailAddress,
//                        validator: (String arg) {
//                          if (arg.length < 1)
//                            return 'Email harus di isi';
//                          else
//                            return null;
//                        },
//                        decoration: InputDecoration(
//                          border: InputBorder.none,
//                          hintText: 'Masukkan email anda',
//                          errorText: !validTelp ? null : 'Email sudah di gunakan',
//                          hintStyle: TextStyle(color: Colors.grey),
//                        ),
//                      ),
//                    )
//                  ],
//                ),
//              ),
//              Padding(
//                padding: const EdgeInsets.only(left: 40.0),
//                child: Text(
//                  "No Telpon",
//                  style: TextStyle(color: Colors.grey, fontSize: 16.0),
//                ),
//              ),
//              Container(
//                decoration: BoxDecoration(
//                  border: Border.all(
//                    color: Colors.grey.withOpacity(0.5),
//                    width: 1.0,
//                  ),
//                  borderRadius: BorderRadius.circular(20.0),
//                ),
//                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                child: Row(
//                  children: <Widget>[
//                    new Padding(
//                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
//                      child: Icon(
//                        Icons.phone,
//                        color: Colors.grey,
//                      ),
//                    ),
//                    Container(
//                      height: 30.0,
//                      width: 1.0,
//                      color: Colors.grey.withOpacity(0.5),
//                      margin: const EdgeInsets.only(left: 00.0, right: 10.0),
//                    ),
//                    new Expanded(
//                      child: TextFormField(
////                        focusNode: myFocusNodeUsertelp,
////                        controller: usertelpController,
//                        onSaved: (value) {
//                          setState(() {
//                            no_hp = value;
//                          });
//                        },
//                        keyboardType: TextInputType.phone,
//                        validator: (String arg) {
//                          if (arg.length < 1)
//                            return 'Telpon Harus di isi';
//                          else
//                            return null;
//                        },
//                        decoration: InputDecoration(
//                          border: InputBorder.none,
//                          hintText: 'Enter your phone',
//                          errorText: !validTelp ? null : 'Telpon sudah di gunakan',
//                          hintStyle: TextStyle(color: Colors.grey),
//                        ),
//                      ),
//                    )
//                  ],
//                ),
//              ),
//              Padding(
//                padding: const EdgeInsets.only(left: 40.0),
//                child: Text(
//                  "Tanggal Lahir",
//                  style: TextStyle(color: Colors.grey, fontSize: 16.0),
//                ),
//              ),
//              Container(
//                decoration: BoxDecoration(
//                  border: Border.all(
//                    color: Colors.grey.withOpacity(0.5),
//                    width: 1.0,
//                  ),
//                  borderRadius: BorderRadius.circular(20.0),
//                ),
//                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                child: Row(
//                  children: <Widget>[
//                    new Padding(
//                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
//                      child: Icon(
//                        Icons.date_range,
//                        color: Colors.grey,
//                      ),
//                    ),
//                    Container(
//                      height: 30.0,
//                      width: 1.0,
//                      color: Colors.grey.withOpacity(0.5),
//                      margin: const EdgeInsets.only(left: 00.0, right: 10.0),
//                    ),
//                    new Container(
//                        child: FlatButton(
//                            onPressed: () async {
//                              final DateTime picked = await showDatePicker(context: context, initialDate: selectedDate, firstDate: DateTime(1980, 8), lastDate: DateTime(2101));
//                              if (picked != null && picked != selectedDate)
//                                setState(() {
//                                  selectedDate = picked;
//                                });
//                            },
//                            child: Text(
//                              '${DateFormat('dd/MM/yyyy').format(selectedDate)}',
//                              textAlign: TextAlign.left,
//                              style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),
//                            )))
//                  ],
//                ),
//              ),
//              Padding(
//                padding: const EdgeInsets.only(left: 40.0),
//                child: Text(
//                  "Jenis Kelamin",
//                  style: TextStyle(color: Colors.grey, fontSize: 16.0),
//                ),
//              ),
//              Container(
//                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                child: Column(
//                  children: <Widget>[
//                    GenderSelection(
//                      femaleImage: NetworkImage("https://cdn1.iconfinder.com/data/icons/website-internet/48/website_-_female_user-512.png"),
//                      maleImage: NetworkImage("https://icon-library.net/images/avatar-icon/avatar-icon-4.jpg"),
//                      selectedGenderIconBackgroundColor: Colors.amber,
//                      femaleText: 'Perempuan',
//                      onChanged: (value) {
//                        if (value.toString() == "Gender.Male") {
//                          jenis_kelamin = "L";
//                        } else if (value.toString() == "Gender.Female") {
//                          jenis_kelamin = "P";
//                        }
//                      },
//                      maleText: 'Laki-laki',
//                      selectedGenderTextStyle: TextStyle(color: Colors.amber, fontSize: 19, fontWeight: FontWeight.bold),
//                    ),
//                  ],
//                ),
//              ),
//              Padding(
//                padding: const EdgeInsets.only(left: 40.0),
//                child: Text(
//                  "Tempat Lahir",
//                  style: TextStyle(color: Colors.grey, fontSize: 16.0),
//                ),
//              ),
//              Container(
//                decoration: BoxDecoration(
//                  border: Border.all(
//                    color: Colors.grey.withOpacity(0.5),
//                    width: 1.0,
//                  ),
//                  borderRadius: BorderRadius.circular(20.0),
//                ),
//                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                child: Row(
//                  children: <Widget>[
//                    new Padding(
//                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
//                      child: Icon(
//                        Icons.location_on,
//                        color: Colors.grey,
//                      ),
//                    ),
//                    Container(
//                      height: 30.0,
//                      width: 1.0,
//                      color: Colors.grey.withOpacity(0.5),
//                      margin: const EdgeInsets.only(left: 00.0, right: 10.0),
//                    ),
//                    new Expanded(
//                      child: TextFormField(
////                        focusNode: myFocusNodeEmailLogin,
////                        controller: loginEmailController,
//                        onSaved: (value) {
//                          setState(() {
//                            tempat_lahir = value;
//                          });
//                        },
//                        keyboardType: TextInputType.text,
//                        validator: (String arg) {
//                          if (arg.length < 1)
//                            return 'Tempat Lahir Harus di isi';
//                          else
//                            return null;
//                        },
//                        decoration: InputDecoration(
//                          border: InputBorder.none,
//                          errorText: !validEmail ? null : 'Tempat lahir harus di isi',
//                          hintText: 'Masukkan tempat lahir anda',
//                          hintStyle: TextStyle(color: Colors.grey),
//                        ),
//                      ),
//                    )
//                  ],
//                ),
//              ),
//              Padding(
//                padding: const EdgeInsets.only(left: 40.0),
//                child: Text(
//                  "Password",
//                  style: TextStyle(color: Colors.grey, fontSize: 16.0),
//                ),
//              ),
//              Container(
//                decoration: BoxDecoration(
//                  border: Border.all(
//                    color: Colors.grey.withOpacity(0.5),
//                    width: 1.0,
//                  ),
//                  borderRadius: BorderRadius.circular(20.0),
//                ),
//                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                child: Row(
//                  children: <Widget>[
//                    new Padding(
//                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
//                      child: Icon(
//                        Icons.lock_open,
//                        color: Colors.grey,
//                      ),
//                    ),
//                    Container(
//                      height: 30.0,
//                      width: 1.0,
//                      color: Colors.grey.withOpacity(0.5),
//                      margin: const EdgeInsets.only(left: 00.0, right: 10.0),
//                    ),
//                    new Expanded(
//                      child: TextFormField(
////                        focusNode: myFocusNodePasswordLogin,
////                        controller: loginPasswordController,
//                        onSaved: (value) {
//                          setState(() {
//                            password = value;
//                          });
//                        },
//                        keyboardType: TextInputType.text,
//                        validator: (String arg) {
//                          if (arg.length < 6)
//                            return 'Password minimal harus 6 karakter';
//                          else
//                            return null;
//                        },
//                        obscureText: true,
//                        decoration: InputDecoration(
//                          border: InputBorder.none,
//                          hintText: 'Enter your password',
//                          hintStyle: TextStyle(color: Colors.grey),
//                        ),
//                      ),
//                    )
//                  ],
//                ),
//              ),
//              Container(
//                margin: const EdgeInsets.only(top: 20.0),
//                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//                child: new Row(
//                  children: <Widget>[
//                    new Expanded(
//                        child: RoundedLoadingButton(
//                      child: Text('DAFTAR', style: TextStyle(color: Colors.white)),
//                      color: Color(0xFFb16a085),
//                      controller: _btnController,
//                      onPressed: () {
//                        _formKey.currentState.save();
//                        _daftar();
//                      },
//                    )),
//                  ],
//                ),
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//
//  _daftar() async {
//    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
//    _formKey.currentState.validate();
//    var map = new Map<String, String>();
//    map['nama'] = nama;
//    map['email'] = blocAuth.currentUser.email;
//    map['no_hp'] = no_hp;
//    map['tempat_lahir'] = tempat_lahir;
//    map['tgl_lahir'] = DateFormat('yyyy-MM-dd').format(selectedDate);
//    map['jenis_kelamin'] = jenis_kelamin;
//    map['password'] = password;
//    map['id_google'] = blocAuth.currentUser.id;
//    map['foto'] = blocAuth.currentUser.photoUrl;
//    if (_formKey.currentState.validate()) {
//      var response = await blocAuth.create(map);
//      if (response['meta']['success']) {
//        _btnController.success();
//        _showToast(response['meta']['status_message']);
//        _btnController.stop();
//      } else {
//        _btnController.stop();
//        _showToast(response['meta']['status_message']);
//      }
//    } else {
//      _btnController.reset();
//    }
//  }
//
//  void _showToast(String message) {
//    final scaffold = Scaffold.of(context);
//    scaffold.showSnackBar(
//      SnackBar(
//        backgroundColor: Colors.red,
//        content: Text(message),
//      ),
//    );
//  }
//
//  _openLogin(prop) {
//    Navigator.pop(context, prop);
//  }
//
//  String validateEmail(String value) {
//    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//    RegExp regex = new RegExp(pattern);
//    if (!regex.hasMatch(value)) return 'Format Email tidak valid';
//  }
//}
//
//class MyClipper extends CustomClipper<Path> {
//  @override
//  Path getClip(Size size) {
//    Path p = new Path();
//    p.lineTo(size.width, 0.0);
//    p.lineTo(size.width, size.height * 0.85);
//    p.arcToPoint(
//      Offset(0.0, size.height * 0.85),
//      radius: const Radius.elliptical(50.0, 10.0),
//      rotation: 0.0,
//    );
//    p.lineTo(0.0, 0.0);
//    p.close();
//    return p;
//  }
//
//  @override
//  bool shouldReclip(CustomClipper oldClipper) {
//    return true;
//  }
//}
