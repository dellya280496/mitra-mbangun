/// nama : "Deni fatkhur rahman"
/// email : "denifrahman@gmail.com"
/// no_hp : "081331339866"
/// id_kecamatan : "1076"
/// alamat : "Prigi kanor"
/// jenis_kelamin : "l"
/// no_ktp : "01972031"
/// nama_pemilik : "deni"
/// alamat_pemilik : "deni"
/// no_npwp : "142949828432423"
/// id_google: : "105606415908453146944"
/// status_user : "user"
/// aktif : "1"
/// foto : "https://lh3.googleusercontent.com/a-/AOh14GgJnQsEqeBcW14PgwxZpMLLhaYz3b12T9jgXw_icQ=s1337"
/// id_mitra : "51"
/// username : "denifrahman@gmail.com"
/// id : "45"
/// aktif_mitra : "1"
/// jenis_layanan : "a"
/// jenis_mitra : "perorangan"
/// pengalaman_kerja : "Segala"
/// survey : "0"
/// tempat_lahir : "Bojongoro"
/// tgl_lahir : "2020-09-23"
/// cara_daftar : "android"
/// no_siup : "323131"
/// kode_pos : "62193"
/// foto_ktp : "d2766cf1c3c1b04a324b660cb23b8b0f.png"
/// foto_npwp : "b360ea5d036d67a210bf99fa5edef984.png"
/// foto_siup : "sdadsa"
/// id_kota : "80"
/// id_provinsi : "11"
/// foto_mitra : "foto"
/// nama_bank : "bank"
/// cabang_bank : "cabang"
/// no_rekening : "rek"
/// nama_pemilik_rekenig : "nama"

class UserMitra {
  String nama;
  String email;
  String noHp;
  String idKecamatan;
  String alamat;
  String jenisKelamin;
  String noKtp;
  String namaPemilik;
  String alamatPemilik;
  String noNpwp;
  String idGoogle;
  String statusUser;
  String aktif;
  String foto;
  String idMitra;
  String username;
  String id;
  String aktifMitra;
  String jenisLayanan;
  String jenisMitra;
  String pengalamanKerja;
  String survey;
  String tempatLahir;
  String tglLahir;
  String caraDaftar;
  String noSiup;
  String kodePos;
  String fotoKtp;
  String fotoNpwp;
  String fotoSiup;
  String idKota;
  String idProvinsi;
  String fotoMitra;
  String namaBank;
  String cabangBank;
  String noRekening;
  String namaPemilikRekening;

  static UserMitra fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    UserMitra userMitraBean = UserMitra();
    userMitraBean.nama = map['nama'];
    userMitraBean.email = map['email'];
    userMitraBean.noHp = map['no_hp'];
    userMitraBean.idKecamatan = map['id_kecamatan'];
    userMitraBean.alamat = map['alamat'];
    userMitraBean.jenisKelamin = map['jenis_kelamin'];
    userMitraBean.noKtp = map['no_ktp'];
    userMitraBean.namaPemilik = map['nama_pemilik'];
    userMitraBean.alamatPemilik = map['alamat_pemilik'];
    userMitraBean.noNpwp = map['no_npwp'];
    userMitraBean.idGoogle = map['id_google:'];
    userMitraBean.statusUser = map['status_user'];
    userMitraBean.aktif = map['aktif'];
    userMitraBean.foto = map['foto'];
    userMitraBean.idMitra = map['id_mitra'];
    userMitraBean.username = map['username'];
    userMitraBean.id = map['id'];
    userMitraBean.aktifMitra = map['aktif_mitra'];
    userMitraBean.jenisLayanan = map['jenis_layanan'];
    userMitraBean.jenisMitra = map['jenis_mitra'];
    userMitraBean.pengalamanKerja = map['pengalaman_kerja'];
    userMitraBean.survey = map['survey'];
    userMitraBean.tempatLahir = map['tempat_lahir'];
    userMitraBean.tglLahir = map['tgl_lahir'];
    userMitraBean.caraDaftar = map['cara_daftar'];
    userMitraBean.noSiup = map['no_siup'];
    userMitraBean.kodePos = map['kode_pos'];
    userMitraBean.fotoKtp = map['foto_ktp'];
    userMitraBean.fotoNpwp = map['foto_npwp'];
    userMitraBean.fotoSiup = map['foto_siup'];
    userMitraBean.idKota = map['id_kota'];
    userMitraBean.idProvinsi = map['id_provinsi'];
    userMitraBean.fotoMitra = map['foto_mitra'];
    userMitraBean.namaBank = map['nama_bank'];
    userMitraBean.cabangBank = map['cabang_bank'];
    userMitraBean.noRekening = map['no_rekening'];
    userMitraBean.namaPemilikRekening = map['nama_pemilik_rekening'];
    return userMitraBean;
  }

  Map toJson() => {
    "nama": nama,
    "email": email,
    "no_hp": noHp,
    "id_kecamatan": idKecamatan,
    "alamat": alamat,
    "jenis_kelamin": jenisKelamin,
    "no_ktp": noKtp,
    "nama_pemilik": namaPemilik,
    "alamat_pemilik": alamatPemilik,
    "no_npwp": noNpwp,
    "id_google:": idGoogle,
    "status_user": statusUser,
    "aktif": aktif,
    "foto": foto,
    "id_mitra": idMitra,
    "username": username,
    "id": id,
    "aktif_mitra": aktifMitra,
    "jenis_layanan": jenisLayanan,
    "jenis_mitra": jenisMitra,
    "pengalaman_kerja": pengalamanKerja,
    "survey": survey,
    "tempat_lahir": tempatLahir,
    "tgl_lahir": tglLahir,
    "cara_daftar": caraDaftar,
    "no_siup": noSiup,
    "kode_pos": kodePos,
    "foto_ktp": fotoKtp,
    "foto_npwp": fotoNpwp,
    "foto_siup": fotoSiup,
    "id_kota": idKota,
    "id_provinsi": idProvinsi,
    "foto_mitra": fotoMitra,
    "nama_bank": namaBank,
    "cabang_bank": cabangBank,
    "no_rekening": noRekening,
    "nama_pemilik_rekening": namaPemilikRekening,
  };
}