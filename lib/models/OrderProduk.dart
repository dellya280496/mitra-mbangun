/// id : "51"
/// id_produk : "1"
/// nama_produk : "Beton Adhimix terbaik jawa timur"
/// harga : "100000"
/// jumlah : "1"
/// subtotal : "100000"
/// berat : "100"
/// slug : "Beton Adhimix terbaik jawa timur"
/// id_order : "66"
/// catatan : ""
/// foto : "beton.png"

class OrderProduk {
  String id;
  String idProduk;
  String namaProduk;
  String harga;
  String jumlah;
  String subtotal;
  String berat;
  String slug;
  String idOrder;
  String catatan;
  String foto;
  String statusUlasan;

  static OrderProduk fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    OrderProduk orderProdukBean = OrderProduk();
    orderProdukBean.id = map['id'];
    orderProdukBean.idProduk = map['id_produk'];
    orderProdukBean.namaProduk = map['nama_produk'];
    orderProdukBean.harga = map['harga'];
    orderProdukBean.jumlah = map['jumlah'];
    orderProdukBean.subtotal = map['subtotal'];
    orderProdukBean.berat = map['berat'];
    orderProdukBean.slug = map['slug'];
    orderProdukBean.idOrder = map['id_order'];
    orderProdukBean.catatan = map['catatan'];
    orderProdukBean.foto = map['foto'];
    orderProdukBean.statusUlasan = map['status_ulasan'];
    return orderProdukBean;
  }

  Map toJson() => {
        "id": id,
        "id_produk": idProduk,
        "nama_produk": namaProduk,
        "harga": harga,
        "jumlah": jumlah,
        "subtotal": subtotal,
        "berat": berat,
        "slug": slug,
        "id_order": idOrder,
        "catatan": catatan,
        "foto": foto,
        "status_ulasan": statusUlasan,
      };
}