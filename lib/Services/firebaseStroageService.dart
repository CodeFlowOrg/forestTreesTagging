
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseStorageServices{
  File _image;
  BuildContext _context;

  FirebaseStorageServices(this._image,this._context);
  
    Future uploadProfilePic() async {
    // Profile Image name Same as user id
    String fileName = FirebaseAuth.instance.currentUser.uid;
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = firebaseStorageRef.putFile(this._image);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 5),
        content: Text('Wait...Picture is uploading')));
    await uploadTask.whenComplete(() {
      print("Picture Uploaded");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Picture Uploaded')));
    });
  }
}