import 'package:bus/core/models/Ticket.dart';
import 'package:bus/core/models/Travel.dart';
import 'package:bus/core/models/TravelDetail.dart';
import 'package:bus/core/viewmodels/MyTicketDetailViewModel.dart';
import 'package:bus/core/viewmodels/TravelViewModel.dart';
import 'package:bus/helpers/Constants.dart';
import 'package:bus/helpers/MySeparator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TravelItem extends StatelessWidget {
  final TravelDetail travelDetail;
  final String routeName;
  final Ticket ticket;
  const TravelItem(
      {Key key, this.travelDetail, this.routeName = '/TravelView', this.ticket})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (routeName == '/MyTicketDetailView') {
          MyTicketDetailViewModel myTicketDetailViewModel =
              Provider.of<MyTicketDetailViewModel>(context, listen: false);
          myTicketDetailViewModel.ticket = ticket;
        } else {
          TravelViewModel travelViewModel =
              Provider.of<TravelViewModel>(context, listen: false);
          travelViewModel.travelDetail = travelDetail;
        }
        Navigator.of(context).pushNamed(routeName);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: 5),
          ],
        ),
        child: Column(
          children: [
            Hero(
              tag: 'cities' +
                  travelDetail.id.toString() +
                  (ticket == null ? '' : ticket.id.toString()),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  children: [
                    Text(
                      travelDetail.source.title,
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
                          fontSize: fontSizeTitle),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 7,
                      height: 7,
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
                      width: 7,
                      height: 7,
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
                      travelDetail.destination.title,
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
                          fontSize: fontSizeTitle),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Hero(
              tag: 'busType' +
                  travelDetail.id.toString() +
                  (ticket == null ? '' : ticket.id.toString()),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // const Spacer(),
                    Text(
                      travelDetail.travel.bus.title,
                      style: const TextStyle(
                          color: colorTextSub, fontSize: fontSizeSub),
                    ),
                    const Text(
                      ' - ',
                      style:
                          TextStyle(color: colorTextSub, fontSize: fontSizeSub),
                    ),
                    Text(
                      travelDetail.travel.bus.busType.title,
                      style: const TextStyle(
                          color: colorTextSub, fontSize: fontSizeSub),
                    ),
                    // const Spacer(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Hero(
                  tag: 'dateTime' +
                      travelDetail.id.toString() +
                      (ticket == null ? '' : ticket.id.toString()),
                  child: Text(
                    travelDetail.departureDatetime.substring(11, 16),
                    style: const TextStyle(
                        color: colorTextPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: fontSizeTitle),
                  ),
                ),
                const Spacer(),
                Hero(
                  tag: 'price' +
                      travelDetail.id.toString() +
                      (ticket == null ? '' : ticket.id.toString()),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 7),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            travelDetail.price.toString(),
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(
                                color: colorTextPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: fontSizeTitle),
                          ),
                          const SizedBox(width: 2),
                          const Text(
                            'تومان',
                            textDirection: TextDirection.rtl,
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
