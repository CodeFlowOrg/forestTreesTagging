import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageServices {
  static final FirebaseStorageServices _singleton =
      new FirebaseStorageServices._internal();
  FirebaseStorageServices._internal();
  static FirebaseStorageServices get instance => _singleton;

  String path;
  
  //used to upload profileimage on firebase storage bucket and then generate the imageurl,
  //which is further used to load image
  Future uploadProfilePic(File _image) async {
    // Profile Image name Same as user id
    String fileName = FirebaseAuth.instance.currentUser.uid;
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = firebaseStorageRef.putFile(_image);

    await uploadTask.whenComplete(() async {
      print('File Uploaded');
      firebaseStorageRef.getDownloadURL().then((fileURL) async{
        path = fileURL;
        print(path);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .update({
          'profileimg': path,
        });
      });
    });
  }
}
