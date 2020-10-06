import 'package:apps/Api/ApiBaseHelper.dart';

class AuthRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future googleSign(body) async {
    final response = await _helper.post("token/googleSignMitra", body);
    return response;
  }

  Future checkVersionApp(param) async {
    final response = await _helper.get("version/getAllMitralByParam", param);
    return response;
  }

  Future getNotification(param) async {
    final response = await _helper.get("notification/getAllNotifMitraByParam", param);
    return response;
  }

  Future setFcmToken(param) async {
    final response = await _helper.post("user/insertSessionLoginMitra", param);
    return response;
  }

  Future updateNotification(param) async {
    final response = await _helper.post("notification/updateNotificationMitra", param);
    return response;
  }

  Future deleteFcmToken(param) async {
    final response = await _helper.post("user/deleteSessionLoginMitra", param);
    return response;
  }

  Future create(body) async {
    final response = await _helper.post("user/insert", body);
    return response;
  }
}
