import 'dart:math';

import 'package:custom_slider/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

class CustomLeftRightSlider extends CustomPainter {
  double startLeftAngle;
  double endLeftAngle;
  double leftSweepAngle;
  Color selectionLeftColor;
  double startRightAngle;
  double endRightAngle;
  double rightSweepAngle;
  Color selectionRightColor;
  Offset leftcenter;
  Offset rightcenter;
  double leftradius;
  double rightradius;
  Offset leftInitHandler;
  Offset rightInitHandler;

  /// add list of paths
  List<String> paths = <String>[
    "M16.3 11.3L14.6 10.3 16.1 9.5C16.3 9.3 16.4 9 16.3 8.7 16.1 8.5 15.7 8.4 15.5 8.5L13.5 9.7 10.4 8 13.5 6.3 15.5 7.5C15.6 7.5 15.7 7.5 15.8 7.5 16 7.5 16.1 7.4 16.3 7.3 16.4 7 16.3 6.7 16.1 6.5L14.6 5.7 16.3 4.7C16.6 4.6 16.6 4.3 16.5 4 16.3 3.7 16 3.6 15.7 3.8L14 4.7 14 3.1C14 2.8 13.7 2.6 13.4 2.6 13.1 2.6 12.9 2.8 12.9 3.1L12.9 5.4 9.9 7.1V3.7L11.9 2.6C12.2 2.4 12.3 2.1 12.1 1.8 12 1.6 11.6 1.5 11.3 1.6L9.9 2.4V0.5C9.9 0.2 9.6 0 9.3 0 9 0 8.7 0.2 8.7 0.5V2.4L7.2 1.6C7 1.5 6.6 1.6 6.5 1.8 6.3 2.1 6.4 2.4 6.7 2.6L8.7 3.7V7.1L5.7 5.4 5.7 3.1C5.7 2.8 5.4 2.6 5.1 2.6 5.1 2.6 5.1 2.6 5.1 2.6 4.8 2.6 4.6 2.8 4.6 3.1L4.5 4.7 2.9 3.8C2.6 3.6 2.2 3.7 2.1 4 1.9 4.3 2 4.6 2.3 4.7L4 5.7 2.5 6.5C2.2 6.7 2.1 7 2.3 7.3 2.4 7.4 2.6 7.5 2.8 7.5 2.9 7.5 3 7.5 3.1 7.5L5.1 6.3 8.1 8 5.1 9.7 3.1 8.5C2.8 8.4 2.5 8.5 2.3 8.7 2.1 9 2.2 9.3 2.5 9.5L4 10.3 2.3 11.3C2 11.4 1.9 11.7 2.1 12 2.2 12.2 2.4 12.3 2.6 12.3 2.7 12.3 2.8 12.2 2.9 12.2L4.5 11.3 4.6 12.9C4.6 13.2 4.8 13.4 5.1 13.4 5.1 13.4 5.1 13.4 5.1 13.4 5.4 13.4 5.7 13.2 5.7 12.9L5.7 10.6 8.7 8.9V12.3L6.7 13.4C6.4 13.6 6.3 13.9 6.5 14.2 6.6 14.4 6.8 14.5 7 14.5 7 14.5 7.1 14.4 7.2 14.4L8.7 13.6V15.5C8.7 15.8 9 16 9.3 16 9.6 16 9.9 15.8 9.9 15.5V13.6L11.3 14.4C11.4 14.4 11.5 14.5 11.6 14.5 11.8 14.5 12 14.4 12.1 14.2 12.3 13.9 12.2 13.6 11.9 13.4L9.9 12.3V8.9L12.9 10.6 12.9 12.9C12.9 13.2 13.1 13.4 13.4 13.4 13.4 13.4 13.4 13.4 13.4 13.4 13.7 13.4 14 13.2 14 12.9L14 11.3 15.7 12.2C15.8 12.2 15.9 12.3 16 12.3 16.2 12.3 16.4 12.2 16.5 12 16.6 11.7 16.6 11.4 16.3 11.3Z"
  ];
  List<String> rightPath = <String>[
    "M10.2 20 7.1 16.9H2.3V12.1L0 9.8l2.3-2.3V3.1H6.7L9.8 0l3.1 3.1h4.1V7.1L20 10.2 16.9 13.3v3.6H13.3L10.2 20h0ZM4.9 9.9a5 5 0 1 0 5-5A5 5 0 0 0 4.9 9.9Zm2 0a3 3 0 1 1 3 3A3 3 0 0 1 6.9 9.9Z"
  ];

  CustomLeftRightSlider({
    @required this.startLeftAngle,
    @required this.endLeftAngle,
    @required this.leftSweepAngle,
    @required this.selectionLeftColor,
    @required this.startRightAngle,
    @required this.endRightAngle,
    @required this.rightSweepAngle,
    @required this.selectionRightColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    //This was the problem when all the both left and right angles are 0 then it will return with no points
    /* if (startLeftAngle == 0.0 &&
        endLeftAngle == 0.0 &&
        startRightAngle == 0.0 &&
        endRightAngle == 0.0) return;


 */

    //canvas.drawColor(Colors.grey[800], BlendMode.color);

    Paint leftprogress = _getPaint(color: selectionLeftColor, width: 20);
    Paint rightprogress = _getPaint(color: selectionRightColor, width: 20);

    leftcenter = Offset(size.width / 2, size.height / 2);
    rightcenter = Offset(size.width / 2, size.height / 2);

    leftradius = min(size.width / 2, size.height / 2);
    rightradius = min(size.width / 2, size.height / 2);

    canvas.drawArc(Rect.fromCircle(center: leftcenter, radius: leftradius),
        pi / 2 + startLeftAngle + 0.07, leftSweepAngle, false, leftprogress);
    canvas.drawArc(
        Rect.fromCircle(center: rightcenter, radius: rightradius),
        -pi / 2 + startRightAngle + 0.07,
        rightSweepAngle,
        false,
        rightprogress);

    Paint lefthandler =
        _getPaint(color: Colors.white, style: PaintingStyle.fill);
    Paint lefthandlerOutter = _getPaint(color: Colors.white);

    Paint righthandler =
        _getPaint(color: Colors.white, style: PaintingStyle.fill);
    Paint righthandlerOutter = _getPaint(color: Colors.white);

    rightInitHandler = radiansToCoordinates(
        rightcenter, -pi / 2 + endRightAngle + 0.07, rightradius);
    canvas.drawCircle(rightInitHandler, 8.0, righthandler);
    canvas.drawCircle(rightInitHandler, 10.0, righthandlerOutter);

    leftInitHandler = radiansToCoordinates(
        leftcenter, pi / 2 + endLeftAngle + 0.07, leftradius);
    canvas.drawCircle(leftInitHandler, 8.0, lefthandler);
    canvas.drawCircle(leftInitHandler, 10.0, lefthandlerOutter);
    Paint iconleftPaint = _getPaint(
        color: Colors.blueAccent, width: 20, style: PaintingStyle.fill);
    Paint iconrightPaint = _getPaint(
        color: Colors.redAccent, width: 20, style: PaintingStyle.fill);
    var iconSvg = Path()
      ..addPath(parseSvgPathData(paths[0]),
          Offset(leftInitHandler.dx - 9, leftInitHandler.dy - 8));
    var iconRightSvg = Path()
      ..addPath(parseSvgPathData(rightPath[0]),
          Offset(rightInitHandler.dx - 10, rightInitHandler.dy - 10));
    canvas.drawPath(iconRightSvg, iconrightPaint);
    canvas.drawPath(iconSvg, iconleftPaint);
    /* Paint allpaint =
        _getPaint(color: Colors.grey[800], style: PaintingStyle.fill);
    canvas.drawCircle(Offset(size.width / 2, size.height / 2),
        min(size.width / 2 - 10, size.height / 2 - 10), allpaint); */
  }

  Paint _getPaint({@required Color color, double width, PaintingStyle style}) =>
      Paint()
        ..color = color
        ..strokeCap = StrokeCap.square
        ..style = style ?? PaintingStyle.stroke
        ..strokeWidth = width ?? 8.0;

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
