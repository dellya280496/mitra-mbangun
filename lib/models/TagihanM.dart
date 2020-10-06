/// id : "1"
/// id_proyek : "59"
/// nama : "Termin 1"
/// percentase : "30"
/// create_at : "2020-10-04 17:44:14.669198"

class TagihanM {
  String id;
  String idProyek;
  String nama;
  String percentase;
  String createAt;
  String foto;

  static TagihanM fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    TagihanM tagihanMBean = TagihanM();
    tagihanMBean.id = map['id'];
    tagihanMBean.idProyek = map['id_proyek'];
    tagihanMBean.nama = map['nama'];
    tagihanMBean.percentase = map['percentase'];
    tagihanMBean.createAt = map['create_at'];
    tagihanMBean.foto = map['foto'];
    return tagihanMBean;
  }

  Map toJson() => {
    "id": id,
    "id_proyek": idProyek,
    "nama": nama,
    "percentase": percentase,
    "create_at": createAt,
    "foto": foto,
  };
}