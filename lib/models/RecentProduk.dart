/// nama : "Beton Adhimix terbaik jawa timur"
/// id : "1"
/// slug : "beton"
/// berat : "100"
/// harga : "100000"
/// kondisi : "baru"
/// foto : "beton.png"
/// jumlah_favorite : "2"
/// jumlah_dilihat : "2"
/// jumlah_dibeli : "3"
/// price1 : null
/// nama_kategori : "Pasir Hitam"
/// icon : "bahan_bangunan.png"
/// id_kategori : "1"
/// stok : "10"
/// nama_toko : "Toko Anugerah"
/// deskripsi : "Dalam konstruksi, beton adalah sebuah bahan bangunan komposit yang terbuat dari kombinasi aggregat dan pengikat semen. Bentuk paling umum dari beton adalah beton semen Portland, yang terdiri dari agregat mineral (biasanya kerikil dan pasir), semen dan air. Biasanya dipercayai bahwa beton mengering setelah pencampuran dan peletakan. Sebenarnya, beton tidak menjadi padat karena air menguap, tetapi semen berhidrasi, mengrekatkan komponen lainnya bersama dan akhirnya membentuk material seperti-batu. Beton digunakan untuk membuat perkerasan jalan, struktur bangunan, fondasi, jalan, jembatan penyeberangan, struktur parkiran, dasar untuk pagar/gerbang, dan semen dalam bata atau tembok blok. Nama lama untuk beton adalah batu cair. Dalam perkembangannya banyak ditemukan beton baru hasil modifikasi, seperti beton ringan, beton semprot (eng: shotcrete), beton fiber, beton berkekuatan tinggi, beton berkekuatan sangat tinggi, beton mampat sendiri (eng: self compacted concrete) dll. Saat ini beton merupakan bahan bangunan yang paling banyak dipakai di dunia."
/// id_toko : "1"
/// jenis_toko : "official_store"
/// minimal_pesanan : "100"
/// panjang : "21"
/// foto1 : "beton.png"
/// min1 : null
/// foto4 : null
/// foto3 : null
/// foto2 : null
/// price2 : null
/// min3 : null
/// price3 : null
/// price4 : null
/// jenis_ongkir : "iclude"
/// biaya_ongkir : null
/// min2 : null
/// min4 : null
/// id_kecamatan : "6131"
/// aktif : "1"
/// id_kota : null
/// id_provinsi : null

class RecentProduk {
  String nama;
  String id;
  String slug;
  String berat;
  String harga;
  String kondisi;
  String foto;
  String jumlahFavorite;
  String jumlahDilihat;
  String jumlahDibeli;
  dynamic price1;
  String namaKategori;
  String icon;
  String idKategori;
  String stok;
  String namaToko;
  String deskripsi;
  String idToko;
  String jenisToko;
  String minimalPesanan;
  String panjang;
  String foto1;
  dynamic min1;
  dynamic foto4;
  dynamic foto3;
  dynamic foto2;
  dynamic price2;
  dynamic min3;
  dynamic price3;
  dynamic price4;
  String jenisOngkir;
  dynamic biayaOngkir;
  dynamic min2;
  dynamic min4;
  String idKecamatan;
  String aktif;
  dynamic idKota;
  dynamic idProvinsi;
  String avg_rating;
  String jumlah_rating;

  static RecentProduk fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RecentProduk RecentProdukBean = RecentProduk();
    RecentProdukBean.nama = map['nama'];
    RecentProdukBean.id = map['id'];
    RecentProdukBean.slug = map['slug'];
    RecentProdukBean.berat = map['berat'];
    RecentProdukBean.harga = map['harga'];
    RecentProdukBean.kondisi = map['kondisi'];
    RecentProdukBean.foto = map['foto'];
    RecentProdukBean.jumlahFavorite = map['jumlah_favorite'];
    RecentProdukBean.jumlahDilihat = map['jumlah_dilihat'];
    RecentProdukBean.jumlahDibeli = map['jumlah_dibeli'];
    RecentProdukBean.price1 = map['price1'];
    RecentProdukBean.namaKategori = map['nama_kategori'];
    RecentProdukBean.icon = map['icon'];
    RecentProdukBean.idKategori = map['id_kategori'];
    RecentProdukBean.stok = map['stok'];
    RecentProdukBean.namaToko = map['nama_toko'];
    RecentProdukBean.deskripsi = map['deskripsi'];
    RecentProdukBean.idToko = map['id_toko'];
    RecentProdukBean.jenisToko = map['jenis_toko'];
    RecentProdukBean.minimalPesanan = map['minimal_pesanan'];
    RecentProdukBean.panjang = map['panjang'];
    RecentProdukBean.foto1 = map['foto1'];
    RecentProdukBean.min1 = map['min1'];
    RecentProdukBean.foto4 = map['foto4'];
    RecentProdukBean.foto3 = map['foto3'];
    RecentProdukBean.foto2 = map['foto2'];
    RecentProdukBean.price2 = map['price2'];
    RecentProdukBean.min3 = map['min3'];
    RecentProdukBean.price3 = map['price3'];
    RecentProdukBean.price4 = map['price4'];
    RecentProdukBean.jenisOngkir = map['jenis_ongkir'];
    RecentProdukBean.biayaOngkir = map['biaya_ongkir'];
    RecentProdukBean.min2 = map['min2'];
    RecentProdukBean.min4 = map['min4'];
    RecentProdukBean.idKecamatan = map['id_kecamatan'];
    RecentProdukBean.aktif = map['aktif'];
    RecentProdukBean.idKota = map['id_kota'];
    RecentProdukBean.idProvinsi = map['id_provinsi'];
    RecentProdukBean.avg_rating = map['avg_rating'];
    RecentProdukBean.jumlah_rating = map['jumlah_rating'];
    return RecentProdukBean;
  }

  Map toJson() => {
        "nama": nama,
        "id": id,
        "slug": slug,
        "berat": berat,
        "harga": harga,
        "kondisi": kondisi,
        "foto": foto,
        "jumlah_favorite": jumlahFavorite,
        "jumlah_dilihat": jumlahDilihat,
        "jumlah_dibeli": jumlahDibeli,
        "price1": price1,
        "nama_kategori": namaKategori,
        "icon": icon,
        "id_kategori": idKategori,
        "stok": stok,
        "nama_toko": namaToko,
        "deskripsi": deskripsi,
        "id_toko": idToko,
        "jenis_toko": jenisToko,
        "minimal_pesanan": minimalPesanan,
        "panjang": panjang,
        "foto1": foto1,
        "min1": min1,
        "foto4": foto4,
        "foto3": foto3,
        "foto2": foto2,
        "price2": price2,
        "min3": min3,
        "price3": price3,
        "price4": price4,
        "jenis_ongkir": jenisOngkir,
        "biaya_ongkir": biayaOngkir,
        "min2": min2,
        "min4": min4,
        "id_kecamatan": idKecamatan,
        "aktif": aktif,
        "id_kota": idKota,
        "id_provinsi": idProvinsi,
        "avg_rating": avg_rating,
        "jumlah_rating": jumlah_rating,
      };
}