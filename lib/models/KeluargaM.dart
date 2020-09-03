/// t_anggota_keluarga_id : "1"
/// keluarahan_id : "1"
/// t_anggota_keluarga_nama : "Wahyu p sishadi"
/// t_anggota_keluarga_alamat : "Bronggalan sawah 1 48"
/// t_anggota_keluarga_wa : "0927301"
/// t_anggota_keluarga_status : "SEHAT"
/// user_insert : "105606415908453146944"
/// time_insert : "2020-03-29 18:54:16.000000"
/// t_anggota_keluarga_kondisi_kesahatan_lingkungan : "AMAN"
/// t_anggota_keluarga_usia : "25"

class KeluargaM {
  String tAnggotaKeluargaId;
  String keluarahanId;
  String tAnggotaKeluargaNama;
  String tAnggotaKeluargaAlamat;
  String tAnggotaKeluargaWa;
  String tAnggotaKeluargaStatus;
  String userInsert;
  String timeInsert;
  String tAnggotaKeluargaKondisiKesahatanLingkungan;
  String tAnggotaKeluargaUsia;

  static KeluargaM fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    KeluargaM keluargaMBean = KeluargaM();
    keluargaMBean.tAnggotaKeluargaId = map['t_anggota_keluarga_id'];
    keluargaMBean.keluarahanId = map['keluarahan_id'];
    keluargaMBean.tAnggotaKeluargaNama = map['t_anggota_keluarga_nama'];
    keluargaMBean.tAnggotaKeluargaAlamat = map['t_anggota_keluarga_alamat'];
    keluargaMBean.tAnggotaKeluargaWa = map['t_anggota_keluarga_wa'];
    keluargaMBean.tAnggotaKeluargaStatus = map['t_anggota_keluarga_status'];
    keluargaMBean.userInsert = map['user_insert'];
    keluargaMBean.timeInsert = map['time_insert'];
    keluargaMBean.tAnggotaKeluargaKondisiKesahatanLingkungan =
        map['t_anggota_keluarga_kondisi_kesahatan_lingkungan'];
    keluargaMBean.tAnggotaKeluargaUsia = map['t_anggota_keluarga_usia'];
    return keluargaMBean;
  }

  Map toJson() => {
        "t_anggota_keluarga_id": tAnggotaKeluargaId,
        "keluarahan_id": keluarahanId,
        "t_anggota_keluarga_nama": tAnggotaKeluargaNama,
        "t_anggota_keluarga_alamat": tAnggotaKeluargaAlamat,
        "t_anggota_keluarga_wa": tAnggotaKeluargaWa,
        "t_anggota_keluarga_status": tAnggotaKeluargaStatus,
        "user_insert": userInsert,
        "time_insert": timeInsert,
        "t_anggota_keluarga_kondisi_kesahatan_lingkungan":
            tAnggotaKeluargaKondisiKesahatanLingkungan,
        "t_anggota_keluarga_usia": tAnggotaKeluargaUsia,
      };
}
