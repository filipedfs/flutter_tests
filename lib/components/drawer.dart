import 'package:flutter/material.dart';
import 'package:flutter_tests/main.dart';
import 'package:flutter_tests/pages/file_picker.dart';
import 'package:flutter_tests/pages/finger_pressure.dart';
import 'package:flutter_tests/pages/flutter_pdfview.dart';
import 'package:flutter_tests/pages/folder_picker.dart';
import 'package:flutter_tests/pages/location.dart';
import 'package:flutter_tests/pages/maps.dart';
import 'package:flutter_tests/pages/pdf.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Flutter Tests',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                  "https://htmlcolorcodes.com/assets/images/html-color-codes-color-tutorials-hero-00e10b1f.jpg",
                ),
              ),
              color: Colors.teal,
            ),
          ),
          ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
            },
          ),
          ListTile(
            title: Text('PDF: flutter_pdfview'),
            leading: Icon(Icons.book),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => FlutterPDFView()));
            },
          ),
          ListTile(
            title: Text('PDF: pdf'),
            leading: Icon(Icons.book),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => PDF()));
            },
          ),
          ListTile(
            title: Text('FILE: file_picker'),
            leading: Icon(Icons.insert_drive_file),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => FilePickerPage()));
            },
          ),
          ListTile(
            title: Text('FILE: folder_picker'),
            leading: Icon(Icons.insert_drive_file),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => FolderPickerDemo()));
            },
          ),
          ListTile(
            title: Text('Flutter: GestureDetector'),
            leading: Icon(Icons.fingerprint),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => FingerPressurePage()));
            },
          ),
          ListTile(
            title: Text('Map: google_maps_flutter'),
            leading: Icon(Icons.map),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => MapsPage()));
            },
          ),
          ListTile(
            title: Text('Map: location'),
            leading: Icon(Icons.map),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => LocationPage()));
            },
          ),
        ],
      ),
    );
  }
}
