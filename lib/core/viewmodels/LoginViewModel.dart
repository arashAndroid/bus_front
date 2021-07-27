import 'package:bus/helpers/Constants.dart';
import 'package:flutter/material.dart';

class LoginViewModel with ChangeNotifier {
  final AuthServiceType authServiceType;

  LoginViewModel({this.authServiceType = AuthServiceType.real});
}
