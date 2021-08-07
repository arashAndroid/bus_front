import 'package:bus/helpers/Constants.dart';
import 'package:flutter/material.dart';

class NoInternetWidget extends StatefulWidget {
  final Function function;
  final BuildContext context;
  const NoInternetWidget({Key key, this.function, this.context})
      : super(key: key);

  @override
  _NoInternetWidgetState createState() => _NoInternetWidgetState();
}

class _NoInternetWidgetState extends State<NoInternetWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.wifi_off_rounded,
            color: colorTextSub,
            size: 100,
          ),
          const SizedBox(height: 16),
          const Text(
            'اتصال با اینترنت برقرار نیست',
            style: TextStyle(
                color: colorTextSub,
                fontSize: fontSizeTitle + 5,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              widget.function(widget.context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                  color: colorPrimary,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12, spreadRadius: 1, blurRadius: 5)
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'بارگزاری مجدد',
                    style: TextStyle(
                        color: colorTextWhite,
                        fontWeight: FontWeight.bold,
                        fontSize: fontSizeTitle),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.refresh,
                    color: colorTextWhite,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
