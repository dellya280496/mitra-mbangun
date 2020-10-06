/// id : "33"
/// nama : "Pengadaan Beton"
/// nama_layanan : "perbaikan kamar mandi"
/// no_order : "PROJ-1598923901"
/// deskripsi : "<p>Termin 3 kali</p><p>Pembayaran pertama 30%</p><p><br></p>"
/// budget : "9000000"
/// tipe_lokasi : "rumah"
/// latitude : null
/// longitude : null
/// alamat_lengkap : "Dafsa"
/// biaya_survey : "150000"
/// id_jenis_layanan : "2"
/// tgl_survey : null
/// status : "survey"
/// created_at : "2020-09-06 11:58:24"
/// id_user_login : "45"
/// status_pembayaran_survey : "terbayar"
/// tgl_max_bid : "2020-09-01"
/// aktif : "1"
/// id_kecamatan : "258"
/// id_kota : "17"
/// id_provinsi : "1"
/// komisi_survey : "50000"
/// token_va : "66e80b2a-b2db-47ba-9187-c7671e93a87b"
/// batas_bayar : "2020-09-01 10:32:01.000000"
/// foto1 : "scaled_image_picker7316254326125160857.jpg"
/// foto2 : "image_picker_DB965037-30D7-4562-9EB5-258558A966EB-2480-000004A8FFB2C21C.jpg"
/// foto3 : "null"
/// foto4 : null
/// no_hp : "081331339866"
/// fileLaporanAkhir : "0"
/// termin2 : "0"
/// termin3 : "0"
/// retensi : "0"
/// termin : "0"

class Proyek {
  String id;
  String nama;
  String namaLayanan;
  String noOrder;
  String deskripsi;
  String budget;
  String tipeLokasi;
  dynamic latitude;
  dynamic longitude;
  String alamatLengkap;
  String biayaSurvey;
  String idJenisLayanan;
  dynamic tglSurvey;
  String status;
  String createdAt;
  String idUserLogin;
  String statusPembayaranSurvey;
  String tglMaxBid;
  String aktif;
  String idKecamatan;
  String idKota;
  String idProvinsi;
  String komisiSurvey;
  String tokenVa;
  String batasBayar;
  String foto1;
  String foto2;
  String foto3;
  dynamic foto4;
  String noHp;
  String fileLaporanAkhir;
  
  static Proyek fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Proyek proyekBean = Proyek();
    proyekBean.id = map['id'];
    proyekBean.nama = map['nama'];
    proyekBean.namaLayanan = map['nama_layanan'];
    proyekBean.noOrder = map['no_order'];
    proyekBean.deskripsi = map['deskripsi'];
    proyekBean.budget = map['budget'];
    proyekBean.tipeLokasi = map['tipe_lokasi'];
    proyekBean.latitude = map['latitude'];
    proyekBean.longitude = map['longitude'];
    proyekBean.alamatLengkap = map['alamat_lengkap'];
    proyekBean.biayaSurvey = map['biaya_survey'];
    proyekBean.idJenisLayanan = map['id_jenis_layanan'];
    proyekBean.tglSurvey = map['tgl_survey'];
    proyekBean.status = map['status'];
    proyekBean.createdAt = map['created_at'];
    proyekBean.idUserLogin = map['id_user_login'];
    proyekBean.statusPembayaranSurvey = map['status_pembayaran_survey'];
    proyekBean.tglMaxBid = map['tgl_max_bid'];
    proyekBean.aktif = map['aktif'];
    proyekBean.idKecamatan = map['id_kecamatan'];
    proyekBean.idKota = map['id_kota'];
    proyekBean.idProvinsi = map['id_provinsi'];
    proyekBean.komisiSurvey = map['komisi_survey'];
    proyekBean.tokenVa = map['token_va'];
    proyekBean.batasBayar = map['batas_bayar'];
    proyekBean.foto1 = map['foto1'];
    proyekBean.foto2 = map['foto2'];
    proyekBean.foto3 = map['foto3'];
    proyekBean.foto4 = map['foto4'];
    proyekBean.noHp = map['no_hp'];
    proyekBean.fileLaporanAkhir = map['file_laporan_akhir'];
    return proyekBean;
  }

  Map toJson() => {
    "id": id,
    "nama": nama,
    "nama_layanan": namaLayanan,
    "no_order": noOrder,
    "deskripsi": deskripsi,
    "budget": budget,
    "tipe_lokasi": tipeLokasi,
    "latitude": latitude,
    "longitude": longitude,
    "alamat_lengkap": alamatLengkap,
    "biaya_survey": biayaSurvey,
    "id_jenis_layanan": idJenisLayanan,
    "tgl_survey": tglSurvey,
    "status": status,
    "created_at": createdAt,
    "id_user_login": idUserLogin,
    "status_pembayaran_survey": statusPembayaranSurvey,
    "tgl_max_bid": tglMaxBid,
    "aktif": aktif,
    "id_kecamatan": idKecamatan,
    "id_kota": idKota,
    "id_provinsi": idProvinsi,
    "komisi_survey": komisiSurvey,
    "token_va": tokenVa,
    "batas_bayar": batasBayar,
    "foto1": foto1,
    "foto2": foto2,
    "foto3": foto3,
    "foto4": foto4,
    "no_hp": noHp,
    "file_laporan_akhir": fileLaporanAkhir
  };
}