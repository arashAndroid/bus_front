import 'package:bus/helpers/Constants.dart';
import 'package:bus/helpers/SharedPrefHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.threeBounce
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 25.0
      ..radius = 5.0
      ..progressColor = Colors.white
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.white
      ..maskType = EasyLoadingMaskType.custom
      ..textColor = Colors.white
      ..maskColor = Colors.grey.withOpacity(0.7)
      ..dismissOnTap = true;

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
