import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tests/components/drawer.dart';

void main() => runApp(MyApp());

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
