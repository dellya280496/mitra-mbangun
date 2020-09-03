/// bankid : "1"
/// bank_nama : "BCA"
/// bank_nomor_rek : "********"
/// bank_logo : "bca.png"

class BankM {
  String bankid;
  String bankNama;
  String bankNomorRek;
  String bankLogo;

  static BankM fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BankM bankMBean = BankM();
    bankMBean.bankid = map['bankid'];
    bankMBean.bankNama = map['bank_nama'];
    bankMBean.bankNomorRek = map['bank_nomor_rek'];
    bankMBean.bankLogo = map['bank_logo'];
    return bankMBean;
  }

  Map toJson() => {
        "bankid": bankid,
        "bank_nama": bankNama,
        "bank_nomor_rek": bankNomorRek,
        "bank_logo": bankLogo,
      };
}
