import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tests/components/drawer.dart';
import 'package:flutter_tests/components/rodizio_polygon.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  @override
  State<MapsPage> createState() => MapsPageState();
}

class MapsPageState extends State<MapsPage> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-23.568949674056366, -46.660604999999975),
    zoom: 11,
  );

  static final CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(-23.582029, -46.766846),
    tilt: 10,
    zoom: 20,
  );

  // Polygons

  Set<Polygon> polygons = Set.from([
    Polygon(
      polygonId: PolygonId('Rodízio'),
      fillColor: Color.fromRGBO(255, 255, 0, .3),
      strokeColor: Color.fromRGBO(255, 0, 0, 0.3),
      strokeWidth: 5,
      points: [
        LatLng(-23.575318, -46.696309),
        LatLng(-23.587431, -46.690551),
        LatLng(-23.585892, -46.667472),
        LatLng(-23.590836, -46.675502),
//        LatLng(-23.570836, -46.675502),
      ],
    ),
  ]);

  Set<Polygon> myPolygon() {
//    List<LatLng> polygonCoords = List();
//    polygonCoords.add(LatLng(-23.575318, -46.696309));
//    polygonCoords.add(LatLng(-23.587431, -46.690551));
//    polygonCoords.add(LatLng(-23.585892, -46.667472));
//    polygonCoords.add(LatLng(-23.570836, -46.675502));

    RodizioPolygon rodizioPolygonCoords = RodizioPolygon();


    Set<Polygon> polygonSet = Set();
    polygonSet.add(
      Polygon(
        polygonId: PolygonId('Rodízio'),
        fillColor: Color.fromRGBO(255, 255, 0, .3),
        strokeColor: Color.fromRGBO(255, 0, 0, 0.3),
        strokeWidth: 5,
        points: rodizioPolygonCoords.polygon,
      ),
    );

    return polygonSet;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(title: Text('Maps')),
      body: GoogleMap(

        polygons: myPolygon() ,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To my home!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
