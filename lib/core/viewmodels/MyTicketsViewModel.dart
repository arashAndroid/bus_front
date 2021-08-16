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

  // MyTicketsViewModel ticket;

  Future<bool> getResults(BuildContext context) async {
    http.Response response;

    response = await WebService().getMyTickets();
    if (handleResponse(response)) {
      final bodyResponse = json.decode(response.body);

      List<Ticket> travelDetails = bodyResponse["Data"]
          .map<Ticket>((json) => Ticket.fromJson(json))
          .toList();

    //   if (travelDetails.isEmpty) {
    //     EasyLoading.showInfo('اتوبوسی برای این تاریخ وجود ندارد');
    //   } else {
    //     ResultViewModel resultViewModel =
    //         Provider.of<ResultViewModel>(context, listen: false);
    //     resultViewModel.travelDetails = travelDetails;
    //     Navigator.of(context).pushNamed('/ResultView');
    //   }

    //   print('travel length = ${travelDetails.length}');
    }

    return false;
  }
}
