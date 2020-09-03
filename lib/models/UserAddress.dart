/// id : "16"
/// nama_penerima : "dadsa"
/// no_hp : "123111"
/// id_kecamatan : "5438"
/// id_kota : null
/// id_provinsi : null
/// alamat_lengkap : "sdada"
/// defaultAlamat : "1"
/// id_user : "45"
/// nama_alamat : "sdad"

class UserAddress {
  String id;
  String namaPenerima;
  String noHp;
  String idKecamatan;
  dynamic idKota;
  dynamic idProvinsi;
  String alamatLengkap;
  String defaultAlamat;
  String idUser;
  String namaAlamat;

  static UserAddress fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    UserAddress userAddressBean = UserAddress();
    userAddressBean.id = map['id'];
    userAddressBean.namaPenerima = map['nama_penerima'];
    userAddressBean.noHp = map['no_hp'];
    userAddressBean.idKecamatan = map['id_kecamatan'];
    userAddressBean.idKota = map['id_kota'];
    userAddressBean.idProvinsi = map['id_provinsi'];
    userAddressBean.alamatLengkap = map['alamat_lengkap'];
    userAddressBean.defaultAlamat = map['default'];
    userAddressBean.idUser = map['id_user'];
    userAddressBean.namaAlamat = map['nama_alamat'];
    return userAddressBean;
  }

  Map toJson() => {
        "id": id,
        "nama_penerima": namaPenerima,
        "no_hp": noHp,
        "id_kecamatan": idKecamatan,
        "id_kota": idKota,
        "id_provinsi": idProvinsi,
        "alamat_lengkap": alamatLengkap,
        "default": defaultAlamat,
        "id_user": idUser,
        "nama_alamat": namaAlamat,
      };
}