import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:valuation_tool_web/models/retail_statistics_response.dart';

class SoldListingStatistic extends StatelessWidget {
  SoldListingStatistic(this.soldStatistics);
  final SoldStatistics soldStatistics;
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
            Text('Sold'),
            Text('Vehicle count: ' + soldStatistics.vehicleCount.toString()),
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
                  child: Text('Price: ', style: TextStyle(fontSize: 12))),
              Text(
                formatCurrency.format(soldStatistics.minimumPrice),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              ),
              Text(
                formatCurrency.format(soldStatistics.maximumPrice),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              ),
              Text(
                formatCurrency.format(soldStatistics.meanPrice),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              ),
              Text(
                formatCurrency.format(soldStatistics.medianPrice),
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
                soldStatistics.minimumMileage.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              ),
              Text(
                soldStatistics.maximumMileage.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              ),
              Text(
                soldStatistics.meanMileage.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              ),
              Text(
                soldStatistics.medianMileage.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
