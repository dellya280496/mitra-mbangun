/// group_kategori_id : "1"
/// group_nama : "Proyek"
/// thumbdnail : "http://niagatravel.com/api/api-m-bangun-jwt-token/assets/icon/contarctor.png"
/// group_aktif : "1"

class GroupKategoriM {
  String groupKategoriId;
  String groupNama;
  String thumbdnail;
  String groupAktif;

  static GroupKategoriM fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    GroupKategoriM groupKategoriMBean = GroupKategoriM();
    groupKategoriMBean.groupKategoriId = map['group_kategori_id'];
    groupKategoriMBean.groupNama = map['group_nama'];
    groupKategoriMBean.thumbdnail = map['thumbdnail'];
    groupKategoriMBean.groupAktif = map['group_aktif'];
    return groupKategoriMBean;
  }

  Map toJson() => {
        "group_kategori_id": groupKategoriId,
        "group_nama": groupNama,
        "thumbdnail": thumbdnail,
        "group_aktif": groupAktif,
      };
}
