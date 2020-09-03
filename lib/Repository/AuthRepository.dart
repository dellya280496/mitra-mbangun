import 'package:apps/Api/ApiBaseHelper.dart';

class AuthRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future googleSign(body) async {
    final response = await _helper.post("token/googleSignMitra", body);
    return response;
  }

  Future checkVersionApp(param) async {
    final response = await _helper.get("version/getAllByParam", param);
    return response;
  }

  Future create(body) async {
    final response = await _helper.post("user/insert", body);
    return response;
  }
}
