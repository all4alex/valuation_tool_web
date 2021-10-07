import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffD9DBE1),
      body: Column(
        children: <Widget>[
          Container(
              height: screenSize.height,
              width: screenSize.width / 20,
              margin: const EdgeInsets.only(
                  right: 6.0), //Same as `blurRadius` i guess
              decoration: const BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                      spreadRadius: 0),
                ],
              )),
        ],
      ),
    );
  }
}
