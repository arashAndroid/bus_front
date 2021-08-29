import 'package:bus/UI/widgets/HalfCircle.dart';
import 'package:bus/UI/widgets/QuarterCircle.dart';
import 'package:bus/core/viewmodels/TravelViewModel.dart';
import 'package:bus/helpers/AnimationHandler.dart';
import 'package:bus/helpers/Constants.dart';
import 'package:bus/helpers/MySeparator.dart';
import 'package:bus/helpers/helperFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class TravelView extends StatefulWidget {
  const TravelView({Key key}) : super(key: key);

  @override
  _TravelViewState createState() => _TravelViewState();
}

class _TravelViewState extends State<TravelView> {
  TravelViewModel travelViewModel;

  @override
  void initState() {
    super.initState();
    travelViewModel = Provider.of<TravelViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            key: const Key('mainAppBar'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'جزئیات اتوبوس',
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
                bottom: 0,
                left: 0,
                child: Hero(
                  tag: "topBig",
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: QuarterCircle(
                      circleAlignment: QuarterCircleAlignment.bottomLeft,
                    ),
                  ),
                ),
              ),
              const Positioned(
                bottom: 0,
                left: 0,
                child: Hero(
                  tag: "topSmall",
                  child: SizedBox(
                    height: 75,
                    width: 75,
                    child: QuarterCircle(
                      circleAlignment: QuarterCircleAlignment.bottomLeft,
                    ),
                  ),
                ),
              ),
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
              SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(
                      right: 32, left: 32, bottom: 8, top: 8 + kToolbarHeight),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Column(
                    children: [
                      AnimationHandler().translateFromRight(
                          const Image(
                              image: AssetImage('images/travel.png'),
                              height: 150),
                          Curves.easeOutCubic,
                          0),
                      const SizedBox(height: 32),
                      Hero(
                        tag: 'cities' +
                            travelViewModel.travelDetail.id.toString(),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: [
                              Text(
                                travelViewModel.travelDetail.source.title,
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
                                travelViewModel.travelDetail.destination.title,
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
                            travelViewModel.travelDetail.id.toString(),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // const Spacer(),
                              Text(
                                travelViewModel.travelDetail.travel.bus.title,
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
                                travelViewModel
                                    .travelDetail.travel.bus.busType.title,
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
                            tag: 'time' +
                                travelViewModel.travelDetail.id.toString(),
                            child: Text(
                              travelViewModel.travelDetail.departureDatetime
                                  .substring(11, 16),
                              style: const TextStyle(
                                  color: colorTextPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSizeTitle),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Hero(
                            tag: 'date' +
                                travelViewModel.travelDetail.id.toString(),
                            child: Text(
                              convertTojalali(travelViewModel
                                  .travelDetail.departureDatetime),
                              style: const TextStyle(
                                  color: colorTextPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSizeTitle),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Hero(
                        tag: 'capacity' +
                            travelViewModel.travelDetail.id.toString(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 7),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  travelViewModel.travelDetail.capacity
                                      .toString(),
                                  style: const TextStyle(
                                      color: colorTextPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: fontSizeTitle + 5),
                                ),
                                const SizedBox(width: 2),
                                const Text(
                                  'صندلی خالی',
                                  style: TextStyle(
                                      color: colorTextSub,
                                      fontWeight: FontWeight.normal,
                                      fontSize: fontSizeSub),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Hero(
                        tag: 'price' +
                            travelViewModel.travelDetail.id.toString(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 7),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  travelViewModel.travelDetail.price.toString(),
                                  textDirection: TextDirection.rtl,
                                  style: const TextStyle(
                                      color: colorMoney,
                                      fontWeight: FontWeight.bold,
                                      fontSize: fontSizeTitle + 10),
                                ),
                                const SizedBox(width: 2),
                                const Text(
                                  'تومان',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      color: colorMoney,
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
                                      onTap: () {
                                        travelViewModel.generateTicket(context);
                                      },
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
                                                    'پرداخت',
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
            ],
          ),
        ),
      ),
    );
  }
}
