import 'package:bus/UI/views/ClipShadowPath.dart';
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
        body: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 2 / 3,
            // color: Colors.white,
            child: ClipShadowPath(
              clipper: TicketClipper(),
              shadow:
                  Shadow(color: Colors.black.withOpacity(0.1), blurRadius: 5),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    AnimationHandler().translateFromRight(
                        const Image(
                            image: AssetImage('images/ticket.png'),
                            height: 150),
                        Curves.easeOutCubic,
                        0),
                    const SizedBox(height: 32),
                    AnimationHandler().translateFromRight(
                        Row(
                          children: [
                            const Text(
                              'کد پیگیری: ',
                              style: TextStyle(
                                  color: colorTextSub, fontSize: fontSizeSub),
                            ),
                            Text(
                              ticketViewModel.ticket.qrCode,
                              style: const TextStyle(
                                  color: colorTextPrimary,
                                  fontSize: fontSizeTitle,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Curves.easeOutCubic,
                        0),
                    Hero(
                      tag: 'cities' +
                          ticketViewModel.ticket.travelDetail.id.toString(),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Row(
                          children: [
                            Text(
                              ticketViewModel.ticket.travelDetail.source.title,
                              style: const TextStyle(
                                  shadows: [
                                    Shadow(
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 1.0,
                                      color: colorSource,
                                    ),
                                  ],
                                  color: colorSource,
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSizeTitle + 5),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  color: colorSource,
                                  boxShadow: [
                                    BoxShadow(
                                        color: colorSource.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 3),
                                  ],
                                  shape: BoxShape.circle),
                            ),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: MySeparator(color: colorTextSub),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.directions_bus,
                              color: colorTextSub,
                              size: 25,
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: colorTextSub,
                              size: 15,
                            ),
                            const SizedBox(width: 4),
                            const Expanded(
                              child: MySeparator(color: colorTextSub),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  color: colorDestination,
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            colorDestination.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 3),
                                  ],
                                  shape: BoxShape.circle),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              ticketViewModel
                                  .ticket.travelDetail.destination.title,
                              style: const TextStyle(
                                  shadows: [
                                    Shadow(
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 1.0,
                                      color: colorDestination,
                                    ),
                                  ],
                                  color: colorDestination,
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSizeTitle + 5),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Hero(
                      tag: 'busType' +
                          ticketViewModel.ticket.travelDetail.id.toString(),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // const Spacer(),
                            Text(
                              ticketViewModel
                                  .ticket.travelDetail.travel.bus.title,
                              style: const TextStyle(
                                  color: colorTextPrimary,
                                  fontSize: fontSizeTitle),
                            ),
                            const Text(
                              ' - ',
                              style: TextStyle(
                                  color: colorTextSub, fontSize: fontSizeSub),
                            ),
                            Text(
                              ticketViewModel
                                  .ticket.travelDetail.travel.bus.busType.title,
                              style: const TextStyle(
                                  color: colorTextPrimary,
                                  fontSize: fontSizeTitle),
                            ),
                            // const Spacer(),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          tag: 'dateTime' +
                              ticketViewModel.ticket.travelDetail.id.toString(),
                          child: Text(
                            ticketViewModel
                                .ticket.travelDetail.departureDatetime
                                .substring(11, 16),
                            style: const TextStyle(
                                color: colorTextPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: fontSizeTitle),
                          ),
                        ),
                        const SizedBox(width: 8),
                        AnimationHandler().translateFromLeft(
                            Text(
                              convertTojalali(ticketViewModel
                                  .ticket.travelDetail.departureDatetime),
                              style: const TextStyle(
                                  color: colorTextPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSizeTitle),
                            ),
                            Curves.easeOutCubic,
                            0),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Hero(
                      tag: 'price' +
                          ticketViewModel.ticket.travelDetail.id.toString(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 7),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ticketViewModel.ticket.travelDetail.price
                                    .toString(),
                                style: const TextStyle(
                                    color: colorTextPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: fontSizeTitle + 10),
                              ),
                              const SizedBox(width: 2),
                              const Text(
                                'تومان',
                                style: TextStyle(
                                    color: colorTextSub,
                                    fontWeight: FontWeight.normal,
                                    fontSize: fontSizeSub + 5),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        const Spacer(),
                        AnimationHandler().translateFromLeft(
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Consumer<TravelViewModel>(
                                  builder: (_, travelButtonConsumer, __) =>
                                      InkWell(
                                    onTap: () {},
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: colorPrimary,
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 3,
                                                spreadRadius: 1,
                                                color: Colors.black
                                                    .withOpacity(0.05))
                                          ]),
                                      child: travelButtonConsumer.isLoading
                                          ? const Center(
                                              child: SpinKitThreeBounce(
                                                size: 25,
                                                color: colorTextSub,
                                              ),
                                            )
                                          : Row(
                                              children: const [
                                                Text(
                                                  'صفحه اصلی',
                                                  style: TextStyle(
                                                    color: colorTextWhite,
                                                    fontSize: fontSizeTitle,
                                                  ),
                                                ),
                                                SizedBox(width: 8),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: colorTextWhite,
                                                  size: 20,
                                                )
                                              ],
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Curves.easeOutCubic,
                            0)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
