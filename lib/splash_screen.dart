import 'package:flutter/material.dart';

import 'widgets/vehicle_list.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 1000), () {
      Navigator.pushNamed(context, '/main/vehicles',
          arguments: VehicleListArgs('all'));
    });
    return Scaffold(
      body: Center(
          child: SizedBox(
              width: MediaQuery.of(context).size.width * .3,
              child: Image.asset('assets/images/logo_with_name.png'))),
    );
  }
}
