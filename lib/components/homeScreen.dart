import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forest_tagger/components/generatorPage.dart';
import 'package:forest_tagger/components/scannerPage.dart';

import 'myflatButton.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyFlatButton("Scan QR code of a tree", ScannerPage()),
            MyFlatButton("Add a new tree", GeneratorPage())
          ]
        ),
    );

  }

}