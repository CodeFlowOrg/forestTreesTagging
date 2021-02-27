
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:forest_tagger/components/homeScreen.dart';

import 'DataModels/Tree.dart';


void main() async{

  runApp(MyApp());
  await Firebase.initializeApp();

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomeScreen(),
    );
  }
}
