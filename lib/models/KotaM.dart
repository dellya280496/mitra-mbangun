/// id_kabkota : "110"
/// nama_kabkota : "ACEH BARAT"
/// id_propinsi : "8"

class KotaM {
  String idKabkota;
  String namaKabkota;
  String idPropinsi;

  static KotaM fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    KotaM kotaMBean = KotaM();
    kotaMBean.idKabkota = map['id_kabkota'];
    kotaMBean.namaKabkota = map['nama_kabkota'];
    kotaMBean.idPropinsi = map['id_propinsi'];
    return kotaMBean;
  }

  Map toJson() => {
        "id_kabkota": idKabkota,
        "nama_kabkota": namaKabkota,
        "id_propinsi": idPropinsi,
      };
}
