/// id_kecamatan : "2745"
/// nama_kecamatan : "2 X 11 ENAM LINGKUNG"
/// id_kabkota : "173"
/// id_propinsi : "10"

class KecamatanM {
  String idKecamatan;
  String namaKecamatan;
  String idKabkota;
  String idPropinsi;

  static KecamatanM fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    KecamatanM kecamatanMBean = KecamatanM();
    kecamatanMBean.idKecamatan = map['id_kecamatan'];
    kecamatanMBean.namaKecamatan = map['nama_kecamatan'];
    kecamatanMBean.idKabkota = map['id_kabkota'];
    kecamatanMBean.idPropinsi = map['id_propinsi'];
    return kecamatanMBean;
  }

  Map toJson() => {
        "id_kecamatan": idKecamatan,
        "nama_kecamatan": namaKecamatan,
        "id_kabkota": idKabkota,
        "id_propinsi": idPropinsi,
      };
}
