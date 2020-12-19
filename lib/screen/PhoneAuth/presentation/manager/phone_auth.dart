import 'package:apps/Repository/AuthRepository.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier, VoidCallback;
import 'package:flutter/widgets.dart' show TextEditingController;

enum PhoneAuthState {
  Started,
  CodeSent,
  CodeResent,
  Verified,
  Failed,
  Error,
  AutoRetrievalTimeOut
}

class PhoneAuthDataProvider with ChangeNotifier {
  

  bool _loading = false;

  final TextEditingController _phoneNumberController = TextEditingController();

  
  String _phone, _message;
  bool _isLogin = false;

  bool get isLogin => _isLogin;

  Future sendOtp(body) async {
    var result = await AuthRepository().sendOtp(body);
    return result;
  }
 
  Future verifyOTPAndLogin(body) async {
    _loading = true;
    notifyListeners();
    var result = await AuthRepository().checkOtp(body);
    _loading = false;
    notifyListeners();
    return result;
  }

  get phone => _phone;

  set phone(String value) {
    _phone = value;
    notifyListeners();
  }

  get message => _message;

  set message(String value) {
    _message = value;
    notifyListeners();
  }

  // PhoneAuthState get status => _status;

  // set status(PhoneAuthState value) {
  //   _status = value;
  //   notifyListeners();
  // }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  TextEditingController get phoneNumberController => _phoneNumberController;
}
