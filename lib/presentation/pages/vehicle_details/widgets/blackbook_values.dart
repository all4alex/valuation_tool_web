import 'package:flutter/material.dart';
import 'package:valuation_tool_web/models/used_vehicles.dart';
import 'package:valuation_tool_web/presentation/widgets/blackbook/black_book_retail_data.dart';
import 'package:valuation_tool_web/presentation/widgets/blackbook/black_book_trade_in_data.dart';
import 'package:valuation_tool_web/presentation/widgets/blackbook/black_book_wholesale_data.dart';
import 'package:valuation_tool_web/presentation/widgets/page_view.dart';

class BlackBookValues extends StatelessWidget {
  BlackBookValues({required this.title, required this.usedVehicles});
  final String title;
  final UsedVehicles usedVehicles;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
        height: screenSize.height * .5,
        width: screenSize.width * .38,
        padding: EdgeInsets.all(20),
        margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
        decoration: const BoxDecoration(
          color: Color(0xffFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
                spreadRadius: 0),
          ],
        ),
        child: Container(
          height: screenSize.height * .5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Image.asset(
                  'assets/images/ic_blackbook.png',
                  width: 120,
                  height: 60,
                ),
              ),
              Container(child: Text('$title')),
              Container(
                padding: EdgeInsets.only(left: 5, bottom: 5),
                child: Text(
                  'Updated: ${usedVehicles.usedVehicleList![0].publishDate}',
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      fontSize: 11,
                      color: Colors.black.withOpacity(.6),
                      fontStyle: FontStyle.italic),
                ),
              ),
              Container(
                height: 180,
                child: BlackBookPageView(
                  listOfPage: [
                    Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: BlackBookRetailData(
                        usedVehicles: usedVehicles,
                        vehicleIndex: 0,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: BlackBookTradeInData(
                        usedVehicles: usedVehicles,
                        vehicleIndex: 0,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: BlackBookWholeSaleData(
                        usedVehicles: usedVehicles,
                        vehicleIndex: 0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 30,
                padding: EdgeInsets.only(right: 5),
                alignment: Alignment.centerRight,
                child: RaisedButton(
                  color: Color(0xff18A0FB),
                  onPressed: () {
                    // _showOptionsDialog(
                    //     context, usedVehicleList.addDeductList);
                  },
                  child: Text(
                    'OPTIONS',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
