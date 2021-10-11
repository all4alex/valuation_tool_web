import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:valuation_tool_web/models/used_vehicle_list.dart';
import 'package:valuation_tool_web/models/used_vehicles.dart';

class BlackBookTradeInData extends StatelessWidget {
  BlackBookTradeInData(
      {required this.usedVehicles, required this.vehicleIndex});
  final UsedVehicles usedVehicles;
  final int vehicleIndex;

  @override
  Widget build(BuildContext context) {
    UsedVehicleListItem vehicleListItem =
        usedVehicles.usedVehicleList![vehicleIndex];
    return Table(
      border: TableBorder.all(width: 1.0, color: Color(0xffCCCCCC)),
      children: [
        TableRow(
            decoration: BoxDecoration(color: Color(0xffE4E6EF)),
            children: [
              Container(
                  width: 120,
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.bottomCenter,
                  child: Text('TRADE\nIN',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12))),
              Container(
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.bottomCenter,
                  child: Text('CLEAN',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12))),
              Container(
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.bottomCenter,
                  child: Text('AVERAGE',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12))),
              Column(children: [
                Container(
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.bottomCenter,
                    child: Text('ROUGH',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12)))
              ]),
            ]),
        TableRow(children: [
          Column(children: [
            Container(
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                child: Text('Base:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 13)))
          ]),
          moneyFormatText(vehicleListItem.baseTradeinClean),
          moneyFormatText(vehicleListItem.baseTradeinAvg),
          moneyFormatText(vehicleListItem.baseTradeinRough)
        ]),
        TableRow(children: [
          Column(children: [
            Container(
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                child: Text(
                  'Options:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ))
          ]),
          moneyFormatText(vehicleListItem.addDeductTradeinClean),
          moneyFormatText(vehicleListItem.addDeductTradeinAvg),
          moneyFormatText(vehicleListItem.addDeductTradeinRough)
        ]),
        TableRow(children: [
          Column(children: [
            Container(
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                child: Text('Mileage:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 13)))
          ]),
          moneyFormatText(vehicleListItem.mileageTradeinClean),
          moneyFormatText(vehicleListItem.mileageTradeinAvg),
          moneyFormatText(vehicleListItem.mileageTradeinRough)
        ]),
        TableRow(children: [
          Column(children: [
            Container(
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                child: Text('Region:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 13)))
          ]),
          moneyFormatText(vehicleListItem.regionalTradeinClean),
          moneyFormatText(vehicleListItem.regionalTradeinAvg),
          moneyFormatText(vehicleListItem.regionalTradeinRough)
        ]),
        TableRow(
            decoration: BoxDecoration(color: Color(0xffE4E6EF)),
            children: [
              Column(children: [
                Container(
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    child: Text('Total:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13)))
              ]),
              moneyFormatText(vehicleListItem.adjustedTradeinClean),
              moneyFormatText(vehicleListItem.adjustedTradeinAvg),
              moneyFormatText(vehicleListItem.adjustedTradeinRough)
            ]),
      ],
    );
  }

  Container moneyFormatText(int? value) {
    return Container(
        padding: EdgeInsets.all(5),
        alignment: Alignment.center,
        child: Text(
          value != null
              ? NumberFormat.simpleCurrency()
                  .format(value.toDouble())
                  .split('.')[0]
              : '\$0',
          style: TextStyle(fontSize: 12),
        ));
  }
}
