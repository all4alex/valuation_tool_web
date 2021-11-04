import 'package:flutter/material.dart';
import 'package:valuation_tool_web/presentation/pages/dashboard/my_folders.dart';
import 'package:valuation_tool_web/presentation/pages/dashboard/recent_activity.dart';
import 'package:valuation_tool_web/presentation/pages/dashboard/recent_appraisals.dart';
import 'package:valuation_tool_web/presentation/pages/dashboard/recently_viewed_vehicles.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        RecentlyViewedVehicles(),
        MyFolders(),
        RecentAppraisals(),
        RecentActivity(),
        SizedBox(height: 20),
      ],
    );
  }
}
