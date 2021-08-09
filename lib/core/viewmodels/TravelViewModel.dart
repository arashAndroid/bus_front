import 'package:bus/core/models/Travel.dart';
import 'package:bus/helpers/Constants.dart';
import 'package:flutter/material.dart';

class TravelViewModel with ChangeNotifier {
  final AuthServiceType authServiceType;
  TravelViewModel({this.authServiceType = AuthServiceType.real});

  Travel travel;
}
