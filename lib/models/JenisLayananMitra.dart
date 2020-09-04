/// id : "1"
/// nama : "Perbaikan pagar"
/// aktif : "1"
/// biaya_survey : "150000"

class JenisLayananMitra {
  String id;
  String nama;
  String aktif;
  String biayaSurvey;

  static JenisLayananMitra fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    JenisLayananMitra jenisLayananMitraBean = JenisLayananMitra();
    jenisLayananMitraBean.id = map['id'];
    jenisLayananMitraBean.nama = map['nama'];
    jenisLayananMitraBean.aktif = map['aktif'];
    jenisLayananMitraBean.biayaSurvey = map['biaya_survey'];
    return jenisLayananMitraBean;
  }

  Map toJson() => {
    "id": id,
    "nama": nama,
    "aktif": aktif,
    "biaya_survey": biayaSurvey,
  };
}