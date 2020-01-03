import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tests/components/drawer.dart';

class FingerPressurePage extends StatefulWidget {
  @override
  _FingerPressurePageState createState() => _FingerPressurePageState();
}

class _FingerPressurePageState extends State<FingerPressurePage> {
  double fingerPressure = ForcePressGestureRecognizer().startPressure;



  @override
  Widget build(BuildContext context) {
    print(fingerPressure);
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Finger Pressure'),
      ),
      body: GestureDetector(
        onDoubleTap: (){
          print('Double Tap');
        },
        onTapDown: (tapDetails) {
          print('Tapped');
        },
        onScaleUpdate: (scaleDetails){
          print('Scale');
        },
        onLongPressMoveUpdate: (moveUpdate){
          print('long press move');
        },
        onPanDown: (dragDownDetails){
          print('Pan Down');
        },

        onForcePressStart: (force) {
          print('Pressed');
          print(force);
        },
        onForcePressUpdate: (force) {
          setState(() {
//            print('Pressed');
            fingerPressure = force.pressure;
          });
        },
        child: Center(
          child: Container(
            color: Colors.teal,
            child: Center(
              child: Container(
                child: Text(
                  'Pressure: $fingerPressure',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
