/// invoiceid : "26"
/// invoicecreate : "2020-07-07 08:56:26.050970"
/// invoice_status : "Pending"
/// invoiceaktif : "1"
/// produkid : "43"
/// invoice_tgl_bayar : null
/// invoice_nominal : "100000000"
/// invoice_termin : "Termin 1"
/// userid : "29"
/// invoice_deskripsi : "1. pembelian material\n2. pengecoran dasar"
/// produknama : "pembuatan 1 unit rumah"

class InvoiceM {
  String invoiceid;
  String invoicecreate;
  String invoiceStatus;
  String invoiceaktif;
  String produkid;
  dynamic invoiceTglBayar;
  String invoiceNominal;
  String invoiceTermin;
  String userid;
  String invoiceDeskripsi;
  String produknama;

  static InvoiceM fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    InvoiceM invoiceMBean = InvoiceM();
    invoiceMBean.invoiceid = map['invoiceid'];
    invoiceMBean.invoicecreate = map['invoicecreate'];
    invoiceMBean.invoiceStatus = map['invoice_status'];
    invoiceMBean.invoiceaktif = map['invoiceaktif'];
    invoiceMBean.produkid = map['produkid'];
    invoiceMBean.invoiceTglBayar = map['invoice_tgl_bayar'];
    invoiceMBean.invoiceNominal = map['invoice_nominal'];
    invoiceMBean.invoiceTermin = map['invoice_termin'];
    invoiceMBean.userid = map['userid'];
    invoiceMBean.invoiceDeskripsi = map['invoice_deskripsi'];
    invoiceMBean.produknama = map['produknama'];
    return invoiceMBean;
  }

  Map toJson() => {
    "invoiceid": invoiceid,
    "invoicecreate": invoicecreate,
    "invoice_status": invoiceStatus,
    "invoiceaktif": invoiceaktif,
    "produkid": produkid,
    "invoice_tgl_bayar": invoiceTglBayar,
    "invoice_nominal": invoiceNominal,
    "invoice_termin": invoiceTermin,
    "userid": userid,
    "invoice_deskripsi": invoiceDeskripsi,
    "produknama": produknama,
  };
}