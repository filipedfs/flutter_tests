import 'package:flutter/material.dart';
import 'package:flutter_tests/check_location.dart';
import 'package:flutter_tests/components/drawer.dart';
import 'package:flutter_tests/components/rodizio_polygon.dart';
import 'package:flutter_tests/position_calculator.dart';
import 'package:latlong/latlong.dart';

void main() {

//  final Distance distance = Distance();
//  final LatLng p1 = LatLng(0.0,0.0);
//  print(distance.offset(p1, 1000, 0));

  // Point Location
//  PointLocation pointLocation = PointLocation();
//  List<String> points = [
//    "-23.581942 -46.767193", // Dentro
//    "-23.580939 -46.766447", // Fora
//    "-23.582837 -46.765412", // Fora
//  ];
//  List<String> polygon = [
//    "-23.582392 -46.767015",
//    "-23.581674 -46.767932",
//    "-23.581342 -46.766814",
//    "-23.582055 -46.765881",
//  ];

  // The last point's coordinates must be the same as the first one's, to "close the loop"

//  points.asMap().forEach((key, point) {
//    print("point ${key + 1} .  $point: ${pointLocation.pointInPolygon(
//      location: point,
//
//      polygon: polygon,
//    )}\n");
//  });

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tests',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Aplicativo onde eu testo os packages do Flutter e outras funcionalidades',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24.0, height: 1.5),
          ),
          SizedBox(height: 200.0),
        ],
      ),
    );
  }
}
