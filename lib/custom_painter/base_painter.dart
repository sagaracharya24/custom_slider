import 'dart:math';

import 'package:flutter/material.dart';

class BasePainter extends CustomPainter {
  Color baseColor;

  Offset center;
  double radius;

  BasePainter({@required this.baseColor});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
        ..color = baseColor
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = 20.0;

    center = Offset(size.width / 2, size.height / 2);
    radius = min(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}