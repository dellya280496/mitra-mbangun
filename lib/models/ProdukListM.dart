/// usernamalengkap : ""
/// produknama : "Jasa Kontraktor"
/// produkid : "1"
/// produkstokawal : "1"
/// produkstokakhir : "0"
/// userid : "1"
/// produkdeskripsi : "Jasa kontraktor surabaya dengan pengalaman sudah menjanjikan"
/// produkthumbnail : "https://w7.pngwing.com/pngs/864/1008/png-transparent-house-logo-real-estate-cartoon-house-angle-3d-computer-graphics-building.png"
/// produkcreate : "2020-06-01 16:44:01"
/// produkfoto1 : null
/// produkfoto2 : null
/// produkfoto3 : null
/// produkfoto4 : null
/// produkkategorisubid : "1"
/// id_provinsi : "1"
/// id_kota : "1"
/// id_kecamatan : "1"
/// produkaktif : "1"

class ProdukListM {
  String usernamalengkap;
  String produknama;
  String produkharga;
  String produkkondisi;
  String produkid;
  String produkstokawal;
  String produkstokakhir;
  String userid;
  String produkdeskripsi;
  String produkthumbnail;
  String produkcreate;
  dynamic produkfoto1;
  dynamic produkfoto2;
  dynamic produkfoto3;
  dynamic produkfoto4;
  String produkkategorisubid;
  String idProvinsi;
  String idKota;
  String idKecamatan;
  String produkaktif;
  String nama_propinsi;
  String nama_kabkota;
  String nama_kecamatan;
  String statusnama;
  String produkwaktupengerjaan;
  String produkbudget;

  static ProdukListM fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ProdukListM produkListMBean = ProdukListM();
    produkListMBean.usernamalengkap = map['usernamalengkap'];
    produkListMBean.produknama = map['produknama'];
    produkListMBean.produkharga = map['produkharga'];
    produkListMBean.produkkondisi = map['produkkondisi'];
    produkListMBean.produkid = map['produkid'];
    produkListMBean.produkstokawal = map['produkstokawal'];
    produkListMBean.produkstokakhir = map['produkstokakhir'];
    produkListMBean.userid = map['userid'];
    produkListMBean.produkdeskripsi = map['produkdeskripsi'];
    produkListMBean.produkthumbnail = map['produkthumbnail'];
    produkListMBean.produkcreate = map['produkcreate'];
    produkListMBean.produkfoto1 = map['produkfoto1'];
    produkListMBean.produkfoto2 = map['produkfoto2'];
    produkListMBean.produkfoto3 = map['produkfoto3'];
    produkListMBean.produkfoto4 = map['produkfoto4'];
    produkListMBean.produkkategorisubid = map['produkkategorisubid'];
    produkListMBean.idProvinsi = map['id_provinsi'];
    produkListMBean.idKota = map['id_kota'];
    produkListMBean.idKecamatan = map['id_kecamatan'];
    produkListMBean.produkaktif = map['produkaktif'];
    produkListMBean.nama_propinsi = map['nama_propinsi'];
    produkListMBean.nama_kabkota = map['nama_kabkota'];
    produkListMBean.nama_kecamatan = map['nama_kecamatan'];
    produkListMBean.statusnama = map['statusnama'];
    produkListMBean.produkwaktupengerjaan = map['produkwaktupengerjaan'];
    produkListMBean.produkbudget = map['produkbudget'];
    return produkListMBean;
  }

  Map toJson() => {
        "usernamalengkap": usernamalengkap,
        "produknama": produknama,
        "produkharga": produkharga,
        "produkkondisi": produkkondisi,
        "produkid": produkid,
        "produkstokawal": produkstokawal,
        "produkstokakhir": produkstokakhir,
        "userid": userid,
        "produkdeskripsi": produkdeskripsi,
        "produkthumbnail": produkthumbnail,
        "produkcreate": produkcreate,
        "produkfoto1": produkfoto1,
        "produkfoto2": produkfoto2,
        "produkfoto3": produkfoto3,
        "produkfoto4": produkfoto4,
        "produkkategorisubid": produkkategorisubid,
        "id_provinsi": idProvinsi,
        "id_kota": idKota,
        "id_kecamatan": idKecamatan,
        "produkaktif": produkaktif,
        "nama_propinsi": nama_propinsi,
        "nama_kabkota": nama_kabkota,
        "nama_kecamatan": nama_kecamatan,
        "statusnama": statusnama,
        "produkwaktupengerjaan": produkwaktupengerjaan,
        "produkbudget": produkbudget,
      };
}
