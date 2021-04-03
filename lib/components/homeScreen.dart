import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  // By default profile image set
  Image _profileImage = Image.asset(
    'assets/images/sample_profile_image.jpg',
    fit: BoxFit.fill,
  );

  _HomeScreen(this.name);

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

  Future uploadProfilePic(BuildContext context) async {
    setState(() {
      _uploadImg = null;
    });
    // Profile Image name Same as user id
    String fileName = FirebaseAuth.instance.currentUser.uid;
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = firebaseStorageRef.putFile(_image);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 5),
        content: Text('Wait...Picture is uploading')));
    await uploadTask.whenComplete(() {
      print("Picture Uploaded");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Picture Uploaded')));
    });
  }

  Future<void> getProfilePicFromFirebase() async {
    try {
      String fileName = FirebaseAuth.instance.currentUser.uid;
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      setState(() async {
        try {
          // Get Profile Image from Firebase Storage
          _profileImage = Image.network(
            await firebaseStorageRef.getDownloadURL(),
            fit: BoxFit.fill,
          );
        } catch (e) {
          // If user not set profile image
          print("User not set profile image");
          print(e.toString());
          setState(() {
            _profileImage = Image.asset(
              'assets/images/sample_profile_image.jpg',
              fit: BoxFit.fill,
            );
          });
        }
      });
    } catch (e) {
      // Sometimes due to lagging, Image not loading...so loading screen
      // If you close the app and reopen, profile image automatically come
      print("Lagging Problem");
      print(e.toString());
      setState(() {
        _profileImage = Image.asset(
          'assets/images/loading.gif',
          fit: BoxFit.fill,
        );
      });
    }
  }

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
      if (name == "User") {
        FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: FirebaseAuth.instance.currentUser.email)
            .get()
            .then((querySnapShot) {
          querySnapShot.docs.forEach((element) {
            setState(() {
              print(element.get('user'));
              this.name = element.get('user');
            });
          });
        });
      }
      getProfilePicFromFirebase();
    } catch (e) {
      print("Fetching Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff287030),
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
                        backgroundColor: Colors.black,
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

                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,),
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt_rounded,
                          size: 30.0,
                          color: Colors.white,
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
                        color: Colors.white,
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
                  style: TextStyle(color: Colors.white,letterSpacing: 1),
                ),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    primary: Color(0xFF246326),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.green, width: 3.0),
                        borderRadius: BorderRadius.circular(5.0))),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
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
