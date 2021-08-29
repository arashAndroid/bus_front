import 'package:bus/UI/views/ClipShadowPath.dart';
import 'package:bus/UI/widgets/HalfCircle.dart';
import 'package:bus/UI/widgets/QuarterCircle.dart';
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
import 'package:flutter/foundation.dart' show kIsWeb;

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
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          extendBodyBehindAppBar: true,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
          body: Stack(
            children: [
              const Positioned(
                top: 0,
                right: 0,
                child: Hero(
                  tag: "bottomBig",
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: QuarterCircle(
                      circleAlignment: QuarterCircleAlignment.topRight,
                    ),
                  ),
                ),
              ),
              const Positioned(
                top: 0,
                right: 0,
                child: Hero(
                  tag: "bottomSmall",
                  child: SizedBox(
                    height: 75,
                    width: 75,
                    child: QuarterCircle(
                      circleAlignment: QuarterCircleAlignment.topRight,
                    ),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: Hero(
                  tag: "topBig",
                  child: SizedBox(
                    height: 100,
                    width: 200,
                    child: HalfCircle(
                      circleAlignment: HalfCircleAlignment.bottom,
                    ),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: Hero(
                  tag: "topSmall",
                  child: SizedBox(
                    height: 50,
                    width: 100,
                    child: HalfCircle(
                      circleAlignment: HalfCircleAlignment.bottom,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  constraints: kIsWeb
                      ? BoxConstraints(maxWidth: size.width / 2)
                      : const BoxConstraints(),
                  margin: const EdgeInsets.only(
                      right: 16, left: 16, bottom: 8, top: 8 + kToolbarHeight),
                  // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 4 / 5,
                  // color: Colors.white,
                  child: ClipShadowPath(
                    clipper: TicketClipper(),
                    shadow: Shadow(
                        color: Colors.black.withOpacity(0.1), blurRadius: 5),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 32, right: 32, top: 32, bottom: 16),
                      color: Colors.white,
                      child: SingleChildScrollView(
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
                                    text: ticketViewModel.ticket.travelDetail
                                            .departureDatetime
                                            .substring(11, 16) +
                                        ' - ' +
                                        convertTojalali(ticketViewModel.ticket
                                            .travelDetail.departureDatetime),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TicketItem(
                                    title: 'مبدا',
                                    text: ticketViewModel
                                        .ticket.travelDetail.source.title,
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
                                    text: ticketViewModel.ticket.travelDetail
                                        .travel.bus.busType.title,
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
                                    text: ticketViewModel.ticket.travelDetail
                                            .travel.driver.firstName +
                                        ' ' +
                                        ticketViewModel.ticket.travelDetail
                                            .travel.driver.lastName,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TicketItem(
                                    title: 'قیمت',
                                    text: ticketViewModel
                                            .ticket.travelDetail.price
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
