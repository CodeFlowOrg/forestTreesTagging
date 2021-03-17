import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:forest_tagger/Services/signUpAuthentication.dart';

import 'logIn.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _signUpKey = GlobalKey<FormState>();
  TextEditingController _userName = TextEditingController();
  TextEditingController _userEmail = TextEditingController();
  TextEditingController _userPwd = TextEditingController();
  TextEditingController _userConfirmPwd = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _userName.dispose();
    _userEmail.dispose();
    _userPwd.dispose();
    _userConfirmPwd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: _signUpKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 50.0,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 40.0,
                    fontFamily: 'Lora',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.0,
                    color: Colors.brown,
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: _userName,
                  maxLines: 1,
                  validator: (userName) {
                    if (userName.length < 4)
                      return "User Name At Least 4 characters";
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "User Name",
                    labelStyle: TextStyle(color: Colors.blueAccent),
                    suffixIcon: Icon(
                      Icons.person,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                //color: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: _userEmail,
                  validator: (userEmail) {
                    RegExp _emailRegex = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                    if (_emailRegex.hasMatch(userEmail)) {
                      return null;
                    }
                    return "Enter Valid Email";
                  },
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.blueAccent),
                    suffixIcon: Icon(
                      Icons.email_sharp,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                //color: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: _userPwd,
                  validator: (userPwd) {
                    if (userPwd.length < 6)
                      return "Password At Least 6 characters";
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.blueAccent),
                    suffixIcon: Icon(
                      Icons.security,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                //color: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: _userConfirmPwd,
                  obscureText: true,
                  validator: (userConPwd) {
                    if (userConPwd.length < 6)
                      return "Password at least 6 characters";
                    else if (userConPwd != _userPwd.text)
                      return "Password and Confirm Password are not same";
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    labelStyle: TextStyle(color: Colors.blueAccent),
                    suffixIcon: Icon(
                      Icons.security_rounded,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                //color: Colors.yellow,
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 5.0,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    primary: Colors.lightBlueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(30)),
                  ),
                  child: Container(
                    //color: Colors.red,
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    if (_signUpKey.currentState.validate()) {
                      print("Can Proceed from Sign Up");
                      var _signAuth = SignUpAuth(this._userEmail.text,
                          this._userPwd.text, this._userName.text, context);
                      _signAuth.auth();
                    } else
                      print("Can't Proceed From Sign Up");
                  },
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                //color: Colors.yellow,
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 5.0,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(30)),
                  ),
                  child: Container(
                    //color: Colors.red,
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => LogInScreen()),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
