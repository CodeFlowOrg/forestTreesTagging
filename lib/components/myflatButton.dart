import 'package:flutter/material.dart';

class MyFlatButton extends StatelessWidget {
  String text;
  Widget widget;

  MyFlatButton(String text, Widget widget) {
    this.text = text;
    this.widget = widget;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlatButton(
        padding: EdgeInsets.all(15.0),
        onPressed: () async {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => widget));
        },
        child: Text(
          text,
          style:
              TextStyle(color: Colors.lightGreen, fontWeight: FontWeight.bold),
        ),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.green, width: 3.0),
            borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }
}
