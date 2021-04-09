import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forest_tagger/DataModels/Tree.dart';
import 'package:forest_tagger/components/treeInfoPage.dart';

class TreeListItem extends StatelessWidget {
  int pos;
  Tree t;
  TreeListItem(this.pos, this.t);
  String name, year, length;

  Future<void> fetchData(String docid) async {
    try {
      await FirebaseFirestore.instance
          .collection('trees')
          .doc(docid)
          .get()
          .then((value) {
        name = value.get('treeName');
        year = value.get('treeYear');
        length = value.get('treeMaxLen');
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await fetchData(t.treeId);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TreeInfoPage(t, name, year, length)));
      },
      child: Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
        decoration:
            boxDecoration(radius: 10, showShadow: true, bgColor: Colors.white),
        padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/images/palm-tree-outline.png",
              color: Colors.green,
              height: 40,
              width: 40,
            ),
            SizedBox(
              width: 16,
            ),
            Text(
              "Tree$pos",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
              maxLines: 1,
            ),
            SizedBox(
              width: 16,
            ),
            FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection("trees")
                  .doc(t.treeId)
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data = snapshot.data.data();
                  if (data != null)
                    return Text(
                      (DateTime.now().year-int.parse(data['treeYear'])).toString()+" years",
                      style: TextStyle(
                          color: Colors.black38,
                          fontSize: 20.0),
                      maxLines: 1,
                    );
                  else
                    return Text('Data not found');
                }

                return CircularProgressIndicator();
              },
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration boxDecoration(
      {double radius = 2,
      Color color = Colors.transparent,
      Color bgColor = Colors.white,
      var showShadow = false}) {
    return BoxDecoration(
      color: bgColor,
      boxShadow: showShadow
          ? [
              BoxShadow(
                  color: Color(0X95E9EBF0), blurRadius: 5, spreadRadius: 1)
            ]
          : [BoxShadow(color: Colors.transparent)],
      border: Border.all(color: color),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    );
  }
}
