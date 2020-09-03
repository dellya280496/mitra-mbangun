/// kategori_id : "1"
/// kategori_nama : "Kontraktor"
/// is_aktif : "0"
/// kategori_thumbnail : "http://niagatravel.com/api/api-m-bangun-jwt-token/assets/icon/contarctor.png"
/// kategori_flag : "Mitra"
/// parant_id : null

class KategoriM {
  String kategoriId;
  String kategoriNama;
  String isAktif;
  String kategoriThumbnail;
  String kategoriFlag;
  dynamic parantId;

  static KategoriM fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    KategoriM kategoriMBean = KategoriM();
    kategoriMBean.kategoriId = map['kategori_id'];
    kategoriMBean.kategoriNama = map['kategori_nama'];
    kategoriMBean.isAktif = map['is_aktif'];
    kategoriMBean.kategoriThumbnail = map['kategori_thumbnail'];
    kategoriMBean.kategoriFlag = map['kategori_flag'];
    kategoriMBean.parantId = map['parant_id'];
    return kategoriMBean;
  }

  Map toJson() => {
        "kategori_id": kategoriId,
        "kategori_nama": kategoriNama,
        "is_aktif": isAktif,
        "kategori_thumbnail": kategoriThumbnail,
        "kategori_flag": kategoriFlag,
        "parant_id": parantId,
      };
}