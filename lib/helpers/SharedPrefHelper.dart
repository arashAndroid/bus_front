import 'package:bus/core/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> getLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  return isLoggedIn;
}

Future<User> getUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return User(
      id: prefs.getInt('id'),
      username: prefs.getString('username'),
      email: prefs.getString('email'),
      cash: prefs.getInt('cash'));
}

Future<bool> setLoggedIn(
    int id, String username, String email, int cash, String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('id', id);
  prefs.setString('username', username);
  prefs.setString('email', email);
  prefs.setInt('cash', cash);
  prefs.setString('accessToken', token);
  prefs.setBool('isLoggedIn', true);
  return true;
}

Future<bool> setLoggedOut() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('username', '');
  prefs.setString('email', '');
  prefs.setInt('cash', 0);
  prefs.setString('accessToken', '');
  prefs.setBool('isLoggedIn', false);
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
  prefs.setBool('isFirst', false);
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
