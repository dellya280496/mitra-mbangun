/// id : "1"
/// nama : "ramayana"
/// baner : "ramayana.jpeg"
/// id_toko : "1"
/// tgl_mulai : null
/// tgl_selesai : null
/// urutan : "1"
/// aktif : "0"

class Iklan {
  String id;
  String nama;
  String baner;
  String idToko;
  dynamic tglMulai;
  dynamic tglSelesai;
  String urutan;
  String aktif;

  static Iklan fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Iklan iklanBean = Iklan();
    iklanBean.id = map['id'];
    iklanBean.nama = map['nama'];
    iklanBean.baner = map['baner'];
    iklanBean.idToko = map['id_toko'];
    iklanBean.tglMulai = map['tgl_mulai'];
    iklanBean.tglSelesai = map['tgl_selesai'];
    iklanBean.urutan = map['urutan'];
    iklanBean.aktif = map['aktif'];
    return iklanBean;
  }

  Map toJson() => {
    "id": id,
    "nama": nama,
    "baner": baner,
    "id_toko": idToko,
    "tgl_mulai": tglMulai,
    "tgl_selesai": tglSelesai,
    "urutan": urutan,
    "aktif": aktif,
  };
}