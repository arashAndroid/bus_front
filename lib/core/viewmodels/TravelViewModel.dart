import 'dart:convert';

import 'package:bus/core/models/Ticket.dart';
import 'package:bus/core/models/TravelDetail.dart';
import 'package:bus/core/services/WebService.dart';
import 'package:bus/core/viewmodels/TicketViewModel.dart';
import 'package:bus/helpers/Constants.dart';
import 'package:bus/helpers/SharedPrefHelper.dart';
import 'package:bus/helpers/helperFunctions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TravelViewModel with ChangeNotifier {
  final AuthServiceType authServiceType;
  TravelViewModel({this.authServiceType = AuthServiceType.real});

  TravelDetail travelDetail;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void generateTicket(BuildContext context) {
    _isLoading = true;
    notifyListeners();
    String qrCode = randomQrCode(10000, 99999).toString();
    getUser().then((user) {
      WebService()
          .postTicket(qrCode, travelDetail.id, user.id)
          .then((response) {
        if (handleResponse(response)) {
          TicketViewModel ticketViewModel =
              Provider.of<TicketViewModel>(context, listen: false);
          final bodyResponse = json.decode(response.body);
          print('response.body = ' + response.body);
          ticketViewModel.ticket = Ticket.fromJson(bodyResponse["Data"]);
          _isLoading = false;
          notifyListeners();
          Navigator.of(context).pushNamed('/TicketView');
        }
      });
    });
  }
}
