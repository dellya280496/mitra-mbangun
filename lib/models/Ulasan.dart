/// id : "2"
/// id_order : "71"
/// id_produk : "29"
/// id_user_login : "45"
/// created_at : "2020-08-15 17:08:03"
/// rating : "4.5"
/// ulasan : "sfasfadas sdada"

class Ulasan {
  String id;
  String idOrder;
  String idProduk;
  String idUserLogin;
  String createdAt;
  String rating;
  String ulasan;
  String namaPembeli;

  static Ulasan fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Ulasan ulasanBean = Ulasan();
    ulasanBean.id = map['id'];
    ulasanBean.idOrder = map['id_order'];
    ulasanBean.idProduk = map['id_produk'];
    ulasanBean.idUserLogin = map['id_user_login'];
    ulasanBean.createdAt = map['created_at'];
    ulasanBean.rating = map['rating'];
    ulasanBean.ulasan = map['ulasan'];
    ulasanBean.namaPembeli = map['nama_pembeli'];
    return ulasanBean;
  }

  Map toJson() => {
        "id": id,
        "id_order": idOrder,
        "id_produk": idProduk,
        "id_user_login": idUserLogin,
        "created_at": createdAt,
        "rating": rating,
        "ulasan": ulasan,
        "nama_pembeli": namaPembeli,
      };
}
