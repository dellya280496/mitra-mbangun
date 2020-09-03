/// produkkategorisubid : "1"
/// produkkategorisubnama : "Kontraktor Rumah Tinggal"
/// produkkategoriid : "1"
/// produkkategorisubthubmnail : "https://w7.pngwing.com/pngs/864/1008/png-transparent-house-logo-real-estate-cartoon-house-angle-3d-computer-graphics-building.png"
/// produkkategorisubaktif : "1"

class SubKategoriM {
  String produkkategorisubid;
  String produkkategorisubnama;
  String produkkategoriid;
  String produkkategorisubthubmnail;
  String produkkategorisubaktif;

  static SubKategoriM fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    SubKategoriM subKategoriMBean = SubKategoriM();
    subKategoriMBean.produkkategorisubid = map['produkkategorisubid'];
    subKategoriMBean.produkkategorisubnama = map['produkkategorisubnama'];
    subKategoriMBean.produkkategoriid = map['produkkategoriid'];
    subKategoriMBean.produkkategorisubthubmnail =
        map['produkkategorisubthubmnail'];
    subKategoriMBean.produkkategorisubaktif = map['produkkategorisubaktif'];
    return subKategoriMBean;
  }

  Map toJson() => {
        "produkkategorisubid": produkkategorisubid,
        "produkkategorisubnama": produkkategorisubnama,
        "produkkategoriid": produkkategoriid,
        "produkkategorisubthubmnail": produkkategorisubthubmnail,
        "produkkategorisubaktif": produkkategorisubaktif,
      };
}
