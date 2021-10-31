import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:valuation_tool_web/models/retail_statistics_response.dart';

class ActiveListingStatistic extends StatelessWidget {
  ActiveListingStatistic(this.activeStatistics);
  final ActiveStatistics activeStatistics;
  @override
  Widget build(BuildContext context) {
    final formatCurrency = new NumberFormat.simpleCurrency(decimalDigits: 0);

    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Active'),
            Text('Vehicle count: ' + activeStatistics.vehicleCount.toString()),
          ],
        ),
        Divider(),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(width: 55, child: Text('')),
              Text('Min'),
              Text('Max'),
              Text('Avg'),
              Text('Mean'),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: 55,
                  child: Text(
                    'Price: ',
                    style: TextStyle(fontSize: 12),
                  )),
              Text(
                formatCurrency.format(activeStatistics.minimumPrice),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              ),
              Text(
                formatCurrency.format(activeStatistics.maximumPrice),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              ),
              Text(
                formatCurrency.format(activeStatistics.meanPrice),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              ),
              Text(
                formatCurrency.format(activeStatistics.medianPrice),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: 55,
                  child: Text('Mileage: ', style: TextStyle(fontSize: 12))),
              Text(
                activeStatistics.minimumMileage.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              ),
              Text(
                activeStatistics.maximumMileage.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              ),
              Text(
                activeStatistics.meanMileage.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              ),
              Text(
                activeStatistics.medianMileage.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
