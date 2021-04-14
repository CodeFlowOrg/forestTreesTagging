import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DbUserData {
  static final DbUserData _singleton = new DbUserData._internal();
  DbUserData._internal();
  static DbUserData get instance => _singleton;

  String name, email, profileimg;
  
  //used to fetch user information from firebase
  Future<void> fetchData() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .get()
          .then((value) {
        name = value.get('user');
        email = value.get('email');
        profileimg = value.get('profileimg');
        if(profileimg==null || profileimg==""){
          //if profileimage is not set then load default image
          profileimg = 'https://www.shout-fm.de/media/images/unbekannt.jpg';
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
