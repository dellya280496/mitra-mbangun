/// metode_transfer_id : "1"
/// metode_transfer_nama : "Transfer Bank"
/// metode_transfer_deskripsi : "Metode transfer melalui ATM, Mobile BANKNG"

class MetodeTransferM {
  String metodeTransferId;
  String metodeTransferNama;
  String metodeTransferDeskripsi;
  String metodeTransferIcon;

  static MetodeTransferM fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    MetodeTransferM metodeTransferMBean = MetodeTransferM();
    metodeTransferMBean.metodeTransferId = map['metode_transfer_id'];
    metodeTransferMBean.metodeTransferNama = map['metode_transfer_nama'];
    metodeTransferMBean.metodeTransferDeskripsi = map['metode_transfer_deskripsi'];
    metodeTransferMBean.metodeTransferIcon = map['metode_transfer_icon'];
    return metodeTransferMBean;
  }

  Map toJson() => {
        "metode_transfer_id": metodeTransferId,
        "metode_transfer_nama": metodeTransferNama,
        "metode_transfer_deskripsi": metodeTransferDeskripsi,
        "metode_transfer_icon": metodeTransferIcon,
      };
}
