import 'package:apps/models/City.dart';
import 'package:apps/models/Provice.dart';
import 'package:apps/models/SubDistrict.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class WidgetAddAddress extends StatefulWidget {
  WidgetAddAddress({Key key}) : super(key: key);

  @override
  _WidgetAddAddressState createState() => _WidgetAddAddressState();
}

class _WidgetAddAddressState extends State<WidgetAddAddress> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
  String nama_penerima, no_hp, id_kecamatan, alamat_lengkap, default_alamat, id_user, nama_alamat;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text('Tambah Alamat'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            autovalidate: false,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: TextFormField(
                    onSaved: (value) {
                      setState(() {
                        nama_alamat = value;
                      });
                    },
                    keyboardType: TextInputType.text,
                    validator: (String arg) {
                      if (arg.length < 1)
                        return 'Nama harus di isi';
                      else
                        return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      labelText: "Nama alamat",
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      hintText: 'Rumah, Kantor, Apartemen',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: TextFormField(
                    onSaved: (value) {
                      setState(() {
                        nama_penerima = value;
                      });
                    },
                    keyboardType: TextInputType.text,
                    validator: (String arg) {
                      if (arg.length < 1)
                        return 'Nama penerima harus di isi';
                      else
                        return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      labelText: "Nama penerima",
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      hintText: 'nama penerima',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: TextFormField(
                    onSaved: (value) {
                      setState(() {
                        no_hp = value;
                      });
                    },
                    keyboardType: TextInputType.phone,
                    validator: (String arg) {
                      if (arg.length < 1)
                        return 'No.phone harus di isi';
                      else
                        return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      labelText: "No.phone",
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      hintText: 'No.phone',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 10,
                  child: DropdownButtonFormField<String>(
                    isDense: true,
                    hint: new Text(
                      "Pilih Provinsi",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    value: blocProfile.id_provice,
                    validator: (String arg) {
                      if (arg == null)
                        return 'Harus di isi';
                      else
                        return null;
                    },
                    onChanged: (String value) {
                      blocProfile.setIdProvince(value);
                    },
                    items: blocProfile.listProvice.isEmpty
                        ? null
                        : blocProfile.listProvice[0].rajaongkir.results.map((ResultsBean item) {
                            return new DropdownMenuItem<String>(
                              value: item.provinceId,
                              child: new Text(
                                item.province.toString(),
                                style: TextStyle(fontSize: 12),
                              ),
                            );
                          }).toList(),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 10,
                  child: DropdownButtonFormField<String>(
                    isDense: true,
                    hint: new Text(
                      "Pilih Kota",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    value: blocProfile.id_city,
                    validator: (String arg) {
                      if (arg == null)
                        return 'Harus di isi';
                      else
                        return null;
                    },
                    onChanged: (String value) {
                      blocProfile.setIdCity(value);
                    },
                    items: blocProfile.listCity.isEmpty
                        ? null
                        : blocProfile.listCity[0].rajaongkir.results.map((ResultsBeanCity item) {
                            return new DropdownMenuItem<String>(
                              value: item.cityId,
                              child: new Text(
                                item.cityName.toString(),
                                style: TextStyle(fontSize: 12),
                              ),
                            );
                          }).toList(),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 10,
                  child: DropdownButtonFormField<String>(
                    isDense: true,
                    hint: new Text(
                      "Pilih Kecamatan",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    value: blocProfile.id_subdistrict,
                    validator: (String arg) {
                      if (arg == null)
                        return 'Harus di isi';
                      else
                        return null;
                    },
                    onChanged: (String value) {
                      blocProfile.setIdSubistrict(value);
                    },
                    items: blocProfile.listSubDistrict.isEmpty
                        ? null
                        : blocProfile.listSubDistrict[0].rajaongkir.results.map((ResultsBeanSubdistrict item) {
                            return new DropdownMenuItem<String>(
                              value: item.subdistrictId,
                              child: new Text(
                                item.subdistrictName.toString(),
                                style: TextStyle(fontSize: 12),
                              ),
                            );
                          }).toList(),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: TextFormField(
                    onSaved: (value) {
                      setState(() {
                        alamat_lengkap = value;
                      });
                    },
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    validator: (String arg) {
                      if (arg.length < 1)
                        return 'Alamat lengkap harus di isi';
                      else
                        return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      labelText: "Alamat lengkap",
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      hintText: 'alamat lengkap',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                          child: RoundedLoadingButton(
                            child: Text('Simpan', style: TextStyle(color: Colors.white)),
                        color: Color(0xFFb16a085),
                        controller: _btnController,
                        onPressed: () {
                          _formKey.currentState.save();
                          _simpan();
                        },
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _simpan() async {
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    var validate = _formKey.currentState.validate();
    var body = {
      "nama_penerima": nama_penerima.toString(),
      "no_hp": no_hp.toString(),
      "id_kecamatan": blocProfile.id_subdistrict.toString(),
      "alamat_lengkap": alamat_lengkap.toString(),
      "default": '0',
      "id_user": blocAuth.idUser.toString(),
      "nama_alamat": nama_alamat.toString()
    };
    if (validate) {
      var result = blocProfile.createShippingAddress(body);
      result.then((value) async {
        if (value) {
          _btnController.success();
          await new Future.delayed(const Duration(seconds: 1));
          Navigator.pop(context);
        } else {
          _btnController.error();
          await new Future.delayed(const Duration(seconds: 1));
          _btnController.reset();
        }
      });
    } else {
      _btnController.error();
      await new Future.delayed(const Duration(seconds: 1));
      _btnController.reset();
    }
  }
}
