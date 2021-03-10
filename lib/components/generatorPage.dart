import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forest_tagger/components/backButton.dart';
import 'package:forest_tagger/components/qrshower.dart';
import 'package:forest_tagger/main.dart';
import 'package:toast/toast.dart';
import 'package:uuid/uuid.dart';

class GeneratorPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GeneratorPageState();
  }
}

class GeneratorPageState extends State<GeneratorPage> {
  String dataToFeed = "";
  TextEditingController controllerloc = TextEditingController();
  TextEditingController controllerlen = TextEditingController();
  TextEditingController controllername = TextEditingController();
  TextEditingController controlleryear = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          backButton(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage("assets/images/palm-tree-outline.png"),
                  height: 200,
                  width: 100,
                  color: Colors.green,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Wrap(
                    children: [
                      Text(
                        "Enter the details to generate a QR code :",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 300,
                    child: TextFormField(
                      controller: controllername,
                      decoration: InputDecoration(
                          labelText: 'Enter name of the tree species',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.nature_people)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 300,
                    child: TextFormField(
                      controller: controlleryear,
                      decoration: InputDecoration(
                          labelText: 'Enter year of plantation of the tree',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.timelapse)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 300,
                    child: TextFormField(
                      controller: controllerloc,
                      decoration: InputDecoration(
                          labelText: 'Enter latitude, longitude',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.location_on)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 300,
                    child: TextFormField(
                      controller: controllerlen,
                      decoration: InputDecoration(
                          labelText: 'Enter max height of the tree',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.height)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  child: Text(
                    "Generate QR code",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.green, width: 3.0),
                          borderRadius: BorderRadius.circular(5.0))),
                  onPressed: () async {
                    if (controllerloc.text.isNotEmpty &&
                        controllerlen.text.isNotEmpty &&
                        controlleryear.text.isNotEmpty &&
                        controllername.text.isNotEmpty) {
                      String treeId = Uuid().v4();
                      String treeName = controllername.text;
                      String treeYear = controlleryear.text;
                      String loc = controllerloc.text;
                      String treeMaxLen = controllerlen.text;

                      FirebaseFirestore firestore = FirebaseFirestore.instance;
                      firestore.collection("trees").doc(treeId).set({
                        "treeId": treeId,
                        "treeName": treeName,
                        "treeYear": treeYear,
                        "loc": loc,
                        "treeMaxLen": treeMaxLen
                      });

                      String data = "";
                      data += treeId + ", ";
                      data += controllerloc.text + ", ";
                      data += controllerlen.text;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QRShower(data)));
                    } else {
                      Toast.show(
                        "Please enter the data",
                        context,
                        duration: Toast.LENGTH_LONG,
                        gravity: Toast.BOTTOM,
                        textColor: Colors.white,
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
