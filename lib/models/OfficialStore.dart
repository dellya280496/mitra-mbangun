/// id : "1"
/// nama_toko : "Toko Anugerah"
/// slug : "toko-anugerah"
/// id_raja_ongkir : null
/// alamat_pengiriman : "jalan surabaya"
/// instagram : null
/// youtube : null
/// facebook : null
/// kode_pos : null
/// no_hp : null
/// aktif : "1"
/// id_user : null
/// foto : "ramayana.png"
/// foto_sampul : null
/// jenis_toko : "official_store"
/// nama_perusahaan : null
/// nama_legal : null
/// no_npwp : null
/// nama_brand : null
/// alamat_perusahaan : null
/// alamat_legal : null
/// email_pic : null
/// nama_pihak_kedua : null
/// nik_pihak_kedua : null
/// jabatan_pihak_kedua : null
/// email_pihak_kedua : null
/// no_hp_pihak_kedua : null
/// nama_bank : null
/// cabang_bank : null
/// no_rekening : null
/// foto_npwp_perusahaan : null
/// foto_ktp : null
/// foto_akta_perushaan : null
/// foto_tdp : null
/// foto_skdp : null
/// foto_sppkp : null
/// foto_skt : null
/// foto_siup : null
/// foto_ijin_operasional : null
/// foto_merk_dagang : null
/// foto_surat_penunjukan_distributor_resmi : null

class OfficialStore {
  String id;
  String namaToko;
  String slug;
  dynamic idRajaOngkir;
  String alamatPengiriman;
  dynamic instagram;
  dynamic youtube;
  dynamic facebook;
  dynamic kodePos;
  dynamic noHp;
  String aktif;
  dynamic idUser;
  String foto;
  dynamic fotoSampul;
  String jenisToko;
  dynamic namaPerusahaan;
  dynamic namaLegal;
  dynamic noNpwp;
  dynamic namaBrand;
  dynamic alamatPerusahaan;
  dynamic alamatLegal;
  dynamic emailPic;
  dynamic namaPihakKedua;
  dynamic nikPihakKedua;
  dynamic jabatanPihakKedua;
  dynamic emailPihakKedua;
  dynamic noHpPihakKedua;
  dynamic namaBank;
  dynamic cabangBank;
  dynamic noRekening;
  dynamic fotoNpwpPerusahaan;
  dynamic fotoKtp;
  dynamic fotoAktaPerushaan;
  dynamic fotoTdp;
  dynamic fotoSkdp;
  dynamic fotoSppkp;
  dynamic fotoSkt;
  dynamic fotoSiup;
  dynamic fotoIjinOperasional;
  dynamic fotoMerkDagang;
  dynamic fotoSuratPenunjukanDistributorResmi;

  static OfficialStore fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    OfficialStore officialStoreBean = OfficialStore();
    officialStoreBean.id = map['id'];
    officialStoreBean.namaToko = map['nama_toko'];
    officialStoreBean.slug = map['slug'];
    officialStoreBean.idRajaOngkir = map['id_raja_ongkir'];
    officialStoreBean.alamatPengiriman = map['alamat_pengiriman'];
    officialStoreBean.instagram = map['instagram'];
    officialStoreBean.youtube = map['youtube'];
    officialStoreBean.facebook = map['facebook'];
    officialStoreBean.kodePos = map['kode_pos'];
    officialStoreBean.noHp = map['no_hp'];
    officialStoreBean.aktif = map['aktif'];
    officialStoreBean.idUser = map['id_user'];
    officialStoreBean.foto = map['foto'];
    officialStoreBean.fotoSampul = map['foto_sampul'];
    officialStoreBean.jenisToko = map['jenis_toko'];
    officialStoreBean.namaPerusahaan = map['nama_perusahaan'];
    officialStoreBean.namaLegal = map['nama_legal'];
    officialStoreBean.noNpwp = map['no_npwp'];
    officialStoreBean.namaBrand = map['nama_brand'];
    officialStoreBean.alamatPerusahaan = map['alamat_perusahaan'];
    officialStoreBean.alamatLegal = map['alamat_legal'];
    officialStoreBean.emailPic = map['email_pic'];
    officialStoreBean.namaPihakKedua = map['nama_pihak_kedua'];
    officialStoreBean.nikPihakKedua = map['nik_pihak_kedua'];
    officialStoreBean.jabatanPihakKedua = map['jabatan_pihak_kedua'];
    officialStoreBean.emailPihakKedua = map['email_pihak_kedua'];
    officialStoreBean.noHpPihakKedua = map['no_hp_pihak_kedua'];
    officialStoreBean.namaBank = map['nama_bank'];
    officialStoreBean.cabangBank = map['cabang_bank'];
    officialStoreBean.noRekening = map['no_rekening'];
    officialStoreBean.fotoNpwpPerusahaan = map['foto_npwp_perusahaan'];
    officialStoreBean.fotoKtp = map['foto_ktp'];
    officialStoreBean.fotoAktaPerushaan = map['foto_akta_perushaan'];
    officialStoreBean.fotoTdp = map['foto_tdp'];
    officialStoreBean.fotoSkdp = map['foto_skdp'];
    officialStoreBean.fotoSppkp = map['foto_sppkp'];
    officialStoreBean.fotoSkt = map['foto_skt'];
    officialStoreBean.fotoSiup = map['foto_siup'];
    officialStoreBean.fotoIjinOperasional = map['foto_ijin_operasional'];
    officialStoreBean.fotoMerkDagang = map['foto_merk_dagang'];
    officialStoreBean.fotoSuratPenunjukanDistributorResmi = map['foto_surat_penunjukan_distributor_resmi'];
    return officialStoreBean;
  }

  Map toJson() => {
        "id": id,
        "nama_toko": namaToko,
        "slug": slug,
        "id_raja_ongkir": idRajaOngkir,
        "alamat_pengiriman": alamatPengiriman,
        "instagram": instagram,
        "youtube": youtube,
        "facebook": facebook,
        "kode_pos": kodePos,
        "no_hp": noHp,
        "aktif": aktif,
        "id_user": idUser,
        "foto": foto,
        "foto_sampul": fotoSampul,
        "jenis_toko": jenisToko,
        "nama_perusahaan": namaPerusahaan,
        "nama_legal": namaLegal,
        "no_npwp": noNpwp,
        "nama_brand": namaBrand,
        "alamat_perusahaan": alamatPerusahaan,
        "alamat_legal": alamatLegal,
        "email_pic": emailPic,
        "nama_pihak_kedua": namaPihakKedua,
        "nik_pihak_kedua": nikPihakKedua,
        "jabatan_pihak_kedua": jabatanPihakKedua,
        "email_pihak_kedua": emailPihakKedua,
        "no_hp_pihak_kedua": noHpPihakKedua,
        "nama_bank": namaBank,
        "cabang_bank": cabangBank,
        "no_rekening": noRekening,
        "foto_npwp_perusahaan": fotoNpwpPerusahaan,
        "foto_ktp": fotoKtp,
        "foto_akta_perushaan": fotoAktaPerushaan,
        "foto_tdp": fotoTdp,
        "foto_skdp": fotoSkdp,
        "foto_sppkp": fotoSppkp,
        "foto_skt": fotoSkt,
        "foto_siup": fotoSiup,
        "foto_ijin_operasional": fotoIjinOperasional,
        "foto_merk_dagang": fotoMerkDagang,
        "foto_surat_penunjukan_distributor_resmi": fotoSuratPenunjukanDistributorResmi,
      };
}
