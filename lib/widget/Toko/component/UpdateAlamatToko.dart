import 'package:apps/models/City.dart';
import 'package:apps/models/Provice.dart';
import 'package:apps/models/SubDistrict.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateAlamatToko extends StatelessWidget {
  UpdateAlamatToko({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
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
          ],
        ),
      ],
    );
  }

  void _simpanKota(BuildContext context) {}
}
