import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forest_tagger/DataModels/Tree.dart';
import 'package:forest_tagger/components/treeInfoPage.dart';

class TreeListItem extends StatelessWidget{

  int pos;
  Tree t;
  TreeListItem(this.pos, this.t);
  String name,year,length;

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
      child: Container(
        height: 40,
        child: Center(child: Text("Tree$pos")),
      ),
      onTap:() async {
        await fetchData(t.treeId);
        Navigator.push(context, MaterialPageRoute(builder: (context)=> TreeInfoPage(t,name,year,length)));
      },
    );

  }

}