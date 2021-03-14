import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:forest_tagger/components/homeScreen.dart';
import 'package:forest_tagger/components/signUp.dart';
import 'file:///C:/Users/dasgu/AndroidStudioProjects/forest_tagger/lib/Services/logInAuthentication.dart';

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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: _logInKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 100.0,
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Log In",
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
                height: 50.0,
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
                            primary: Colors.lightBlueAccent,
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
                  )
                ],
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
