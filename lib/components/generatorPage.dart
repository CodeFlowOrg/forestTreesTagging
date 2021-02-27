
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forest_tagger/components/qrshower.dart';
import 'package:forest_tagger/main.dart';
import 'package:uuid/uuid.dart';

class GeneratorPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return GeneratorPageState();
  }
  
}

class GeneratorPageState extends State<GeneratorPage>{

  String dataToFeed = "";
  TextEditingController controllerloc = TextEditingController();
  TextEditingController controllerlen = TextEditingController();
  TextEditingController controllername = TextEditingController();
  TextEditingController controlleryear = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 300,
              child: TextFormField(
                controller: controllername,
                decoration: InputDecoration(
                    labelText: 'Enter name of the tree species',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.nature_people)
                ),
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
                    prefixIcon: Icon(Icons.timelapse)
                ),
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
                  prefixIcon: Icon(Icons.location_on)
                ),
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
                    prefixIcon: Icon(Icons.height)
                ),
              ),
            ),
          ),
          FlatButton(
            child: Text("Generate QR code", style: TextStyle(color: Colors.white),),
            color: Colors.green,
            onPressed: () async{
              if(controllerloc.text.isNotEmpty && controllerlen.text.isNotEmpty && controlleryear.text.isNotEmpty && controllername.text.isNotEmpty){
                String treeId = Uuid().v4();
                String treeName = controllername.text;
                String treeYear = controlleryear.text;
                String loc = controllerloc.text;
                String treeMaxLen = controllerlen.text;

                FirebaseFirestore firestore = FirebaseFirestore.instance;
                firestore.collection("trees").doc(treeId).set(
                  {
                    "treeId": treeId,
                    "treeName": treeName,
                    "treeYear": treeYear,
                    "loc": loc,
                    "treeMaxLen": treeMaxLen
                  }
                );

                String data = "";
                data+=treeId+", ";
                data+=controllerloc.text+", ";
                data+=controllerlen.text;
                Navigator.push(context, MaterialPageRoute(builder: (context)=> QRShower(data)));
              }
            },
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.green, width: 3.0),
                borderRadius: BorderRadius.circular(20.0)
            ),
          )

        ],
      ),
    );

  }
}