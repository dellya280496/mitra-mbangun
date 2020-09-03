/// subdistrict_id : "39"
/// province_id : "21"
/// province : "Nanggroe Aceh Darussalam (NAD)"
/// city_id : "3"
/// city : "Aceh Besar"
/// type : "Kabupaten"
/// subdistrict_name : "Mesjid Raya"

class SubDistricById {
  String subdistrictId;
  String provinceId;
  String province;
  String cityId;
  String city;
  String type;
  String subdistrictName;

  static SubDistricById fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    SubDistricById subDistricByIdBean = SubDistricById();
    subDistricByIdBean.subdistrictId = map['subdistrict_id'];
    subDistricByIdBean.provinceId = map['province_id'];
    subDistricByIdBean.province = map['province'];
    subDistricByIdBean.cityId = map['city_id'];
    subDistricByIdBean.city = map['city'];
    subDistricByIdBean.type = map['type'];
    subDistricByIdBean.subdistrictName = map['subdistrict_name'];
    return subDistricByIdBean;
  }

  Map toJson() => {
        "subdistrict_id": subdistrictId,
        "province_id": provinceId,
        "province": province,
        "city_id": cityId,
        "city": city,
        "type": type,
        "subdistrict_name": subdistrictName,
      };
}
