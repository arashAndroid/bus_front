import 'package:bus/helpers/Constants.dart';
import 'package:flutter/material.dart';

class MainViewModel with ChangeNotifier {
  final AuthServiceType authServiceType;

  MainViewModel({this.authServiceType = AuthServiceType.real});
}
