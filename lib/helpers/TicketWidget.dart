import 'package:flutter/material.dart';

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double radius = 40.0;
    double holeRadius = 40.0;
    double cornerCut = 16;
    double ticketCut = 12;
    double curveHeight = 0.65;

    path.moveTo(0.0, cornerCut);
    path.lineTo(0.0, size.height * curveHeight - radius - holeRadius);
    path.arcToPoint(
      Offset(0, size.height * curveHeight - radius),
      clockwise: true,
      radius: const Radius.circular(1),
    );
    path.lineTo(0, size.height);
    // path.lineTo(cornerCut, size.height);

    for (int i = 0; i < (size.width / ticketCut).round(); i++) {
      path.lineTo((i * ticketCut) + (ticketCut / 2), size.height - ticketCut);
      path.lineTo((i * ticketCut) + (ticketCut), size.height);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height - cornerCut);
    path.lineTo(size.width, size.height * curveHeight - radius);
    path.arcToPoint(
      Offset(size.width, size.height * curveHeight - radius - holeRadius),
      clockwise: true,
      radius: const Radius.circular(1),
    );
    path.lineTo(size.width, cornerCut);
    path.lineTo(size.width - cornerCut, 0.0);
    path.lineTo(cornerCut, 0.0);

    // path.addOval(
    //     Rect.fromCircle(center: Offset(0.0, size.height / 2), radius: 20.0));
    // path.addOval(Rect.fromCircle(
    //     center: Offset(size.width, size.height / 2), radius: 20.0));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
