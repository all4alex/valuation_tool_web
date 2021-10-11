import 'package:flutter/material.dart';

class VinPage extends StatelessWidget {
  VinPage({required this.vin});
  final String vin;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.cyan,
        child: Center(
            child: Text(
          'Home Page ... :D $vin',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
        )),
      ),
    );
  }
}
