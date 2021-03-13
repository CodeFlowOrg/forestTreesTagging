import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forest_tagger/DataModels/Tree.dart';

class TreeInfoPage extends StatelessWidget {
  Tree t;

  TreeInfoPage(this.t);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Tree Id: "), Text(t.treeId)],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Tree Location: "),
              Text(t.latitude.toString() + ", " + t.longitude.toString())
            ],
          ),
          FutureBuilder(
            future: firestore.collection("trees").doc(t.treeId).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data = snapshot.data.data();
                if (data != null)
                  return Column(
                    children: [
                      Text("tree Name: ${data['treeName']}"),
                      Text("year of plantation: ${data['treeYear']}"),
                      Text("Max height of the tree: ${data['treeMaxLen']}")
                    ],
                  );
                else
                  return Text('Data not found');
              }

              return CircularProgressIndicator();
            },
          )
        ],
      ),
    );
  }
}
