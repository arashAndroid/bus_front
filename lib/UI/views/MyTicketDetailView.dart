import 'package:bus/UI/views/ClipShadowPath.dart';
import 'package:bus/UI/widgets/QuarterCircle.dart';
import 'package:bus/UI/widgets/TicketItem.dart';
import 'package:bus/core/viewmodels/MainViewModel.dart';
import 'package:bus/core/viewmodels/MyTicketDetailViewModel.dart';
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

class MyTicketDetailView extends StatefulWidget {
  const MyTicketDetailView({Key key}) : super(key: key);

  @override
  _MyTicketDetailViewState createState() => _MyTicketDetailViewState();
}

class _MyTicketDetailViewState extends State<MyTicketDetailView> {
  MyTicketDetailViewModel myTicketDetailViewModel;

  @override
  void initState() {
    super.initState();
    myTicketDetailViewModel =
        Provider.of<MyTicketDetailViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
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
            title: const Text(
              'جزئیات بلیط',
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
              const Align(
                alignment: Alignment.bottomRight,
                child: Hero(
                  tag: "bottomBig",
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: QuarterCircle(
                      circleAlignment: QuarterCircleAlignment.bottomRight,
                    ),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.bottomRight,
                child: Hero(
                  tag: "bottomSmall",
                  child: SizedBox(
                    height: 75,
                    width: 75,
                    child: QuarterCircle(
                      circleAlignment: QuarterCircleAlignment.bottomRight,
                    ),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Hero(
                  tag: "topBig",
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: QuarterCircle(
                      circleAlignment: QuarterCircleAlignment.topLeft,
                    ),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Hero(
                  tag: "topSmall",
                  child: SizedBox(
                    height: 75,
                    width: 75,
                    child: QuarterCircle(
                      circleAlignment: QuarterCircleAlignment.topLeft,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: 16, right: 16, bottom: 8, top: 8 + kToolbarHeight),
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
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TicketItem(
                                title: 'نام کاربر',
                                text: myTicketDetailViewModel
                                    .ticket.user.username,
                              ),
                            ),
                            Expanded(
                              child: TicketItem(
                                title: 'تاریخ حرکت',
                                text: myTicketDetailViewModel
                                        .ticket.travelDetail.departureDatetime
                                        .substring(11, 16) +
                                    ' - ' +
                                    convertTojalali(myTicketDetailViewModel
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
                                text: myTicketDetailViewModel
                                    .ticket.travelDetail.source.title,
                              ),
                            ),
                            Expanded(
                              child: TicketItem(
                                title: 'مقصد',
                                text: myTicketDetailViewModel
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
                                text: myTicketDetailViewModel
                                    .ticket.travelDetail.travel.bus.title,
                              ),
                            ),
                            Expanded(
                              child: TicketItem(
                                title: 'مدل',
                                text: myTicketDetailViewModel.ticket
                                    .travelDetail.travel.bus.busType.title,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TicketItem(
                                title: 'پلاک',
                                text: myTicketDetailViewModel
                                    .ticket.travelDetail.travel.bus.plate,
                              ),
                            ),
                            Expanded(
                              child: TicketItem(
                                title: 'راننده',
                                text: myTicketDetailViewModel.ticket
                                        .travelDetail.travel.driver.firstName +
                                    ' ' +
                                    myTicketDetailViewModel.ticket.travelDetail
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
                                text: myTicketDetailViewModel
                                        .ticket.travelDetail.price
                                        .toString() +
                                    ' تومان',
                              ),
                            ),
                            Expanded(
                              child: TicketItem(
                                title: 'کد پیگیری',
                                text: myTicketDetailViewModel.ticket.qrCode,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        QrImage(
                          data: myTicketDetailViewModel.ticket.qrCode,
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                        const Spacer(),
                      ],
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
