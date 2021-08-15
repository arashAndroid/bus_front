import 'package:bus/UI/views/ClipShadowPath.dart';
import 'package:bus/UI/widgets/TicketItem.dart';
import 'package:bus/core/viewmodels/MainViewModel.dart';
import 'package:bus/core/viewmodels/TicketViewModel.dart';
import 'package:bus/core/viewmodels/TravelViewModel.dart';
import 'package:bus/helpers/AnimationHandler.dart';
import 'package:bus/helpers/Constants.dart';
import 'package:bus/helpers/TicketWidget.dart';
import 'package:bus/helpers/MySeparator.dart';
import 'package:bus/helpers/helperFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketView extends StatefulWidget {
  const TicketView({Key key}) : super(key: key);

  @override
  _TicketViewState createState() => _TicketViewState();
}

class _TicketViewState extends State<TicketView> {
  TicketViewModel ticketViewModel;

  @override
  void initState() {
    super.initState();
    ticketViewModel = Provider.of<TicketViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: colorBackground,
        appBar: AppBar(
          key: const Key('mainAppBar'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            InkWell(
              onTap: () {
                MainViewModel mainViewModel =
                    Provider.of<MainViewModel>(context, listen: false);
                mainViewModel.setIsFirst(true);
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/MainView', (route) => false);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                alignment: Alignment.center,
                child: const Text(
                  'بازگشت به صفحه اصلی',
                  style: TextStyle(color: Colors.lightBlueAccent),
                ),
              ),
            )
          ],
          title: const Text(
            'بلیط صادر شد',
            style: TextStyle(
              color: colorTextPrimary,
              fontSize: fontSizeTitle + 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: const IconThemeData(color: colorTextPrimary),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 4 / 5,
          // color: Colors.white,
          child: ClipShadowPath(
            clipper: TicketClipper(),
            shadow: Shadow(color: Colors.black.withOpacity(0.1), blurRadius: 5),
            child: Container(
              padding: const EdgeInsets.only(
                  left: 32, right: 32, top: 32, bottom: 16),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TicketItem(
                          title: 'نام کاربر',
                          text: ticketViewModel.ticket.user.username,
                        ),
                      ),
                      Expanded(
                        child: TicketItem(
                          title: 'تاریخ حرکت',
                          text: ticketViewModel
                                  .ticket.travelDetail.departureDatetime
                                  .substring(11, 16) +
                              ' - ' +
                              convertTojalali(ticketViewModel
                                  .ticket.travelDetail.departureDatetime),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TicketItem(
                          title: 'مبدا',
                          text:
                              ticketViewModel.ticket.travelDetail.source.title,
                        ),
                      ),
                      Expanded(
                        child: TicketItem(
                          title: 'مقصد',
                          text: ticketViewModel
                              .ticket.travelDetail.destination.title,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TicketItem(
                          title: 'اتوبوس',
                          text: ticketViewModel
                              .ticket.travelDetail.travel.bus.title,
                        ),
                      ),
                      Expanded(
                        child: TicketItem(
                          title: 'مدل',
                          text: ticketViewModel
                              .ticket.travelDetail.travel.bus.busType.title,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TicketItem(
                          title: 'پلاک',
                          text: ticketViewModel
                              .ticket.travelDetail.travel.bus.plate,
                        ),
                      ),
                      Expanded(
                        child: TicketItem(
                          title: 'راننده',
                          text: ticketViewModel
                                  .ticket.travelDetail.travel.driver.firstName +
                              ' ' +
                              ticketViewModel
                                  .ticket.travelDetail.travel.driver.lastName,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TicketItem(
                          title: 'قیمت',
                          text: ticketViewModel.ticket.travelDetail.price
                                  .toString() +
                              ' تومان',
                        ),
                      ),
                      Expanded(
                        child: TicketItem(
                          title: 'کد پیگیری',
                          text: ticketViewModel.ticket.qrCode,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  QrImage(
                    data: ticketViewModel.ticket.qrCode,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
