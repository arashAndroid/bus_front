import 'dart:math' as math;

import 'package:bus/helpers/Constants.dart';
import 'package:flutter/material.dart';

enum QuarterCircleAlignment {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

class QuarterCircle extends StatelessWidget {
  final QuarterCircleAlignment circleAlignment;
  final Color color;
  final double opacity;

  const QuarterCircle({
    this.color = colorPrimary,
    this.circleAlignment = QuarterCircleAlignment.topLeft,
    this.opacity = 0.05,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: ClipRect(
        child: CustomPaint(
          painter: QuarterCirclePainter(
            circleAlignment: circleAlignment,
            color: color.withOpacity(opacity),
          ),
        ),
      ),
    );
  }
}

class QuarterCirclePainter extends CustomPainter {
  final QuarterCircleAlignment circleAlignment;
  final Color color;

  const QuarterCirclePainter({this.circleAlignment, this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final radius = math.min(size.height, size.width);
    final offset = circleAlignment == QuarterCircleAlignment.topLeft
        ? const Offset(.0, .0)
        : circleAlignment == QuarterCircleAlignment.topRight
            ? Offset(size.width, .0)
            : circleAlignment == QuarterCircleAlignment.bottomLeft
                ? Offset(.0, size.height)
                : Offset(size.width, size.height);
    canvas.drawCircle(offset, radius, Paint()..color = color);
  }

  @override
  bool shouldRepaint(QuarterCirclePainter oldDelegate) {
    return color == oldDelegate.color &&
        circleAlignment == oldDelegate.circleAlignment;
  }
}
