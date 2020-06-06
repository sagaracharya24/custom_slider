import 'package:custom_slider/custom_painter/base_painter.dart';
import 'package:custom_slider/custom_painter/custom_painter.dart';
import 'package:custom_slider/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSlider extends StatefulWidget {
  CustomSlider({key}) : super(key: key);

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  //intial Values coming

  int leftEnd = 18;
  int rightEnd = 19;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SliderPaintt(
        leftInitial: 0,
        leftEnd: leftEnd,
        rightInitial: 0,
        rightEnd: rightEnd,
        onSelectionChange: (int left, int right) {
          setState(() {
            leftEnd = left;
            rightEnd = right;
          });
        },
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                '$leftEnd\u00B0',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  color: Colors.blueAccent,
                  textStyle: TextStyle(letterSpacing: .5, fontSize: 25),
                ),
              ),
            ),
            Container(
              width: 1,
              height: 30,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                '$rightEnd\u00B0',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  color: Colors.pinkAccent,
                  textStyle: TextStyle(letterSpacing: .5, fontSize: 25),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}

class SliderPaintt extends StatefulWidget {
  final int leftInitial;
  final int leftEnd;
  final int rightInitial;
  final int rightEnd;
  final Function onSelectionChange;
  final Widget child;

  const SliderPaintt(
      {Key key,
      @required this.leftInitial,
      @required this.leftEnd,
      @required this.rightInitial,
      @required this.rightEnd,
      @required this.onSelectionChange,
      this.child})
      : super(key: key);

  @override
  _SliderPainttState createState() => _SliderPainttState();
}

class _SliderPainttState extends State<SliderPaintt> {
  bool _isInitLeftHandlerSelected = false;
  bool _isInitialRightHandlerSelected = false;

  CustomLeftRightSlider customLeftRightSlider;

  /// start angle in radians where we need to locate the initial left handler
  double _leftStartAngle;

  /// end angle in radians where we need to locate the end left  handler
  double _leftEndAngle;

  /// the absolute angle in radians representing the selection
  double _leftSweepAngle;

  double _rightStartAngle;
  double _rightEndAngle;
  double _rightSweepAngle;

// we need to update this widget both with gesture detector but
  // also when the parent widget rebuilds itself
  @override
  void didUpdateWidget(SliderPaintt oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.leftInitial != widget.leftInitial ||
        oldWidget.leftEnd != widget.leftEnd ||
        oldWidget.rightInitial != widget.rightInitial ||
        oldWidget.rightEnd != widget.rightEnd) {
      _calculatePercentage();
    }
  }

  void _calculatePercentage() {
    if (_isInitialRightHandlerSelected) {
      double initRightPercentage = valueToPercentage(widget.rightInitial, 100);
      print('This is initial Right Percentage $initRightPercentage');
      double endRightPercentage = valueToPercentage(widget.rightEnd, 100);
      print('This is the initial right end percentage $endRightPercentage');
      double sweepRightAngle =
          getSweepAngle(initRightPercentage, endRightPercentage);
      print(
          'This is the sweep andgle for the right hand side $sweepRightAngle');
      _rightStartAngle = percentageToRadians(initRightPercentage);
      print('This is the right Start Angle $_rightStartAngle');

      _rightEndAngle = percentageToRadians(endRightPercentage);
      print('This is the right End Angle $_rightEndAngle');
      _rightSweepAngle = percentageToRadians(sweepRightAngle.abs());
      print('This is the right Sweep Angle $_rightSweepAngle');
    }

    if (_isInitLeftHandlerSelected) {
      // This is for left inti and end percentage and the sweep Angle
      // TODO That it should be in a limit of half circle

      double initLeftPercentage = valueToPercentage(widget.leftInitial, 100);
      print('This is initial Left Percentge $initLeftPercentage');
      double endLeftPercentage = valueToPercentage(widget.leftEnd, 100);
      print('This is  End  Left Percentage $endLeftPercentage');

      double sweepLeftAngle =
          getSweepAngle(initLeftPercentage, endLeftPercentage);
      print('This is the sweep angle for the left hand side $sweepLeftAngle');
      _leftStartAngle = percentageToRadians(initLeftPercentage);
      print('This is the Left Start Angle $_leftStartAngle');
      _leftEndAngle = percentageToRadians(endLeftPercentage);
      print('This is the Left End Angle $_leftEndAngle');

      _leftSweepAngle = percentageToRadians(sweepLeftAngle.abs());
      print('This is the Left Sweep Angle $_leftSweepAngle');
    }

    customLeftRightSlider = CustomLeftRightSlider(
      startLeftAngle: _leftStartAngle,
      endLeftAngle: _leftEndAngle,
      leftSweepAngle: _leftSweepAngle,
      selectionLeftColor: Colors.blueAccent,
      startRightAngle: _rightStartAngle,
      endRightAngle: _rightEndAngle,
      rightSweepAngle: _rightSweepAngle,
      selectionRightColor: Colors.pink,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _calculatePaintData();
  }

  void _calculatePaintData() {
    // This is for the right init and end percentage and the sweepangle

    // This is for left inti and end percentage and the sweep Angle
    double initLeftPercentage = valueToPercentage(widget.leftInitial, 100);
    print('This is initial Left Percentge $initLeftPercentage');
    double endLeftPercentage = valueToPercentage(widget.leftEnd, 100);
    print('This is  End  Left Percentage $endLeftPercentage');

    double sweepLeftAngle =
        getSweepAngle(initLeftPercentage, endLeftPercentage);
    print('This is the sweep angle for the left hand side $sweepLeftAngle');
    _leftStartAngle = percentageToRadians(initLeftPercentage);
    print('This is the Left Start Angle $_leftStartAngle');
    _leftEndAngle = percentageToRadians(endLeftPercentage);
    print('This is the Left End Angle $_leftEndAngle');

    _leftSweepAngle = percentageToRadians(sweepLeftAngle.abs());
    print('This is the Left Sweep Angle $_leftSweepAngle');

    double initRightPercentage = valueToPercentage(widget.rightInitial, 100);
    print('This is initial Right Percentage $initRightPercentage');
    double endRightPercentage = valueToPercentage(widget.rightEnd, 100);
    print('This is the initial right end percentage $endRightPercentage');
    double sweepRightAngle =
        getSweepAngle(initRightPercentage, endRightPercentage);
    print('This is the sweep andgle for the right hand side $sweepRightAngle');
    _rightStartAngle = percentageToRadians(initRightPercentage);
    print('This is the right Start Angle $_rightStartAngle');

    _rightEndAngle = percentageToRadians(endRightPercentage);
    print('This is the right End Angle $_rightEndAngle');
    _rightSweepAngle = percentageToRadians(sweepRightAngle.abs());
    print('This is the right Sweep Angle $_rightSweepAngle');

    customLeftRightSlider = CustomLeftRightSlider(
      startLeftAngle: _leftStartAngle,
      endLeftAngle: _leftEndAngle,
      leftSweepAngle: _leftSweepAngle,
      selectionLeftColor: Colors.blue,
      startRightAngle: _rightStartAngle,
      endRightAngle: _rightEndAngle,
      rightSweepAngle: _rightSweepAngle,
      selectionRightColor: Colors.pink,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      onPanDown: _onPanDown,
      child: CustomPaint(
        painter: BasePainter(
          baseColor: Color(0XFF5E5C5D),
        ),
        foregroundPainter: customLeftRightSlider,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: widget.child,
        ),
      ),
    );
  }

  _onPanUpdate(DragUpdateDetails details) {
    if (!_isInitLeftHandlerSelected && !_isInitialRightHandlerSelected) {
      return;
    }
    if (customLeftRightSlider.leftcenter == null &&
        customLeftRightSlider.rightcenter == null) {
      return;
    }

    RenderBox renderBox = context.findRenderObject();
    var position = renderBox.globalToLocal(details.globalPosition);
    var leftAngle;
    var rightAngle;
    var leftPercent;
    var rightPercent;
    var newLeftValue;
    var newRightValue;
    if (_leftSweepAngle >= 0) {
      leftAngle =
          coordinatesToRadians(customLeftRightSlider.leftcenter, position);
      leftPercent = radianstoPercentageLeft(leftAngle);
      newLeftValue = percentageToValue(leftPercent, 100);
      if (_isInitLeftHandlerSelected) {
        widget.onSelectionChange(newLeftValue, widget.rightEnd);
      }
    }
    if (_rightSweepAngle >= 0) {
      rightAngle =
          coordinatesToRadians(customLeftRightSlider.rightcenter, position);
      rightPercent = radiansToPercentage(rightAngle);
      newRightValue = percentageToValue(rightPercent, 100);
      if (_isInitialRightHandlerSelected) {
        widget.onSelectionChange(widget.leftEnd, newRightValue);
      }
    }
  }

  _onPanDown(DragDownDetails details) {
    if (customLeftRightSlider == null) {
      return;
    }
    RenderBox renderBox = context.findRenderObject();
    var position = renderBox.globalToLocal(details.globalPosition);
    if (position != null) {
      _isInitLeftHandlerSelected = isPointInsideCircle(
          position, customLeftRightSlider.leftInitHandler, 12.0);

      _isInitialRightHandlerSelected = isPointInsideCircle(
          position, customLeftRightSlider.rightInitHandler, 12.0);
    }
  }

  _onPanEnd(_) {
    _isInitLeftHandlerSelected = false;
    _isInitialRightHandlerSelected = false;
  }
}
