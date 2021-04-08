import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forest_tagger/DataModels/Tree.dart';
import 'package:forest_tagger/components/backButton.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class TreeInfoPage extends StatefulWidget {
  Tree t;
  String name, year, length;

  TreeInfoPage(this.t, this.name, this.year, this.length);

  @override
  _TreeInfoPageState createState() => _TreeInfoPageState();
}

class _TreeInfoPageState extends State<TreeInfoPage> {
  List<String> parts;
  final String token =
      'pk.eyJ1IjoibW9oaXQxODA0IiwiYSI6ImNrbjhjcWR1MzAyb2IydW55NXNpMG8ybmoifQ.RhiXGu0GGdr0q4mhqVIf5A';
  final String style = 'mapbox://styles/mapbox/streets-v11';

  @override
  void initState() {
    super.initState();
    parts = widget.length.split(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          backButton(),
          Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 100),
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown),
                            ),
                            SizedBox(height: 5),
                            Text(
                              widget.t.treeId,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 5,
                      top: 0,
                      bottom: 10,
                      child: Image(
                        image:
                            AssetImage("assets/images/palm-tree-outline.png"),
                        height: 200,
                        width: 100,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 35,
                ),
                Container(
                  height: 150,
                  margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: IntrinsicHeight(
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            color: Colors.green,
                            width: 10,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(28.0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Text(
                                            parts[0].trim(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                                color: Colors.brown),
                                          ),
                                          Text(
                                            " Mtr",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                                color: Colors.black38),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Grown in Year ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                                color: Colors.black38),
                                          ),
                                          Text(
                                            widget.year,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                                color: Colors.brown),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text("Exact location of the tree: ",
                          style: TextStyle(fontSize: 15, color: Colors.black)),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 2.0),
                  child: Container(
                    height: 210,
                    child: MapboxMap(
                      accessToken: token,
                      styleString: style,
                      initialCameraPosition: CameraPosition(
                        zoom: 11.0,
                        target: LatLng(double.parse(widget.t.latitude), double.parse(widget.t.longitude)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
