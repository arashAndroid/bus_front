import 'package:bus/helpers/Constants.dart';
import 'package:bus/helpers/SharedPrefHelper.dart';
import 'package:flutter/material.dart';

class SplashViewModel with ChangeNotifier {
  final AuthServiceType authServiceType;
  SplashViewModel({this.authServiceType = AuthServiceType.real});

  bool _isFirst = true;
  bool get isFirst => _isFirst;
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  void initSplash(BuildContext context) {
    getIsFirst().then((first) {
      _isFirst = first;
      getLoggedIn().then((loggedIn) {
        _isLoggedIn = loggedIn;
        _isLoaded = true;
        notifyListeners();
      });
    });
  }
}
