import 'package:clip_shadow/clip_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:forest_tagger/Services/signUpAuthentication.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'logIn.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _signUpKey = GlobalKey<FormState>();
  bool isLoading = false;

  TextEditingController _userName = TextEditingController();
  TextEditingController _userEmail = TextEditingController();
  TextEditingController _userPwd = TextEditingController();
  TextEditingController _userConfirmPwd = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    isLoading = false;
    super.initState();
  }

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
    var width = MediaQuery.of(context).size.width;
    return ModalProgressHUD(
        inAsyncCall: isLoading,
        color: Colors.black54,
        opacity: 0.7,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: Colors.black38,
          strokeWidth: 5.0,
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: _signUpKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: ClipPath(
                              clipper: oclip(),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                  color: Color(0xff1e4d2b),
                                ),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: ClipShadow(
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(-10.0, -200.0),
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0,
                                  color: Color(0x4f8B4513),
                                )
                              ],
                              clipper: rclip(),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                  color: Color(0xff8B4513),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.1,
                                top: MediaQuery.of(context).size.height * 0.1,
                              ),
                              child: Text(
                                'Signup',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffF4F5F7),
                                  fontSize: 40,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                          suffixIcon: Icon(
                            Icons.person,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: width * 0.01,
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
                          suffixIcon: Icon(
                            Icons.email_sharp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: width * 0.01,
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
                          suffixIcon: Icon(
                            Icons.security,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: width * 0.01,
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
                          suffixIcon: Icon(
                            Icons.security_rounded,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: width * 0.0005,
                    ),
                    Container(
                      //color: Colors.yellow,
                      alignment: Alignment.center,
                      child: TextButton(
                        child: Container(
                          //color: Colors.red,
                          alignment: Alignment.centerRight,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Text(
                            "Do you already have Account?",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.brown,
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
                      height: width * 0.01,
                    ),
                    Container(
                      //color: Colors.yellow,
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 5.0,
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          primary: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadiusDirectional.circular(30)),
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
                            setState(() {
                              print("True");
                              isLoading = true;
                            });

                            print("Can Proceed from Sign Up");
                            var _signAuth = SignUpAuth(
                                this._userEmail.text,
                                this._userPwd.text,
                                this._userName.text,
                                context);
                            _signAuth.auth();

                            setState(() {
                              print("False");
                              isLoading = false;
                            });
                          } else
                            print("Can't Proceed From Sign Up");
                        },
                      ),
                    ),
                    SizedBox(
                      height: width * 0.003,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
