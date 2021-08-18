import 'dart:math' as math;

import 'package:bus/helpers/Constants.dart';
import 'package:flutter/material.dart';

enum HalfCircleAlignment {
  top,
  right,
  left,
  bottom,
}

class HalfCircle extends StatelessWidget {
  final HalfCircleAlignment circleAlignment;
  final Color color;
  final double opacity;

  const HalfCircle({
    this.color = colorPrimary,
    this.circleAlignment = HalfCircleAlignment.bottom,
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
  final HalfCircleAlignment circleAlignment;
  final Color color;

  const QuarterCirclePainter({this.circleAlignment, this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final radius = math.max(size.height, size.width) / 2;
    final offset = circleAlignment == HalfCircleAlignment.top
        ? Offset(radius, .0)
        : circleAlignment == HalfCircleAlignment.left
            ? Offset(.0, radius)
            : circleAlignment == HalfCircleAlignment.right
                ? Offset(size.width, radius)
                : Offset(radius, size.height);
    canvas.drawCircle(offset, radius, Paint()..color = color);
  }

  @override
  bool shouldRepaint(QuarterCirclePainter oldDelegate) {
    return color == oldDelegate.color &&
        circleAlignment == oldDelegate.circleAlignment;
  }
}
