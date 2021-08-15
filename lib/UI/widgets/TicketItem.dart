import 'package:bus/helpers/Constants.dart';
import 'package:flutter/material.dart';

class TicketItem extends StatelessWidget {
  final String title;
  final String text;
  const TicketItem({Key key, this.title, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(
            title,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              color: colorTextSub,
              fontSize: fontSizeSub,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            text,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
                color: colorTextPrimary,
                fontSize: fontSizeTitle,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
