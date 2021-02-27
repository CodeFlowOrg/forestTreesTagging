
import 'package:forest_tagger/main.dart';
import 'package:sqflite/sqflite.dart';

class Tree{

  String treeId;
  String latitude;
  String longitude;

  Tree(this.treeId, this.latitude, this.longitude);

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      "treeId": treeId,
      "latitude": latitude,
      "longitude": longitude,
    };
    return map;
  }

  Tree.fromMap(Map<String, dynamic> map){
    treeId = map['treeId'];
    latitude = map['latitude'];
    longitude = map['longitude'];
  }

}

class TreeProvider{

  Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
            create table Trees ( 
              treeId text primary key, 
              latitude text not null,
              longitude text not null)
            ''');
        });
  }

  void insert(Tree tree) async {
    await open("treeDatabase.db");
    await db.insert("Trees", tree.toMap(),nullColumnHack: 'id');
  }

  Future<List<Map>> getTrees() async{
    await open("treeDatabase.db");
    return db.query("Trees", columns: ["treeId", "latitude", "longitude"]);
  }

}