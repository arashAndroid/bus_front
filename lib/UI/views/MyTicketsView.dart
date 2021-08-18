import 'package:bus/UI/views/ClipShadowPath.dart';
import 'package:bus/UI/widgets/HalfCircle.dart';
import 'package:bus/UI/widgets/TicketItem.dart';
import 'package:bus/UI/widgets/TravelItem.dart';
import 'package:bus/core/viewmodels/MainViewModel.dart';
import 'package:bus/core/viewmodels/MyTicketsViewModel.dart';
import 'package:bus/helpers/Constants.dart';
import 'package:bus/helpers/TicketWidget.dart';
import 'package:bus/helpers/helperFunctions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:bus/core/viewmodels/TicketViewModel.dart';
import 'package:bus/core/viewmodels/TravelViewModel.dart';
import 'package:bus/helpers/AnimationHandler.dart';
import 'package:bus/helpers/Constants.dart';
import 'package:bus/helpers/MySeparator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyTicketsView extends StatefulWidget {
  const MyTicketsView({Key key}) : super(key: key);

  @override
  _MyTicketsViewState createState() => _MyTicketsViewState();
}

class _MyTicketsViewState extends State<MyTicketsView> {
  MyTicketsViewModel myTicketsViewModel;

  @override
  void initState() {
    super.initState();
    myTicketsViewModel =
        Provider.of<MyTicketsViewModel>(context, listen: false);
    myTicketsViewModel.getResults(context);
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
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'بلیط‌های من',
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
                alignment: Alignment.centerRight,
                child: Hero(
                  tag: "bottomBig",
                  child: SizedBox(
                    height: 200,
                    width: 100,
                    child: HalfCircle(
                      circleAlignment: HalfCircleAlignment.right,
                    ),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: Hero(
                  tag: "bottomSmall",
                  child: SizedBox(
                    height: 100,
                    width: 50,
                    child: HalfCircle(
                      circleAlignment: HalfCircleAlignment.right,
                    ),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Hero(
                  tag: "topBig",
                  child: SizedBox(
                    height: 200,
                    width: 100,
                    child: HalfCircle(
                      circleAlignment: HalfCircleAlignment.left,
                    ),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Hero(
                  tag: "topSmall",
                  child: SizedBox(
                    height: 100,
                    width: 50,
                    child: HalfCircle(
                      circleAlignment: HalfCircleAlignment.left,
                    ),
                  ),
                ),
              ),
              Consumer<MyTicketsViewModel>(
                builder: (_, myTicketConsumer, __) => myTicketConsumer.isLoading
                    ? const Center(
                        child: SpinKitThreeBounce(
                          color: colorPrimary,
                          size: 25,
                        ),
                      )
                    : ListView.builder(
                        itemCount: myTicketConsumer.tickets.length,
                        itemBuilder: (context, index) =>
                            AnimationHandler().translateFromRight(
                                TravelItem(
                                  travelDetail: myTicketConsumer
                                      .tickets[index].travelDetail,
                                  ticket: myTicketConsumer.tickets[index],
                                  routeName: '/MyTicketDetailView',
                                ),
                                Curves.easeOutCubic,
                                index * 200.0)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
