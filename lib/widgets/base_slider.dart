import 'package:custom_slider/custom_painter/base_painter.dart';
import 'package:flutter/material.dart';


class BaseSlider extends StatelessWidget {
  const BaseSlider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: BasePainter(
          baseColor: Color(0XFF5E5C5D),
        ),
      ),
    );
  }
}
