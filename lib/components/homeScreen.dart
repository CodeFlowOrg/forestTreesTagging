import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forest_tagger/components/generatorPage.dart';
import 'package:forest_tagger/components/scannerPage.dart';

import 'myflatButton.dart';

class HomeScreen extends StatelessWidget {
  String name = "User";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 80,
                  backgroundImage:
                      new AssetImage('assets/images/sample_profile_image.jpg'),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Text(
                      "Welcome,",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "$name",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                MyFlatButton("Scan QR code of a tree", ScannerPage()),
                MyFlatButton("Add a new tree", GeneratorPage())
              ],
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.07,
              right: 20,
              child: ElevatedButton(
                child: Text(
                  "LogOut",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.green, width: 3.0),
                        borderRadius: BorderRadius.circular(5.0))),
                onPressed: () {},
              ))
        ],
      ),
    );
  }
}
