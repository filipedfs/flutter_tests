import 'package:flutter/material.dart';
import 'package:flutter_tests/main.dart';
import 'package:flutter_tests/pages/flutter_pdfview.dart';

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
          ),ListTile(
            title: Text('PDF: flutter_pdfview'),
            leading: Icon(Icons.book),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => FlutterPDFView()));
            },
          ),
        ],
      ),
    );
  }
}
