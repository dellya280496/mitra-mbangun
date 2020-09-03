/// id_kelurahan : "1"
/// nama_kelurahan : "BAGENDUNG"
/// id_kecamatan : "1"
/// id_kabkota : "1"
/// id_propinsi : "1"

class KelurahanM {
  String idKelurahan;
  String namaKelurahan;
  String idKecamatan;
  String idKabkota;
  String idPropinsi;

  static KelurahanM fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    KelurahanM kelurahanMBean = KelurahanM();
    kelurahanMBean.idKelurahan = map['id_kelurahan'];
    kelurahanMBean.namaKelurahan = map['nama_kelurahan'];
    kelurahanMBean.idKecamatan = map['id_kecamatan'];
    kelurahanMBean.idKabkota = map['id_kabkota'];
    kelurahanMBean.idPropinsi = map['id_propinsi'];
    return kelurahanMBean;
  }

  Map toJson() => {
        "id_kelurahan": idKelurahan,
        "nama_kelurahan": namaKelurahan,
        "id_kecamatan": idKecamatan,
        "id_kabkota": idKabkota,
        "id_propinsi": idPropinsi,
      };
}
