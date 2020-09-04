/// id : "1"
/// id_projek : "33"
/// created_at : "2020-09-02 10:47:42"
/// updated_at : "2020-09-02 10:08:24"
/// deskripsi : "dsa"
/// harga : "124"
/// waktu_pengerjaan : "1231"
/// deal_at : "2020-09-02 10:08:33"
/// status : "1"
/// nama_mitra : "dfsf"
/// nama_user : "deni fatkhur rahman"
/// foto_mitra : "https://lh5.googleusercontent.com/-uJy-SfPCThM/AAAAAAAAAAI/AAAAAAAAAAA/AMZuuclF8VCpJmSXBRIRzdlDb2cmsXM5Ig/s96-c/photo.jpg"
/// foto_user : "https://lh3.googleusercontent.com/a-/AOh14GgJnQsEqeBcW14PgwxZpMLLhaYz3b12T9jgXw_icQ=s1337"
/// jenis_mitra : "pt"
/// id_user : "45"
/// id_mitra : "56"
/// nama : "Coba"
/// deskripsi_proyek : "Sdafa"
/// tipe_lokasi : "rumah"
/// alamat_lengkap : "Dafsa"
/// status_proyek : "setuju"
/// foto1 : "scaled_image_picker7316254326125160857.jpg"

class Bids {
  String id;
  String idProjek;
  String createdAt;
  String updatedAt;
  String deskripsi;
  String harga;
  String waktuPengerjaan;
  String dealAt;
  String status;
  String namaMitra;
  String namaUser;
  String fotoMitra;
  String fotoUser;
  String jenisMitra;
  String idUser;
  String idMitra;
  String nama;
  String deskripsiProyek;
  String tipeLokasi;
  String alamatLengkap;
  String statusProyek;
  String foto1;

  static Bids fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Bids bidsBean = Bids();
    bidsBean.id = map['id'];
    bidsBean.idProjek = map['id_projek'];
    bidsBean.createdAt = map['created_at'];
    bidsBean.updatedAt = map['updated_at'];
    bidsBean.deskripsi = map['deskripsi'];
    bidsBean.harga = map['harga'];
    bidsBean.waktuPengerjaan = map['waktu_pengerjaan'];
    bidsBean.dealAt = map['deal_at'];
    bidsBean.status = map['status'];
    bidsBean.namaMitra = map['nama_mitra'];
    bidsBean.namaUser = map['nama_user'];
    bidsBean.fotoMitra = map['foto_mitra'];
    bidsBean.fotoUser = map['foto_user'];
    bidsBean.jenisMitra = map['jenis_mitra'];
    bidsBean.idUser = map['id_user'];
    bidsBean.idMitra = map['id_mitra'];
    bidsBean.nama = map['nama'];
    bidsBean.deskripsiProyek = map['deskripsi_proyek'];
    bidsBean.tipeLokasi = map['tipe_lokasi'];
    bidsBean.alamatLengkap = map['alamat_lengkap'];
    bidsBean.statusProyek = map['status_proyek'];
    bidsBean.foto1 = map['foto1'];
    return bidsBean;
  }

  Map toJson() => {
    "id": id,
    "id_projek": idProjek,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deskripsi": deskripsi,
    "harga": harga,
    "waktu_pengerjaan": waktuPengerjaan,
    "deal_at": dealAt,
    "status": status,
    "nama_mitra": namaMitra,
    "nama_user": namaUser,
    "foto_mitra": fotoMitra,
    "foto_user": fotoUser,
    "jenis_mitra": jenisMitra,
    "id_user": idUser,
    "id_mitra": idMitra,
    "nama": nama,
    "deskripsi_proyek": deskripsiProyek,
    "tipe_lokasi": tipeLokasi,
    "alamat_lengkap": alamatLengkap,
    "status_proyek": statusProyek,
    "foto1": foto1,
  };
}