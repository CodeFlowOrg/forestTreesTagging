
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageServices{

  static final FirebaseStorageServices _singleton = new FirebaseStorageServices._internal();
  FirebaseStorageServices._internal();
  static FirebaseStorageServices get instance => _singleton;

    Future uploadProfilePic(File _image) async {
    // Profile Image name Same as user id
    String fileName = FirebaseAuth.instance.currentUser.uid;
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = firebaseStorageRef.putFile(_image);

    await uploadTask.whenComplete(() {
     
    });
  }
}