/// id : "66"
/// no_order : "1111166"
/// id_toko : "1"
/// id_pembeli : "45"
/// subtotal : "341231"
/// total_ongkir : "91000"
/// total : "432232"
/// metode_pembayaran : "Bank Transfer"
/// status_pembayaran : "terbayar"
/// status_order : "menunggu konfirmasi"
/// total_diskon : "0"
/// total_lain_lain : "0"
/// no_resi : null
/// kode_kurir : "tiki"
/// nama_kurir : "Citra Van Titipan Kilat (TIKI)"
/// estimasi_pengiriman : "5"
/// jenis_service : "ECO"
/// no_invoice : null
/// no_rekening : "12343535353"
/// nama_rekening : "m-bangun"
/// nama_bank : "BCA"
/// created_at : "2020-08-12 09:08:04"
/// foto : "scaled_image_picker6466521002307802326.jpg"
/// nama_toko : "Toko Anugerah"
/// batas_bayar : "2020-08-13 09:08:04"
/// id_kecamatan : "1837"
/// nama_alamat : "rumah"
/// no_hp_penerima : "081314231"
/// nama_penerima : "deni"
/// alamat_lengkap : "kedamean 1"

class Order {
  String id;
  String noOrder;
  String idToko;
  String idPembeli;
  String subtotal;
  String totalOngkir;
  String total;
  String metodePembayaran;
  String statusPembayaran;
  String statusOrder;
  String totalDiskon;
  String totalLainLain;
  dynamic noResi;
  String kodeKurir;
  String namaKurir;
  String estimasiPengiriman;
  String jenisService;
  dynamic noInvoice;
  String noRekening;
  String namaRekening;
  String namaBank;
  String createdAt;
  String foto;
  String namaToko;
  String batasBayar;
  String idKecamatan;
  String namaAlamat;
  String noHpPenerima;
  String namaPenerima;
  String alamatLengkap;
  String statusUlasan;
  String tokenVa;

  static Order fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Order orderBean = Order();
    orderBean.id = map['id'];
    orderBean.noOrder = map['no_order'];
    orderBean.idToko = map['id_toko'];
    orderBean.idPembeli = map['id_pembeli'];
    orderBean.subtotal = map['subtotal'];
    orderBean.totalOngkir = map['total_ongkir'];
    orderBean.total = map['total'];
    orderBean.metodePembayaran = map['metode_pembayaran'];
    orderBean.statusPembayaran = map['status_pembayaran'];
    orderBean.statusOrder = map['status_order'];
    orderBean.totalDiskon = map['total_diskon'];
    orderBean.totalLainLain = map['total_lain_lain'];
    orderBean.noResi = map['no_resi'];
    orderBean.kodeKurir = map['kode_kurir'];
    orderBean.namaKurir = map['nama_kurir'];
    orderBean.estimasiPengiriman = map['estimasi_pengiriman'];
    orderBean.jenisService = map['jenis_service'];
    orderBean.noInvoice = map['no_invoice'];
    orderBean.noRekening = map['no_rekening'];
    orderBean.namaRekening = map['nama_rekening'];
    orderBean.namaBank = map['nama_bank'];
    orderBean.createdAt = map['created_at'];
    orderBean.foto = map['foto'];
    orderBean.namaToko = map['nama_toko'];
    orderBean.batasBayar = map['batas_bayar'];
    orderBean.idKecamatan = map['id_kecamatan'];
    orderBean.namaAlamat = map['nama_alamat'];
    orderBean.noHpPenerima = map['no_hp_penerima'];
    orderBean.namaPenerima = map['nama_penerima'];
    orderBean.alamatLengkap = map['alamat_lengkap'];
    orderBean.statusUlasan = map['status_ulasan'];
    orderBean.tokenVa = map['token_va'];
    return orderBean;
  }

  Map toJson() => {
        "id": id,
        "no_order": noOrder,
        "id_toko": idToko,
        "id_pembeli": idPembeli,
        "subtotal": subtotal,
        "total_ongkir": totalOngkir,
        "total": total,
        "metode_pembayaran": metodePembayaran,
        "status_pembayaran": statusPembayaran,
        "status_order": statusOrder,
        "total_diskon": totalDiskon,
        "total_lain_lain": totalLainLain,
        "no_resi": noResi,
        "kode_kurir": kodeKurir,
        "nama_kurir": namaKurir,
        "estimasi_pengiriman": estimasiPengiriman,
        "jenis_service": jenisService,
        "no_invoice": noInvoice,
        "no_rekening": noRekening,
        "nama_rekening": namaRekening,
        "nama_bank": namaBank,
        "created_at": createdAt,
        "foto": foto,
        "nama_toko": namaToko,
        "batas_bayar": batasBayar,
        "id_kecamatan": idKecamatan,
        "nama_alamat": namaAlamat,
        "no_hp_penerima": noHpPenerima,
        "nama_penerima": namaPenerima,
        "alamat_lengkap": alamatLengkap,
        "status_ulasan": statusUlasan,
        "token_va": tokenVa,
      };
}