import 'package:flutter/material.dart';
import '../../helpers/Constants.dart';

Widget drawerItem({String title, IconData icon}) {
  return Container(
    margin: const EdgeInsets.only(right: 4),
    child: Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: colorPrimary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon ?? Icons.add,
            color: colorPrimary,
            size: 20,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Text(
          title ?? " ",
          style: const TextStyle(
              color: colorTextSub,
              fontSize: fontSizeSubTitle,
              fontWeight: FontWeight.bold),
        )
      ],
    ),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  );
}
