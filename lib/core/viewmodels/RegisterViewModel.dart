import 'dart:convert';

import 'package:bus/core/services/WebService.dart';
import 'package:bus/helpers/Constants.dart';
import 'package:bus/helpers/SharedPrefHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RegisterViewModel with ChangeNotifier {
  final AuthServiceType authServiceType;

  RegisterViewModel({this.authServiceType = AuthServiceType.real});
  final TextEditingController _usernameController = TextEditingController();
  TextEditingController get usernameController => _usernameController;
  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;
  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  signup(BuildContext context) {
    if (_usernameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _emailController.text.isEmpty) {
      EasyLoading.showInfo('نام کاربری، رمز ورود وایمیل را وارد کنید');
    } else {
      postSignup(context);
    }
  }

  postSignup(BuildContext context) {
    _isLoading = true;
    notifyListeners();
    WebService()
        .signup(_usernameController.text, _passwordController.text,
            _emailController.text)
        .then((response) {
      if (response.statusCode == 500) {
        _isLoading = false;
        notifyListeners();
        EasyLoading.showInfo('خطای ارتباط با سرور');
      } else {
        final bodyResponse = json.decode(response.body);
        String status = bodyResponse['status'];
        print(bodyResponse);
        switch (status) {
          case "200":
            final bodyResponse = json.decode(response.body);
            final data = bodyResponse['data'];
            _isLoading = false;
            notifyListeners();
            setLoggedIn(data['id'], data['userName'], data['email'],
                    data['credit'] ?? 0, data['accessToken'])
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
      }
    });
  }
}
