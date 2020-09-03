/// flag : "Toko Anugerah"
/// chilrdern : [{"id":"139","created_at":"2020-08-18 06:54:41.164384","id_produk":"31","id_user_login":"45","jumlah":"1","subtotal":"25000","id_toko":"1","jenis_ongkir":"raja_ongkir","catatan":"","foto":"scaled_image_picker5306355590071312649.jpg","nama":"palu","nama_toko":"Toko Anugerah","id_kecamatan":"6131","foto_toko":"image_picker_4D0BBF55-987F-48D2-81C4-E260925DDA17-2173-00000106BEC932A7.jpg","berat":"5000","id_kota":"444","id_provinsi":"11","stok":"94","harga":"25000","aktif":"0"}]

class Cart {
  String flag;
  List<ChilrdernBean> chilrdern;

  static Cart fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Cart cartBean = Cart();
    cartBean.flag = map['flag'];
    cartBean.chilrdern = List()..addAll((map['chilrdern'] as List ?? []).map((o) => ChilrdernBean.fromMap(o)));
    return cartBean;
  }

  Map toJson() => {
        "flag": flag,
        "chilrdern": chilrdern,
      };
}

/// id : "139"
/// created_at : "2020-08-18 06:54:41.164384"
/// id_produk : "31"
/// id_user_login : "45"
/// jumlah : "1"
/// subtotal : "25000"
/// id_toko : "1"
/// jenis_ongkir : "raja_ongkir"
/// catatan : ""
/// foto : "scaled_image_picker5306355590071312649.jpg"
/// nama : "palu"
/// nama_toko : "Toko Anugerah"
/// id_kecamatan : "6131"
/// foto_toko : "image_picker_4D0BBF55-987F-48D2-81C4-E260925DDA17-2173-00000106BEC932A7.jpg"
/// berat : "5000"
/// id_kota : "444"
/// id_provinsi : "11"
/// stok : "94"
/// harga : "25000"
/// aktif : "0"

class ChilrdernBean {
  String id;
  String createdAt;
  String idProduk;
  String idUserLogin;
  String jumlah;
  String subtotal;
  String idToko;
  String jenisOngkir;
  String catatan;
  String foto;
  String nama;
  String namaToko;
  String idKecamatan;
  String fotoToko;
  String berat;
  String idKota;
  String idProvinsi;
  String stok;
  String harga;
  String aktif;

  static ChilrdernBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ChilrdernBean chilrdernBean = ChilrdernBean();
    chilrdernBean.id = map['id'];
    chilrdernBean.createdAt = map['created_at'];
    chilrdernBean.idProduk = map['id_produk'];
    chilrdernBean.idUserLogin = map['id_user_login'];
    chilrdernBean.jumlah = map['jumlah'];
    chilrdernBean.subtotal = map['subtotal'];
    chilrdernBean.idToko = map['id_toko'];
    chilrdernBean.jenisOngkir = map['jenis_ongkir'];
    chilrdernBean.catatan = map['catatan'];
    chilrdernBean.foto = map['foto'];
    chilrdernBean.nama = map['nama'];
    chilrdernBean.namaToko = map['nama_toko'];
    chilrdernBean.idKecamatan = map['id_kecamatan'];
    chilrdernBean.fotoToko = map['foto_toko'];
    chilrdernBean.berat = map['berat'];
    chilrdernBean.idKota = map['id_kota'];
    chilrdernBean.idProvinsi = map['id_provinsi'];
    chilrdernBean.stok = map['stok'];
    chilrdernBean.harga = map['harga'];
    chilrdernBean.aktif = map['aktif'];
    return chilrdernBean;
  }

  Map toJson() =>
      {
        "id": id,
        "created_at": createdAt,
        "id_produk": idProduk,
        "id_user_login": idUserLogin,
        "jumlah": jumlah,
        "subtotal": subtotal,
        "id_toko": idToko,
        "jenis_ongkir": jenisOngkir,
        "catatan": catatan,
        "foto": foto,
        "nama": nama,
        "nama_toko": namaToko,
        "id_kecamatan": idKecamatan,
        "foto_toko": fotoToko,
        "berat": berat,
        "id_kota": idKota,
        "id_provinsi": idProvinsi,
        "stok": stok,
        "harga": harga,
        "aktif": aktif,
      };
}