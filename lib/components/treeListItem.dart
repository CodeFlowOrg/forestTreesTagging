import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forest_tagger/DataModels/Tree.dart';
import 'package:forest_tagger/components/treeInfoPage.dart';

class TreeListItem extends StatelessWidget{

  int pos;
  Tree t;
  TreeListItem(this.pos, this.t);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      child: Container(
        height: 40,
        child: Center(child: Text("Tree$pos")),
      ),
      onTap:() {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> TreeInfoPage(t)));
      },
    );

  }

}