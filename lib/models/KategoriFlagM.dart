/// flag : "proyek"
/// chilrdern : [{"produkkategoriid":"1","produkkategorinama":"Kontraktor","produkkategoriaktif":"1","produkkategorithumbnail":"http://niagatravel.com/api/api-m-bangun-jwt-token/assets/icon/contarctor.png","produkkategoriakses":"1","produkkategorireq":"1","produkkategoriflag":"proyek"},{"produkkategoriid":"2","produkkategorinama":"Jasa","produkkategoriaktif":"1","produkkategorithumbnail":"http://niagatravel.com/api/api-m-bangun-jwt-token/assets/icon/pemborong.png","produkkategoriakses":"1","produkkategorireq":"1","produkkategoriflag":"proyek"},{"produkkategoriid":"3","produkkategorinama":"Konsultan","produkkategoriaktif":"1","produkkategorithumbnail":"http://niagatravel.com/api/api-m-bangun-jwt-token/assets/icon/konsultasi.png","produkkategoriakses":"1","produkkategorireq":"1","produkkategoriflag":"proyek"},{"produkkategoriid":"7","produkkategorinama":"Interior","produkkategoriaktif":"1","produkkategorithumbnail":"http://niagatravel.com/api/api-m-bangun-jwt-token/assets/icon/interior.png","produkkategoriakses":"1","produkkategorireq":"1","produkkategoriflag":"proyek"}]

class KategoriFlagM {
  String flag;
  List<ChilrdernBean> chilrdern;

  static KategoriFlagM fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    KategoriFlagM kategoriFlagMBean = KategoriFlagM();
    kategoriFlagMBean.flag = map['flag'];
    kategoriFlagMBean.chilrdern = List()..addAll((map['chilrdern'] as List ?? []).map((o) => ChilrdernBean.fromMap(o)));
    return kategoriFlagMBean;
  }

  Map toJson() => {
        "flag": flag,
        "chilrdern": chilrdern,
      };
}

/// produkkategoriid : "1"
/// produkkategorinama : "Kontraktor"
/// produkkategoriaktif : "1"
/// produkkategorithumbnail : "http://niagatravel.com/api/api-m-bangun-jwt-token/assets/icon/contarctor.png"
/// produkkategoriakses : "1"
/// produkkategorireq : "1"
/// produkkategoriflag : "proyek"

class ChilrdernBean {
  String produkkategoriid;
  String produkkategorinama;
  String produkkategoriaktif;
  String produkkategorithumbnail;
  String produkkategoriakses;
  String produkkategorireq;
  String produkkategoriflag;

  static ChilrdernBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ChilrdernBean chilrdernBean = ChilrdernBean();
    chilrdernBean.produkkategoriid = map['produkkategoriid'];
    chilrdernBean.produkkategorinama = map['produkkategorinama'];
    chilrdernBean.produkkategoriaktif = map['produkkategoriaktif'];
    chilrdernBean.produkkategorithumbnail = map['produkkategorithumbnail'];
    chilrdernBean.produkkategoriakses = map['produkkategoriakses'];
    chilrdernBean.produkkategorireq = map['produkkategorireq'];
    chilrdernBean.produkkategoriflag = map['produkkategoriflag'];
    return chilrdernBean;
  }

  Map toJson() => {
        "produkkategoriid": produkkategoriid,
        "produkkategorinama": produkkategorinama,
        "produkkategoriaktif": produkkategoriaktif,
        "produkkategorithumbnail": produkkategorithumbnail,
        "produkkategoriakses": produkkategoriakses,
        "produkkategorireq": produkkategorireq,
        "produkkategoriflag": produkkategoriflag,
      };
}
