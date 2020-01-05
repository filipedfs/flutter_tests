import 'dart:math';

class PositionCalculator {
  Map<String, double> _changeCoordinate(
    // Distance to add. It always will be converted to positive.
    double distance,

    // Map with coordinates. Must have string keys x and y.
    Map<String, double> coord,

    // Angle where to change the position
    double angleDegree,
  ) {
    // Infos to remember:
    // Sine:    sin(θ) = Opposite / Hypotenuse
    // Cosine:  cos(θ) = Adjacent / Hypotenuse
    // Tangent: tan(θ) = Opposite / Adjacent

    // Radian to Degree
    // angle in degrees = angle in radians * (180° / pi)
    // double degree = (pi / 4) * 180 / pi;

    // Degree to Radian
    // angle in radians = angle in degrees / (180° * pi)
    // double radian = 45 * pi / 180;

    Map<String, double> value = Map.from(coord);

    // 1. Convert degree to radian
    double angleRadian = angleDegree * pi / 180;

    // 2. Calculate the adjacent of the triangle
    double adjacent = distance * cos(angleRadian);

    // 3. Calculate the opposite of the triangle
    double opposite = distance * sin(angleRadian);

    // 4. Calculate the hypotenuse
    // double hypotenuse = sqrt(pow(adjacent, 2) + pow(adjacent, 2));

    // Rounds 15 decimals
    adjacent = ((adjacent * 100000000000000000).roundToDouble()) / 100000000000000000;
    opposite = ((opposite * 100000000000000000).roundToDouble()) / 100000000000000000;

    // Update values
    value['x'] = value['x'] + adjacent;
    value['y'] = value['y'] + opposite;

    // Return the updated coordinate
    return value;
  }

  /// Change coordinate by `valueToAdd` to the east.
  Map<String, double> addEastValue(double valueToAdd, Map<String, double> coord) {
    return this._changeCoordinate(valueToAdd, coord, 0);
  }

  /// Change coordinate by `valueToAdd` to the north.
  Map<String, double> addNorthValue(double valueToAdd, Map<String, double> coord) {
    return this._changeCoordinate(valueToAdd, coord, 90);
  }

  /// Change coordinate by `valueToAdd` to the west.
  Map<String, double> addWestValue(double valueToAdd, Map<String, double> coord) {
    return this._changeCoordinate(valueToAdd, coord, 180);
  }

  /// Change coordinate by `valueToAdd` to the south.
  Map<String, double> addSouthValue(double valueToAdd, Map<String, double> coord) {
    return this._changeCoordinate(valueToAdd, coord, 270);
  }

  Map<String, double> addNorthEastValue(
    /// Distance to add. It always will be converted to positive.
    double valueToAdd,

    /// Map with coordinates. Must have string keys x and y.
    Map<String, double> coord, {

    /// The angle must be between 0 and 90
    double angleDegree = 45,
  }) {
    return this._changeCoordinate(valueToAdd, coord, angleDegree);
  }

  Map<String, double> addSouthWestValue(
    double valueToAdd,
    Map<String, double> coord, {
    double angleDegree = 225,
  }) {
    return this._changeCoordinate(valueToAdd, coord, angleDegree);
  }

  Map<String, double> addNorthWestValue(
    double valueToAdd,
    Map<String, double> coord, {
    double angleDegree = 135,
  }) {
    return this._changeCoordinate(valueToAdd, coord, angleDegree);
  }

  Map<String, double> addSouthEastValue(
    double valueToAdd,
    Map<String, double> coord, {
    double angleDegree = 315,
  }) {
    return this._changeCoordinate(valueToAdd, coord, angleDegree);
  }

  Map<String, double> addAngledValue(
    double valueToAdd,
    Map<String, double> coord,
    double angleDegree,
  ) {
    return this._changeCoordinate(valueToAdd, coord, angleDegree);
  }
}
