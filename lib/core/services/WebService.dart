import 'dart:convert';

import 'package:bus/helpers/Constants.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

bool handleresponse(http.Response response) {
  if (response.statusCode == 500) {
    return false;
  } else {
    final bodyResponse = json.decode(response.body);
    int status = bodyResponse['Status'];
    switch (status) {
      case 200:
        return true;
        break;
      case 201:
        return true;
        break;
      default:
        EasyLoading.showInfo(bodyResponse['Message'] ?? 'خطای سرور');
        return false;
    }
  }
}

class WebService {
  Future<http.Response> signin(String username, String password) async {
    final url = Uri.http(baseUrl, "/api/v1/auth/signin");

    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    Map data = {
      "username": username,
      "password": password,
    };

    var body = json.encode(data);
    http.Response response = await http.post(url, headers: header, body: body);

    return response;
  }

  Future<http.Response> signup(
      String username, String password, String email) async {
    final url = Uri.http(baseUrl, "/api/v1/auth/signup");

    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    Map data = {
      "username": username,
      "password": password,
      'email': email,
    };

    var body = json.encode(data);
    http.Response response = await http.post(url, headers: header, body: body);

    return response;
  }
}
