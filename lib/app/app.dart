import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:valuation_tool_web/app/utils/app_scroll_behavior.dart';
import 'package:valuation_tool_web/presentation/pages/vehicle_details/vehicle_details.dart';
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

  final List<ChartData> chartData = <ChartData>[
    ChartData(x: 'Jan', y: 6, yValue: 6, secondSeriesYValue: -1),
    ChartData(x: 'Feb', y: 8, yValue: 8, secondSeriesYValue: -1.5),
    ChartData(x: 'Mar', y: 12, yValue: 11, secondSeriesYValue: -2),
    ChartData(x: 'Apr', y: 15.5, yValue: 16, secondSeriesYValue: -2.5),
    ChartData(x: 'May', y: 20, yValue: 21, secondSeriesYValue: -3),
    ChartData(x: 'June', y: 24, yValue: 25, secondSeriesYValue: -3.5),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carketa Valuation Web',
      debugShowCheckedModeBanner: false,
      scrollBehavior: AppScrollBehavior(),
      initialRoute: '/',
      onGenerateRoute: Flurorouter.router.generator,
      // home: Scaffold(body: VehicleDetails(onAddSuccess: () {})),
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

class ChartData {
  ChartData(
      {required this.x,
      required this.y,
      required this.yValue,
      required this.secondSeriesYValue});
  String x;
  double y;
  double yValue;
  double secondSeriesYValue;
}
