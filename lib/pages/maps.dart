import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tests/check_location.dart';
import 'package:flutter_tests/components/drawer.dart';
import 'package:flutter_tests/components/rodizio_polygon.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong/latlong.dart' as LatLong;
import 'package:location/location.dart';

class MapsPage extends StatefulWidget {
  @override
  State<MapsPage> createState() => MapsPageState();
}

class MapsPageState extends State<MapsPage> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    print('INIT');
    getLocation();
  }

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

    // Second polygon
    List<LatLng> polygonCoords = List();
    polygonCoords.add(LatLng(-23.582415, -46.767001));
    polygonCoords.add(LatLng(-23.581424, -46.767144));
    polygonCoords.add(LatLng(-23.581925, -46.765492));


    LatLong.Distance distance = LatLong.Distance();
    // 1 km north first position
    LatLong.LatLng oneKMAbove = distance.offset(
      currentLocation != null ?
      LatLong.LatLng(currentLocation.latitude, currentLocation.longitude) : LatLong.LatLng(0,0),
      1000,
      90,
    );

    // Second position
    LatLng secondPosition = LatLng(oneKMAbove.latitude, oneKMAbove.longitude);

    print(PointLocation().pointInPolygon(polygon: polygonCoords, location: secondPosition));

    polygonSet.add(
      Polygon(
        polygonId: PolygonId('Rodízio'),
        fillColor: Color.fromRGBO(255, 255, 0, .3),
        strokeColor: Color.fromRGBO(255, 0, 0, 0.3),
        strokeWidth: 5,
        points: polygonCoords,
      ),
    );

    return polygonSet;
  }

  LocationData currentLocation;
  var location = Location();

  getLocation() async {
    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        var error = 'Permission denied';
      }
      currentLocation = null;
    }
  }

  Set<Marker> myMarkers() {
    LatLong.Distance distance = LatLong.Distance();

    // First position
    LatLng firstPosition = currentLocation != null ? LatLng(currentLocation.latitude, currentLocation.longitude) : LatLng(0,0);

    // 1 km east first position
    LatLong.LatLng oneKMAbove = distance.offset(
      LatLong.LatLng(firstPosition.latitude, firstPosition.longitude),
      1000,
      0,
    );

// 1 km north first position
    LatLong.LatLng oneKMNorth = distance.offset(
      LatLong.LatLng(firstPosition.latitude, firstPosition.longitude),
      1000,
      90,
    );

    // Second position
    LatLng secondPosition = LatLng(oneKMAbove.latitude, oneKMAbove.longitude);

    LatLng thirdPosition = LatLng(oneKMNorth.latitude, oneKMNorth.longitude);

    Set<Marker> markers = Set();
    markers.add(
      Marker(
        position: firstPosition,
        markerId: MarkerId('Meu local'),
      ),
    );
    markers.add(
      Marker(
        markerId: MarkerId('1km acima'),
        position: secondPosition,
      ),
    );
    markers.add(
      Marker(
        markerId: MarkerId('1km acima'),
        position: thirdPosition,
      ),
    );
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(title: Text('Maps')),
      body: GoogleMap(
        markers: myMarkers(),
        polygons: myPolygon(),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        mapType: MapType.normal,
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
