import 'dart:convert';
import 'package:bus/core/services/WebService.dart';
import 'package:bus/helpers/Constants.dart';
import 'package:bus/helpers/SharedPrefHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginViewModel with ChangeNotifier {
  final AuthServiceType authServiceType;
  LoginViewModel({this.authServiceType = AuthServiceType.real});

  final TextEditingController _usernameController = TextEditingController();
  TextEditingController get usernameController => _usernameController;
  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  signin(BuildContext context) {
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      EasyLoading.showInfo('نام کاربری و رمز عبور را وارد کنید');
    } else {
      postSignin(context);
    }
  }

  postSignin(BuildContext context) {
    _isLoading = true;
    notifyListeners();
    WebService()
        .signin(_usernameController.text, _passwordController.text)
        .then((response) {
      final bodyResponse = json.decode(response.body);
      String status = bodyResponse['status'];
      print(bodyResponse);
      switch (status) {
        case "200":
          final bodyResponse = json.decode(response.body);
          final data = bodyResponse['data'];
          _isLoading = false;
          notifyListeners();
          setLoggedIn(data['userName'], data['email'], data['credit'] ?? 0,
                  data['accessToken'])
              .then((value) {
            Navigator.of(context).pushNamed('/MainView');
          });
          return true;
          break;

        default:
          _isLoading = false;
          notifyListeners();
          EasyLoading.showInfo(bodyResponse['message'] ?? 'خطای سرور');
          return false;
      }
    });
  }
}
