import 'package:bus/core/viewmodels/TravelViewModel.dart';
import 'package:bus/helpers/Constants.dart';
import 'package:bus/helpers/MySeparator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TravelView extends StatefulWidget {
  const TravelView({Key key}) : super(key: key);

  @override
  _TravelViewState createState() => _TravelViewState();
}

class _TravelViewState extends State<TravelView> {
  TravelViewModel ticketViewModel;

  @override
  void initState() {
    super.initState();
    ticketViewModel = Provider.of<TravelViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            children: [
              const Image(image: AssetImage('images/travel.png'), height: 150),
              const SizedBox(height: 32),
              Hero(
                tag: 'cities' + ticketViewModel.travel.id.toString(),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    children: [
                      Text(
                        ticketViewModel.travel.source.title,
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
                                  color: colorDestination.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 3),
                            ],
                            shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        ticketViewModel.travel.destination.title,
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
                tag: 'busType' + ticketViewModel.travel.id.toString(),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // const Spacer(),
                      Text(
                        ticketViewModel.travel.bus.title,
                        style: const TextStyle(
                            color: colorTextPrimary, fontSize: fontSizeTitle),
                      ),
                      const Text(
                        ' - ',
                        style: TextStyle(
                            color: colorTextSub, fontSize: fontSizeSub),
                      ),
                      Text(
                        ticketViewModel.travel.bus.busType.title,
                        style: const TextStyle(
                            color: colorTextPrimary, fontSize: fontSizeTitle),
                      ),
                      // const Spacer(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Hero(
                tag: 'dateTime' + ticketViewModel.travel.id.toString(),
                child: Text(
                  ticketViewModel.travel.departureDatetime.substring(11, 16),
                  style: const TextStyle(
                      color: colorTextPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSizeTitle),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'price' + ticketViewModel.travel.id.toString(),
                    child: Text(
                      ticketViewModel.travel.price.toString(),
                      style: const TextStyle(
                          color: colorTextPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: fontSizeTitle + 10),
                    ),
                  ),
                  const SizedBox(width: 2),
                  Hero(
                    tag: "tooman" + ticketViewModel.travel.id.toString(),
                    child: const Text(
                      'تومان',
                      style: TextStyle(
                          color: colorTextSub,
                          fontWeight: FontWeight.normal,
                          fontSize: fontSizeSub + 5),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  const Spacer(),
                  Expanded(
                      child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: colorPrimary,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 3,
                                  spreadRadius: 1,
                                  color: Colors.black.withOpacity(0.05))
                            ]),
                        child: Row(
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
                    ],
                  ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
