import 'package:shared_preferences/shared_preferences.dart';

Future<bool> getLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') == null
      ? false
      : prefs.getBool('isLoggedIn') as bool;
  return isLoggedIn;
}

Future<bool> setLoggedIn(
    String username, String email, int cash, String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('username', username);
  prefs.setString('email', email);
  prefs.setInt('cash', cash);
  prefs.setString('accessToken', token);
  prefs.setBool('isLoggedIn', true);
  return true;
}

Future<bool> getIsFirst() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirst;
  if (prefs.getBool('isFirst') == null) {
    isFirst = true;
  } else {
    isFirst = prefs.getBool('isFirst');
  }
  return isFirst;
}

Future<bool> setIsFirst() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isFirst', true);
  return true;
}

Future<String> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String phone;
  if (prefs.getString('accessToken') == null) {
    phone = ' ';
  } else {
    phone = prefs.getString('accessToken');
  }
  return phone;
}
