import 'package:flutter/material.dart';
import 'package:flutter_tests/components/drawer.dart';
import 'package:flutter_tests/pages/pdf_generator.dart';

class PDF extends StatelessWidget {

  final PDFHandler teste = PDFHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('PDF'),
        ),
        drawer: MyDrawer(),
        body: Center(
          child: RaisedButton(
            child: Text('Generate PDF'),
            onPressed: (){
              teste.generatePdf();
            },
          ),
        ));
  }
}
