import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:forest_tagger/components/logIn.dart';
import 'package:forest_tagger/components/signUp.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 15),
                child: Image(
                  image: AssetImage("assets/images/login.png"),
                  height: 300,
                  width: double.infinity,
                  color: Color(0xffFF43AD0B),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "TREES TAGGING",
                  style: TextStyle(
                    fontFamily: 'Lora',
                    fontSize: 30.0,
                    // fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffAD0033),
                    letterSpacing: 2.0,
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Tag the tree by location",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffFA1B5D),
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              SizedBox(
                height: 100.0,
              ),
              Container(
                //color: Colors.yellow,
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 5.0,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    primary: Color(0xff3AB54A),
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SignUpScreen()),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                //color: Colors.yellow,
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 5.0,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    primary: Color(0xff3AB54A),
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
