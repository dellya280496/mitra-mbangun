/// id : "1"
/// id_toko : "1"
/// id_pembeli : "45"
/// total_produk : "2"
/// total_ongkir : "1000"
/// komisi : "20000"
/// total : "20000"
/// no_order : "11111"
/// id_order : "82"
/// created_at : "2020-08-18 09:04:13"
/// status : "belum_terbayar"

class Penghasilan {
  String id;
  String idToko;
  String idPembeli;
  String totalProduk;
  String totalOngkir;
  String komisi;
  String total;
  String noOrder;
  String idOrder;
  String createdAt;
  String status;

  static Penghasilan fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Penghasilan penghasilanBean = Penghasilan();
    penghasilanBean.id = map['id'];
    penghasilanBean.idToko = map['id_toko'];
    penghasilanBean.idPembeli = map['id_pembeli'];
    penghasilanBean.totalProduk = map['total_produk'];
    penghasilanBean.totalOngkir = map['total_ongkir'];
    penghasilanBean.komisi = map['komisi'];
    penghasilanBean.total = map['total'];
    penghasilanBean.noOrder = map['no_order'];
    penghasilanBean.idOrder = map['id_order'];
    penghasilanBean.createdAt = map['created_at'];
    penghasilanBean.status = map['status'];
    return penghasilanBean;
  }

  Map toJson() => {
        "id": id,
        "id_toko": idToko,
        "id_pembeli": idPembeli,
        "total_produk": totalProduk,
        "total_ongkir": totalOngkir,
        "komisi": komisi,
        "total": total,
        "no_order": noOrder,
        "id_order": idOrder,
        "created_at": createdAt,
        "status": status,
      };
}
