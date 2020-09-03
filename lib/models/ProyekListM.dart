/// id : "33"
/// nama : "Coba"
/// nama_layanan : "Perbaikan pagar"
/// no_order : "PROJ-1598923901"
/// deskripsi : "Sdafa"
/// budget : "900000"
/// tipe_lokasi : "rumah"
/// latitude : null
/// longitude : null
/// alamat_lengkap : "Dafsa"
/// biaya_survey : "150000"
/// id_jenis_layanan : "1"
/// tgl_survey : null
/// status : "setuju"
/// created_at : "2020-09-02 13:51:26"
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
/// foto1 : null
/// foto2 : null
/// foto3 : null
/// foto4 : null

class ProyekListM {
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
  dynamic foto1;
  dynamic foto2;
  dynamic foto3;
  dynamic foto4;

  static ProyekListM fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ProyekListM proyekListMBean = ProyekListM();
    proyekListMBean.id = map['id'];
    proyekListMBean.nama = map['nama'];
    proyekListMBean.namaLayanan = map['nama_layanan'];
    proyekListMBean.noOrder = map['no_order'];
    proyekListMBean.deskripsi = map['deskripsi'];
    proyekListMBean.budget = map['budget'];
    proyekListMBean.tipeLokasi = map['tipe_lokasi'];
    proyekListMBean.latitude = map['latitude'];
    proyekListMBean.longitude = map['longitude'];
    proyekListMBean.alamatLengkap = map['alamat_lengkap'];
    proyekListMBean.biayaSurvey = map['biaya_survey'];
    proyekListMBean.idJenisLayanan = map['id_jenis_layanan'];
    proyekListMBean.tglSurvey = map['tgl_survey'];
    proyekListMBean.status = map['status'];
    proyekListMBean.createdAt = map['created_at'];
    proyekListMBean.idUserLogin = map['id_user_login'];
    proyekListMBean.statusPembayaranSurvey = map['status_pembayaran_survey'];
    proyekListMBean.tglMaxBid = map['tgl_max_bid'];
    proyekListMBean.aktif = map['aktif'];
    proyekListMBean.idKecamatan = map['id_kecamatan'];
    proyekListMBean.idKota = map['id_kota'];
    proyekListMBean.idProvinsi = map['id_provinsi'];
    proyekListMBean.komisiSurvey = map['komisi_survey'];
    proyekListMBean.tokenVa = map['token_va'];
    proyekListMBean.batasBayar = map['batas_bayar'];
    proyekListMBean.foto1 = map['foto1'];
    proyekListMBean.foto2 = map['foto2'];
    proyekListMBean.foto3 = map['foto3'];
    proyekListMBean.foto4 = map['foto4'];
    return proyekListMBean;
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
  };
}