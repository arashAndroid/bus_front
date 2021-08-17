import 'dart:convert';

import 'package:bus/core/models/Ticket.dart';
import 'package:bus/core/models/TravelDetail.dart';
import 'package:bus/core/services/WebService.dart';
import 'package:bus/helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'ResultViewModel.dart';

class MyTicketsViewModel with ChangeNotifier {
  final AuthServiceType authServiceType;
  MyTicketsViewModel({this.authServiceType = AuthServiceType.real});

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<Ticket> tickets = [];

  Future<bool> getResults(BuildContext context) async {
    http.Response response;

    response = await WebService().getMyTickets();
    if (handleResponse(response)) {
      final bodyResponse = json.decode(response.body);

      tickets = bodyResponse["Data"]
          .map<Ticket>((json) => Ticket.fromJson(json))
          .toList();

      _isLoading = false;
      notifyListeners();

      return true;
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }
}
