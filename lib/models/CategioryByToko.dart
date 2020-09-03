/// id : "2"
/// id_kategori : "2"
/// nama : "Bor"
/// icon : "perkakas.png"

class CategioryByToko {
  String id;
  String idKategori;
  String idToko;
  String nama;
  String icon;

  static CategioryByToko fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CategioryByToko categioryByTokoBean = CategioryByToko();
    categioryByTokoBean.id = map['id'];
    categioryByTokoBean.idKategori = map['id_kategori'];
    categioryByTokoBean.idToko = map['id_toko'];
    categioryByTokoBean.nama = map['nama'];
    categioryByTokoBean.icon = map['icon'];
    return categioryByTokoBean;
  }

  Map toJson() =>
      {
        "id": id,
        "id_kategori": idKategori,
        "id_toko": idToko,
        "nama": nama,
        "icon": icon,
      };
}
