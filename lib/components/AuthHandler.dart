import 'package:firebase_auth/firebase_auth.dart';
import 'package:forest_tagger/components/WelComePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'homeScreen.dart';

Widget loggedInChecking(){
  if(FirebaseAuth.instance.currentUser == null)
    return Welcome();
  else {
    return HomeScreen("User");

  }
}

