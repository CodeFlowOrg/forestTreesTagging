import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forest_tagger/components/logIn.dart';

class SignUpAuth {
  String _email;
  String _pwd;
  String _userName;
  BuildContext _context;

  SignUpAuth(this._email, this._pwd, this._userName, this._context);

  void auth() async {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: this._email, password: this._pwd)
        .then((signedUpUser) {
      signedUpUser.user.sendEmailVerification();
      FirebaseFirestore.instance.collection('users').add({
        'email': this._email,
        'user': this._userName,
      });

      FirebaseAuth.instance.signOut();

      Navigator.pop(this._context);
      Navigator.push(
        this._context,
        MaterialPageRoute(builder: (_) => LogInScreen()),
      );
      messageShow(this._context, "Sign Up Complete", "Please Log-in to Enjoy this app");
    }).catchError((e) {
      print("Sign-Up Error is: ${e.toString()}");
      if(e.toString() == "[firebase_auth/email-already-in-use] The email address is already in use by another account.")
        messageShow(this._context, "Sign-Up Error", "Email Already Used by other User");
      else
        messageShow(this._context, "Sign-Up Error", "Unknown Error Happen....\nMake Sure Your device connected on internet");
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
