/// statusnama : "New"
/// bidid : "29"
/// userid : "26"
/// produkid : "31"
/// bidcreate : "2020-06-25 08:02:46.880019"
/// bidupdate : null
/// statusid : "8"
/// biddeskripsi : "asd"
/// bidprice : "23120"
/// produknama : "Perbaikan atap bocor"

class BidM {
  String statusnama;
  String bidid;
  String userid;
  String produkid;
  String bidcreate;
  dynamic bidupdate;
  String statusid;
  String biddeskripsi;
  String bidprice;
  String produknama;
  String bidwaktupengerjaan;
  String userfoto;
  String userbidnama;

  static BidM fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BidM bidMBean = BidM();
    bidMBean.statusnama = map['statusnama'];
    bidMBean.bidid = map['bidid'];
    bidMBean.userid = map['userid'];
    bidMBean.produkid = map['produkid'];
    bidMBean.bidcreate = map['bidcreate'];
    bidMBean.bidupdate = map['bidupdate'];
    bidMBean.statusid = map['statusid'];
    bidMBean.biddeskripsi = map['biddeskripsi'];
    bidMBean.bidprice = map['bidprice'];
    bidMBean.produknama = map['produknama'];
    bidMBean.bidwaktupengerjaan = map['bidwaktupengerjaan'];
    bidMBean.userfoto = map['userfoto'];
    bidMBean.userbidnama = map['userbidnama'];
    return bidMBean;
  }

  Map toJson() => {
    "statusnama": statusnama,
        "bidid": bidid,
        "userid": userid,
        "produkid": produkid,
        "bidcreate": bidcreate,
        "bidupdate": bidupdate,
        "statusid": statusid,
        "biddeskripsi": biddeskripsi,
        "bidprice": bidprice,
        "produknama": produknama,
        "bidwaktupengerjaan": bidwaktupengerjaan,
        "userfoto": userfoto,
        "userbidnama": userbidnama,
      };
}