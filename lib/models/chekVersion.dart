/// id : "2"
/// version_number : "1.0.1"
/// deksripsi : "Perbaikan bug's Saldo beranda"
/// tgl_ins : "2019-10-20 15:09:42.405709"

class ChekVersion {
  String id;
  String versionNumber;
  String deksripsi;
  String tglIns;

  static ChekVersion fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ChekVersion chekVersionBean = ChekVersion();
    chekVersionBean.id = map['id'];
    chekVersionBean.versionNumber = map['version_number'];
    chekVersionBean.deksripsi = map['deksripsi'];
    chekVersionBean.tglIns = map['tgl_ins'];
    return chekVersionBean;
  }

  Map toJson() => {
        "id": id,
        "version_number": versionNumber,
        "deksripsi": deksripsi,
        "tgl_ins": tglIns,
      };
}
