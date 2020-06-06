import 'dart:math';
import 'dart:ui';

double percentageToRadians(double percentage) => ((pi * percentage) / 100);

double radiansToPercentage(double radians) {
  var normalized = radians < 0 ? -radians : pi - radians;
  var percentage = ((100 * normalized) / (pi));
  // TODO we have an inconsistency of pi/2 in terms of percentage and radians
  return (percentage + 50) % 100;
}

double radianstoPercentageLeft(double radians) {
  var normalized = radians < 0 ? -radians : pi - radians;
  print('************This is left normalized $normalized');
  var percentage = ((100 * normalized) / (pi));
  return (percentage - 50) % 100;
}

double coordinatesToRadians(Offset center, Offset coords) {
  var a = coords.dx - center.dx;
  var b = center.dy - coords.dy;
  return atan2(b, a);
}

Offset radiansToCoordinates(Offset center, double radians, double radius) {
  var dx = center.dx + radius * cos(radians);
  var dy = center.dy + radius * sin(radians);
  return Offset(dx, dy);
}

double valueToPercentage(int time, int intervals) => (time / intervals) * 100;

int percentageToValue(double percentage, int intervals) =>
    ((percentage * intervals) / 100).round();

bool isPointInsideCircle(Offset point, Offset center, double rradius) {
  if (center == Offset(0, 0)) {
    return false;
  }
  var radius = rradius * 1.2;
  return point.dx < (center.dx + radius) &&
      point.dx > (center.dx - radius) &&
      point.dy < (center.dy + radius) &&
      point.dy > (center.dy - radius);
}

bool isPointAlongCircle(Offset point, Offset center, double radius) {
  // distance is root(sqr(x2 - x1) + sqr(y2 - y1))
  // i.e., (7,8) and (3,2) -> 7.21
  var d1 = pow(point.dx - center.dx, 2);
  var d2 = pow(point.dy - center.dy, 2);
  var distance = sqrt(d1 + d2);
  return (distance - radius).abs() < 10;
}

double getSweepAngle(double init, double end) {
  if (end > init) {
    return end - init;
  }
  if (end == init) {
    print('@@@@@@@@@@@@@@@@@@@@@@@@This is the initial or end');
    return 0;
  }
  print('This is the intital :$init');
  print('This is the end : $end');
  return (100 - init + end).abs();
}

List<Offset> getSectionsCoordinatesInCircle(
    Offset center, double radius, int sections) {
  var intervalAngle = (pi * 2) / sections;
  return List<int>.generate(sections, (int index) => index).map((i) {
    var radians = (pi / 2) + (intervalAngle * i);
    return radiansToCoordinates(center, radians, radius);
  }).toList();
}

bool isAngleInsideRadiansSelection(double angle, double start, double sweep) {
  var normalized = angle > pi / 2 ? 5 * pi / 2 - angle : pi / 2 - angle;
  var end = (start + sweep) % (2 * pi);
  return end > start
      ? normalized > start && normalized < end
      : normalized > start || normalized < end;
}

// this is not 100% accurate but it works
// we just want to see if a value changed drastically its value
bool radiansWasModuloed(double current, double previous) {
  return (previous - current).abs() > (3 * pi / 2);
}
