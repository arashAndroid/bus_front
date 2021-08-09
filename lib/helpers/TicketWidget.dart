import 'package:flutter/material.dart';

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double radius = 40.0;
    double holeRadius = 40.0;

    path.lineTo(0.0, size.height * 3 / 4 - radius - holeRadius);
    path.arcToPoint(
      Offset(0, size.height * 3 / 4 - radius),
      clockwise: true,
      radius: const Radius.circular(1),
    );
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height * 3 / 4 - radius);
    path.arcToPoint(
      Offset(size.width, size.height * 3 / 4 - radius - holeRadius),
      clockwise: true,
      radius: const Radius.circular(1),
    );
    path.lineTo(size.width, 0.0);

    // path.addOval(
    //     Rect.fromCircle(center: Offset(0.0, size.height / 2), radius: 20.0));
    // path.addOval(Rect.fromCircle(
    //     center: Offset(size.width, size.height / 2), radius: 20.0));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
