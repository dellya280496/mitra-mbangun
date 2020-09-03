/// id : "1"
/// nama : "Bank Transfer"
/// deskripsi : "Melalui Bank Transfer"
/// icon : null
/// aktif : "1"
/// nama_bank : "BRI"
/// no_rekening : "9888888852"
/// atas_nama : "m-bangun"

class MetodePembayaran {
  String id;
  String nama;
  String deskripsi;
  dynamic icon;
  String aktif;
  String namaBank;
  String noRekening;
  String atasNama;

  static MetodePembayaran fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    MetodePembayaran metodePembayaranBean = MetodePembayaran();
    metodePembayaranBean.id = map['id'];
    metodePembayaranBean.nama = map['nama'];
    metodePembayaranBean.deskripsi = map['deskripsi'];
    metodePembayaranBean.icon = map['icon'];
    metodePembayaranBean.aktif = map['aktif'];
    metodePembayaranBean.namaBank = map['nama_bank'];
    metodePembayaranBean.noRekening = map['no_rekening'];
    metodePembayaranBean.atasNama = map['atas_nama'];
    return metodePembayaranBean;
  }

  Map toJson() => {
        "id": id,
        "nama": nama,
        "deskripsi": deskripsi,
        "icon": icon,
        "aktif": aktif,
        "nama_bank": namaBank,
        "no_rekening": noRekening,
        "atas_nama": atasNama,
      };
}
