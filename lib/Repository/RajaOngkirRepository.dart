import 'package:apps/Api/ApiBaseHelperRajaOngkir.dart';

class RajaOngkirRepository {
  ApiBaseHelperRajaOngkir _helper = ApiBaseHelperRajaOngkir();

  Future getProvince(param) async {
    final response = await _helper.get("province", param);
    return response;
  }

  Future getCity(param) async {
    final response = await _helper.get("city", param);
    return response;
  }

  Future getSubDistrict(param) async {
    final response = await _helper.get("subdistrict", param);
    return response;
  }

  Future getCost(body) async {
    final response = await _helper.post("cost", body);
    return response;
  }
}
