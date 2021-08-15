import 'package:bus/core/models/TravelDetail.dart';
import 'package:bus/helpers/Constants.dart';
import 'package:flutter/material.dart';

class ResultViewModel with ChangeNotifier {
  final AuthServiceType authServiceType;
  ResultViewModel({this.authServiceType = AuthServiceType.real});
  List<TravelDetail> travelDetails = [];
  // List<Travel> get travels => _travels;
}
