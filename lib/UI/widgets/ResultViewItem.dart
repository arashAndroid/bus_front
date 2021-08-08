import 'package:bus/core/models/Travel.dart';
import 'package:bus/helpers/Constants.dart';
import 'package:bus/helpers/MySeparator.dart';
import 'package:flutter/material.dart';

class ResultViewItem extends StatelessWidget {
  final Travel travel;
  const ResultViewItem({Key key, this.travel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
          Row(
            children: [
              Text(
                travel.source.title,
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
                travel.destination.title,
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
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const Spacer(),
              Text(
                travel.bus.title,
                style:
                    const TextStyle(color: colorTextSub, fontSize: fontSizeSub),
              ),
              const Text(
                ' - ',
                style: TextStyle(color: colorTextSub, fontSize: fontSizeSub),
              ),
              Text(
                travel.bus.busType.title,
                style:
                    const TextStyle(color: colorTextSub, fontSize: fontSizeSub),
              ),
              // const Spacer(),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                travel.departureDatetime.substring(11, 16),
                style: const TextStyle(
                    color: colorTextPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSizeTitle),
              ),
              const Spacer(),
              Text(
                travel.price.toString(),
                style: const TextStyle(
                    color: colorTextPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSizeTitle),
              ),
              const SizedBox(width: 2),
              const Text(
                'تومان',
                style: TextStyle(
                    color: colorTextSub,
                    fontWeight: FontWeight.normal,
                    fontSize: fontSizeSub),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
