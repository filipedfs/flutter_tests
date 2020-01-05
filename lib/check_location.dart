import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class PointLocation {
  bool _pointOnVertex = true; // Check if the point sits exactly on one of the vertices?

  PointLocation();

  bool pointInPolygon({
    var location,
    List<LatLng> polygon,
    bool pointOnVertex = true,
  }) {
    this._pointOnVertex = pointOnVertex;

    LatLng _location = LatLng(location.latitude, location.longitude);

    // Transform string coordinates into arrays with x and y values
    Map<String, double> point = this._pointStringToCoordinates(_location);

    List<Map<String, double>> vertices = List();

    for (LatLng vertex in polygon) {
      vertices.add(this._pointStringToCoordinates(vertex));
    }

    // Check if the point sits exactly on a vertex
    if (this._pointOnVertex == true && this._checkPointOnVertex(point, vertices) == true) {
      // Point sits exactly on a vertex
      return true;
    }

    // Check if the point is inside the polygon or on the boundary
    int intersections = 0;

    int verticesCount = vertices.length;

    for (int i = 1; i < verticesCount; i++) {
      Map<String, double> vertex1 = vertices[i - 1];

      Map<String, double> vertex2 = vertices[i];

      // Check if point is on an horizontal polygon boundary
      if (vertex1['y'] == vertex2['y'] &&
          vertex1['y'] == point['y'] &&
          point['x'] > min(vertex1['x'], vertex2['x']) &&
          point['x'] < max(vertex1['x'], vertex2['x'])) {
        // Point is on an horizontal polygon boundary
        return true;
      }

      if (point['y'] > min(vertex1['y'], vertex2['y']) &&
          point['y'] <= max(vertex1['y'], vertex2['y']) &&
          point['x'] <= max(vertex1['x'], vertex2['x']) &&
          vertex1['y'] != vertex2['y']) {
        double xinters = (point['y'] - vertex1['y']) * (vertex2['x'] - vertex1['x']) / (vertex2['y'] - vertex1['y']) + vertex1['x'];

        // Check if point is on the polygon boundary (other than horizontal)
        if (xinters == point['x']) {
          // Point is on the polygon boundary (other than horizontal)
          return true;
        }

        if (vertex1['x'] == vertex2['x'] || point['x'] <= xinters) {
          intersections++;
        }
      }
    }
    // If the number of edges we passed through is odd, then it's in the polygon.
    if (intersections % 2 != 0) {
      // Point is inside polygon
      return true;
    } else {
      // Point is outside polygon
      return false;
    }
  }

  _checkPointOnVertex(Map<String, double> point, List<Map<String, double>> vertices) {
    for (Map<String, double> vertex in vertices) {
      if (point['x'] == vertex['x'] && point['y'] == vertex['y']) {
        return true;
      }
    }
  }

  Map<String, double> _pointStringToCoordinates(LatLng coords) {
    return {"x": coords.longitude, "y": coords.latitude};
  }
}
