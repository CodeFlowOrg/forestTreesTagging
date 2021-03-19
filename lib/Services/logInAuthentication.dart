import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../components/homeScreen.dart';

class LogInAuth {
  String _email;
  String _pwd;
  BuildContext _context;

  LogInAuth(this._email, this._pwd, this._context);

  void auth() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: this._email, password: this._pwd)
        .then((signedInUser) {
      if (!signedInUser.user.emailVerified) {
        messageShow(this._context, "Log-In Error",
            "Email Not Verified\nA Link send to your registered mail\nPlease verify email at first");
        FirebaseAuth.instance.signOut();
      } else {
        FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: this._email)
            .get()
            .then((querySnapShot) {
          querySnapShot.docs.forEach((element) {
            Navigator.pop(this._context);
            Navigator.pop(this._context);
            Navigator.push(
              this._context,
              MaterialPageRoute(
                  builder: (_) => HomeScreen(element.get('user'))),
            );
            messageShow(this._context, "Log In Complete", "Enjoy this app");
          });
        });
      }
    }).catchError((e) {
      print(e);
      messageShow(this._context, "Log-In Error", "Email Not Found");
    });
  }
}

Future<dynamic> messageShow(
    BuildContext _context, String _title, String _content) {
  return showDialog(
      context: _context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black38,
          title: Text(
            _title,
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            _content,
            style: TextStyle(color: Colors.white),
          ),
        );
      });
}
