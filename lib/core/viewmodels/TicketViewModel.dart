import 'package:bus/core/models/Ticket.dart';
import 'package:bus/helpers/Constants.dart';
import 'package:flutter/material.dart';

class TicketViewModel with ChangeNotifier {
  final AuthServiceType authServiceType;
  TicketViewModel({this.authServiceType = AuthServiceType.real});

  Ticket ticket;
}
