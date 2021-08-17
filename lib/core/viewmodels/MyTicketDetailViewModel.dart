import 'package:bus/core/models/Ticket.dart';
import 'package:bus/helpers/Constants.dart';
import 'package:flutter/material.dart';

class MyTicketDetailViewModel with ChangeNotifier {
  final AuthServiceType authServiceType;
  MyTicketDetailViewModel({this.authServiceType = AuthServiceType.real});

  Ticket ticket;
}
