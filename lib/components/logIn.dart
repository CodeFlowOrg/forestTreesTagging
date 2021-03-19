import 'package:clip_shadow/clip_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:forest_tagger/Services/logInAuthentication.dart';
import 'package:forest_tagger/components/homeScreen.dart';
import 'package:forest_tagger/components/signUp.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _logInKey = GlobalKey<FormState>();
  TextEditingController _userEmail = TextEditingController();
  TextEditingController _userPwd = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _userEmail.dispose();
    _userPwd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _logInKey,
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
                              color: Color(0xff8B4513),
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
                              color: Color(0x4f1e4d2b),
                            )
                          ],
                          clipper: rclip(),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                              color: Color(0xff1e4d2b),
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
                            'Login',
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
                SizedBox(
                  height: 40.0,
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
                      focusColor: Colors.brown,
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
                      suffixIcon: Icon(
                        Icons.security,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Container(
                    //color: Colors.yellow,
                    alignment: Alignment.center,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        primary: Colors.lightBlueAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.circular(30)),
                      ),
                      child: Container(
                        //color: Colors.red,
                        alignment: Alignment.centerRight,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          "Do you want to create a account?",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => SignUpScreen()),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Container(
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
                                "Log In",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (_logInKey.currentState.validate()) {
                                print("proceed");
                                var _logAuth = LogInAuth(this._userEmail.text,
                                    this._userPwd.text, context);
                                _logAuth.auth();
                              } else {
                                print("Can't Proceed");
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class oclip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var ns = 0.65;
    var nw = 0.65;
    path.lineTo(0, size.height * ns);
    path.lineTo(size.width * nw * 0.65 - 50, size.height * ns);
    path.quadraticBezierTo(size.width * nw * 0.65, size.height * ns,
        size.width * nw * 0.65 + 18, size.height * ns - 50);
    path.lineTo(size.width * nw, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
    throw UnimplementedError();
  }
}

//clipping of left item
class rclip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var ns = 0.65;
    var nw = 0.65;
    path.moveTo(size.width * nw + 60, 0);
    path.lineTo(size.width * nw - 60, size.height - 60);
    path.quadraticBezierTo(
        size.width * nw - 80, size.height, size.width * nw - 10, size.height);
    path.lineTo(size.width - 80, size.height);
    path.quadraticBezierTo(
        size.width - 40, size.height, size.width - 30, size.height - 20);
    path.lineTo(size.width, size.height - 100);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
    throw UnimplementedError();
  }
}
