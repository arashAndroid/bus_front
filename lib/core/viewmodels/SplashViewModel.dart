import 'package:bus/helpers/Constants.dart';
import 'package:flutter/material.dart';

class SplashViewModel with ChangeNotifier {
  final AuthServiceType authServiceType;

  SplashViewModel({this.authServiceType = AuthServiceType.real});
}
