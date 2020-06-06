import 'dart:math';

import 'package:custom_slider/utils/utils.dart';
import 'package:flutter/material.dart';


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

    Paint leftprogress = _getPaint(color: selectionLeftColor, width: 20);
    Paint rightprogress = _getPaint(color: selectionRightColor, width: 20);

    leftcenter = Offset(size.width / 2, size.height / 2);
    rightcenter = Offset(size.width / 2, size.height / 2);

    leftradius = min(size.width / 2, size.height / 2);
    rightradius = min(size.width / 2, size.height / 2);

    canvas.drawArc(Rect.fromCircle(center: leftcenter, radius: leftradius),
        pi / 2 + startLeftAngle, leftSweepAngle, false, leftprogress);
    canvas.drawArc(Rect.fromCircle(center: rightcenter, radius: rightradius),
        -pi / 2 + startRightAngle, rightSweepAngle, false, rightprogress);

    Paint lefthandler =
        _getPaint(color: Colors.white, style: PaintingStyle.fill);
    Paint lefthandlerOutter = _getPaint(color: selectionLeftColor);

    Paint righthandler =
        _getPaint(color: Colors.white, style: PaintingStyle.fill);
    Paint righthandlerOutter = _getPaint(color: selectionRightColor);

    rightInitHandler =
        radiansToCoordinates(rightcenter, -pi / 2 + endRightAngle, rightradius);
    canvas.drawCircle(rightInitHandler, 8.0, righthandler);
    canvas.drawCircle(rightInitHandler, 10.0, righthandlerOutter);

    leftInitHandler =
        radiansToCoordinates(leftcenter, pi / 2 + endLeftAngle, leftradius);
    canvas.drawCircle(leftInitHandler, 8.0, lefthandler);
    canvas.drawCircle(leftInitHandler, 10.0, lefthandlerOutter);



    /* This is the what the working code
    
     // To draw image but problem is it has scalling problem

    /* canvas.drawImage(
        leftSvgIcon,
        Offset(leftInitHandler.dx - 12, leftInitHandler.dy - 12),
        lefthandlerOutter); */
    //


    leftdrawablesvgIcon.scaleCanvasToViewBox(canvas, size);

    leftdrawablesvgIcon.clipCanvasToViewBox(canvas);

       //This is the add part for the edit
    Rect myRect = Offset(leftInitHandler.dx,leftInitHandler.dy) & const Size(50.0, 50.0);

    leftdrawablesvgIcon.draw(
        canvas,myRect); */
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
