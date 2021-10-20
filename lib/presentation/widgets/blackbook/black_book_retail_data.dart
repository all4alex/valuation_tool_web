import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:valuation_tool_web/models/used_vehicle_list.dart';
import 'package:valuation_tool_web/models/used_vehicles.dart';

class BlackBookRetailData extends StatelessWidget {
  BlackBookRetailData({required this.usedVehicles, required this.vehicleIndex});
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
                  child: Text('RETAIL\n',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12))),
              Container(
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.bottomCenter,
                  child: Text('XCLEAN',
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
          moneyFormatText(vehicleListItem.baseRetailXclean),
          moneyFormatText(vehicleListItem.baseRetailClean),
          moneyFormatText(vehicleListItem.baseRetailAvg),
          moneyFormatText(vehicleListItem.baseRetailRough)
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
          moneyFormatText(vehicleListItem.addDeductRetailXclean),
          moneyFormatText(vehicleListItem.addDeductRetailClean),
          moneyFormatText(vehicleListItem.addDeductRetailAvg),
          moneyFormatText(vehicleListItem.addDeductRetailRough)
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
          moneyFormatText(vehicleListItem.mileageRetailXclean),
          moneyFormatText(vehicleListItem.mileageRetailClean),
          moneyFormatText(vehicleListItem.mileageRetailAvg),
          moneyFormatText(vehicleListItem.mileageRetailRough)
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
          moneyFormatText(vehicleListItem.regionalRetailXclean),
          moneyFormatText(vehicleListItem.regionalRetailClean),
          moneyFormatText(vehicleListItem.regionalRetailAvg),
          moneyFormatText(vehicleListItem.regionalRetailRough)
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
              moneyFormatText(vehicleListItem.adjustedRetailXclean),
              moneyFormatText(vehicleListItem.adjustedRetailClean),
              moneyFormatText(vehicleListItem.adjustedRetailAvg),
              moneyFormatText(vehicleListItem.adjustedRetailRough)
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
