import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forest_tagger/Services/dbUserData.dart';
import 'package:forest_tagger/Services/firebaseStroageService.dart';
import 'package:forest_tagger/Services/googleAuthentication.dart';
import 'package:forest_tagger/components/WelComePage.dart';
import 'package:forest_tagger/components/generatorPage.dart';
import 'package:forest_tagger/components/scannerPage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'myflatButton.dart';

class HomeScreen extends StatefulWidget {
  String name = "User";

  HomeScreen(this.name);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeScreen(this.name);
  }
}

class _HomeScreen extends State<HomeScreen> {
  String name = "User";
  File _image;
  var _uploadImg;
  final _auth = AuthService.instance;
  final firebasestorage = FirebaseStorageServices.instance;
  final userdata = DbUserData.instance;

  // By default profile image set
  Image _profileImage = Image.asset(
    'assets/images/sample_profile_image.jpg',
    fit: BoxFit.fill,
  );

  _HomeScreen(this.name);
  
  //used for picking image from gallery
  Future getImageFromStorage(BuildContext context) async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      try {
        _image = File(image.path);
        _uploadImg = setProfilePic(context);
      } catch (e) {
        _uploadImg = null;
      }
      print("Image Path: $_image");
    });
  }
 
 //used for uploading profile image to firebase storage bucket and generating imageurl for further loading image
  Future uploadProfilePic(BuildContext context) async {
    setState(() {
      _uploadImg = null;
    });

    await firebasestorage.uploadProfilePic(_image);
  }
  
  //used for opening file manager to search for images to set as profile pic
  Widget imageSelect() {
    try {
      return _image != null
          ? Image.file(
              _image,
              fit: BoxFit.fill,
            )
          : _profileImage;
    } catch (e) {
      return Image.asset(
        'assets/images/sample_profile_image.jpg',
        fit: BoxFit.fill,
      );
    }
  }
  
  //Used for setting other pic as profile pic from gallery
  Widget setProfilePic(BuildContext context) {
    return GestureDetector(
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/images/upload.png',
              width: 30.0,
            ),
            SizedBox(
              height: 5.0,
            ),
            Text("Upload"),
          ],
        ),
        onTap: () {
          print("Upload Selected");
          uploadProfilePic(context);
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _uploadImg = null;
    try {
      //As soon as the homescreen loads firstly all the user info is fetched from firbase
      userdata.fetchData().then((value) {
        setState(() {
          this.name = userdata.name;
          print(this.name);
          //profile image is set from the fetched data
          _profileImage = Image.network(
            userdata.profileimg,
            fit: BoxFit.fill,
          );
        });
      });
    } catch (e) {
      print("Fetching Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.lightBlueAccent,
                        child: ClipOval(
                          child: SizedBox(
                            width: 192.0,
                            height: 192.0,
                            child: imageSelect(),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 150, left: 173),
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt_rounded,
                          size: 30.0,
                          color: Colors.black54,
                        ),
                        onPressed: () {
                          print("Camera pressed");
                          getImageFromStorage(context);
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(top: 80, right: 30),
                      child: _uploadImg,
                    ),
                  ],
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
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  _auth.signOutGoogle();
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Welcome()),
                  );
                },
              ))
        ],
      ),
    );
  }
}
