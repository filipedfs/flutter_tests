import 'dart:math';

class PointLocation {
  bool pointOnVertex = true; // Check if the point sits exactly on one of the vertices?

  PointLocation();

  pointInPolygon({
    String originalPoint,
    List<String> polygon,
    bool pointOnVertex = true,
  }) {
    this.pointOnVertex = pointOnVertex;

    // Transform string coordinates into arrays with x and y values
    Map<String, double> point = this.pointStringToCoordinates(originalPoint);

    List<Map<String, double>> vertices = List();

    for (String vertex in polygon) {
      vertices.add(this.pointStringToCoordinates(vertex));
    }

    // Check if the point sits exactly on a vertex
    if (this.pointOnVertex == true && this._checkPointOnVertex(point, vertices) == true) {
      return "vertex";
    }

    // Check if the point is inside the polygon or on the boundary
    int intersections = 0;

    int verticesCount = vertices.length;

    for (int i = 1; i < verticesCount; i++) {
      Map<String, double> vertex1 = vertices[i - 1];

      Map<String, double> vertex2 = vertices[i];

      if (vertex1['y'] == vertex2['y'] &&
          vertex1['y'] == point['y'] &&
          point['x'] > min(vertex1['x'], vertex2['x']) &&
          point['x'] < max(vertex1['x'], vertex2['x'])) {
        // Check if point is on an horizontal polygon boundary
        return "boundary";
      }

      if (point['y'] > min(vertex1['y'], vertex2['y']) &&
          point['y'] <= max(vertex1['y'], vertex2['y']) &&
          point['x'] <= max(vertex1['x'], vertex2['x']) &&
          vertex1['y'] != vertex2['y']) {
        double xinters = (point['y'] - vertex1['y']) * (vertex2['x'] - vertex1['x']) / (vertex2['y'] - vertex1['y']) + vertex1['x'];

        if (xinters == point['x']) {
          // Check if point is on the polygon boundary (other than horizontal)
          return "boundary";
        }

        if (vertex1['x'] == vertex2['x'] || point['x'] <= xinters) {
          intersections++;
        }
      }
    }
    // If the number of edges we passed through is odd, then it's in the polygon.
    if (intersections % 2 != 0) {
      return "inside";
    } else {
      return "outside";
    }
  }

  _checkPointOnVertex(Map<String, double> point, List<Map<String, double>> vertices) {
    for (Map<String, double> vertex in vertices) {
      if (point['x'] == vertex['x'] && point['y'] == vertex['y']) {
        return true;
      }
    }
  }

  Map<String, double> pointStringToCoordinates(String pointString) {
    List<String> coordinates = pointString.split(' ');
    return {"x": double.parse(coordinates[0]), "y": double.parse(coordinates[1])};
  }
}
