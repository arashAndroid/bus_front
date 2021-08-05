import 'package:bus/helpers/Constants.dart';
import 'package:flutter/material.dart';

class RegisterViewModel with ChangeNotifier {
  final AuthServiceType authServiceType;

  RegisterViewModel({this.authServiceType = AuthServiceType.real});
}
