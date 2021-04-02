import 'package:flutter/material.dart';

class backButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.08,
      left: 20,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.lightGreen[400],
        ),
        child: IconButton(
            icon: Icon(
              Icons.arrow_left,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
    );
  }
}
