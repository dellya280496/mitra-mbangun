/// id_propinsi : "1"
/// nama_propinsi : "BANTEN"

class ProvinsiM {
  String idPropinsi;
  String namaPropinsi;

  static ProvinsiM fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ProvinsiM provinsiBean = ProvinsiM();
    provinsiBean.idPropinsi = map['id_propinsi'];
    provinsiBean.namaPropinsi = map['nama_propinsi'];
    return provinsiBean;
  }

  Map toJson() => {
    "id_propinsi": idPropinsi,
    "nama_propinsi": namaPropinsi,
  };
}