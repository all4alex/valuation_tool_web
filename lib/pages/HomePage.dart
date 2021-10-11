import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({required this.onPressed});
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.cyan,
        child: Center(
            child: InkWell(
          onTap: onPressed,
          child: Text(
            'Home Page ... :D',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
          ),
        )),
      ),
    );
  }
}

// in the same i will add all the pages.... now...

// ok i have added it
