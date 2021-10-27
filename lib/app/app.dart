import 'package:flutter/material.dart';
import 'package:valuation_tool_web/app/utils/app_scroll_behavior.dart';
import 'package:valuation_tool_web/routes.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    Flurorouter.setupRouter();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carketa Valuation Web',
      debugShowCheckedModeBanner: false,
      scrollBehavior: AppScrollBehavior(),
      initialRoute: '/',
      onGenerateRoute: Flurorouter.router.generator,
      // home: VehicleDetails(onAddSuccess: () {}),
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
    );
  }
}

class TestScreen extends StatefulWidget {
  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  void initState() {
    Navigator.pushNamed(
      context,
      '/main/details',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
