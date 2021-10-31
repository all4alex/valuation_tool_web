import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:valuation_tool_web/models/retail_statistics_response.dart';
import 'package:valuation_tool_web/presentation/widgets/retail_listing/retail_list_item.dart';
import 'package:valuation_tool_web/presentation/widgets/retail_listing/sold_listing_statistic.dart';

import 'active_listing_statistic.dart';

class RetailListing extends StatefulWidget {
  const RetailListing({
    Key? key,
    required this.activeRetailList,
    required this.soldRetailList,
    required this.vehicleName,
    required this.retailStatisticsResponse,
  }) : super(key: key);

  final List<RetailItemResponse> activeRetailList;
  final List<RetailItemResponse> soldRetailList;
  final String vehicleName;
  final RetailStatisticsResponse retailStatisticsResponse;

  @override
  State<RetailListing> createState() => _RetailListingState();
}

class _RetailListingState extends State<RetailListing> {
  final formatCurrency = new NumberFormat.simpleCurrency(decimalDigits: 0);
  bool isShowingActiveListing = true;
  bool isListingStatisticExpanded = false;

  List<RetailItemResponse> retailItemList = <RetailItemResponse>[];
  String daysToTurn = '';
  String daysSupply = '';
  String avgPrice = '';
  String avgMileage = '';
  late ActiveStatistics activeStatistics;
  late SoldStatistics soldStatistics;

  @override
  void initState() {
    if (isShowingActiveListing) {
      retailItemList = widget.activeRetailList;
    } else {
      retailItemList = widget.soldRetailList;
    }
    activeStatistics =
        widget.retailStatisticsResponse.listingsStatistics!.activeStatistics!;
    soldStatistics =
        widget.retailStatisticsResponse.listingsStatistics!.soldStatistics!;

    daysToTurn = widget
        .retailStatisticsResponse.listingsStatistics!.meanDaysToTurn
        .toString();
    daysSupply = widget
        .retailStatisticsResponse.listingsStatistics!.marketDaysSupply
        .toString();

    double getPriceAvg =
        (activeStatistics.meanPrice! + soldStatistics.meanPrice!) / 2;
    double getMileageAvg =
        (activeStatistics.meanMileage! + soldStatistics.meanMileage!) / 2;

    avgPrice = formatCurrency.format(getPriceAvg);
    avgMileage = getMileageAvg.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width * .4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Material(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                    height: 80,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                      color: Color(0xffFFFFFF),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Color(0xffE6E6E6),
                            offset: Offset(0.0, 1.0),
                            blurRadius: 6.0,
                            spreadRadius: 0),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '2018 ACURA ILX Base Clean',
                              style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  color: Color(0xff191919),
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Retail Market Value Listings',
                                style: GoogleFonts.roboto(
                                    fontSize: 14, color: Color(0xff191919)))
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.close),
                            padding: EdgeInsets.zero)
                      ],
                    )),
                const SizedBox(height: 1),
                Material(
                    color: Color(0xffF4F7FC),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              '(${widget.activeRetailList.length + widget.soldRetailList.length}) Retail Market',
                              style: GoogleFonts.roboto(
                                  fontSize: 14, color: Color(0xff191919))),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.settings,
                                      color: Color(0xff494949)),
                                  padding: EdgeInsets.zero),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.sort,
                                      color: Color(0xff494949)),
                                  padding: EdgeInsets.zero)
                            ],
                          )
                        ],
                      ),
                    )),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Row(children: [
                    Expanded(
                      flex: 1,
                      child: Column(children: [
                        SelectableText('DAYS TO TURN',
                            style: TextStyle(
                                color: Color(0xff36334E), fontSize: 10)),
                        SelectableText(daysToTurn,
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                                fontWeight: FontWeight.w700))
                      ]),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(children: [
                        SelectableText('DAYS SUPPLY',
                            style: TextStyle(
                                color: Color(0xff36334E), fontSize: 10)),
                        SelectableText(daysSupply,
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                                fontWeight: FontWeight.w700))
                      ]),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(children: [
                        SelectableText('AVG PRICE',
                            style: TextStyle(
                                color: Color(0xff36334E), fontSize: 10)),
                        SelectableText(avgPrice,
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                                fontWeight: FontWeight.w700))
                      ]),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(children: [
                        SelectableText('AVG MILEAGE',
                            style: TextStyle(
                                color: Color(0xff36334E), fontSize: 10)),
                        SelectableText(avgMileage,
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                                fontWeight: FontWeight.w700))
                      ]),
                    )
                  ]),
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SelectableText('Listing Statistics',
                          style: TextStyle(
                              color: Color(0xff36334E), fontSize: 14)),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              isListingStatisticExpanded =
                                  !isListingStatisticExpanded;
                            });
                          },
                          icon: Icon(Icons.arrow_drop_down),
                          padding: EdgeInsets.zero)
                    ],
                  ),
                ),
                Visibility(
                  visible: isListingStatisticExpanded,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(children: [
                      ActiveListingStatistic(activeStatistics),
                      SoldListingStatistic(soldStatistics),
                      Divider()
                    ]),
                  ),
                ),
                Container(
                    height: screenSize.height * .6,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.separated(
                      itemCount: retailItemList.length,
                      itemBuilder: (BuildContext context, int i) {
                        return RetailListingItem(
                            onClick: () {},
                            retailItemResponse: retailItemList[i]);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(height: 30);
                      },
                    )),
                Container(
                    height: 70,
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    alignment: Alignment.bottomCenter,
                    decoration: const BoxDecoration(
                      color: Color(0xffF3F3F3),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 6.0,
                            spreadRadius: 0),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: isShowingActiveListing
                                ? Color(0xffB5F28E)
                                : Color(0xff4DAD11),
                          ),
                          onPressed: () {
                            setState(() {
                              isShowingActiveListing = true;
                              retailItemList = widget.activeRetailList;
                            });
                          },
                          child: Container(
                            width: screenSize.width * .16,
                            height: 60,
                            alignment: Alignment.center,
                            child: Text(
                                '(${widget.activeRetailList.length}) ACTIVE',
                                style: TextStyle(
                                    color: isShowingActiveListing
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: 15)),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: isShowingActiveListing
                                ? Color(0xff4DAD11)
                                : Color(0xffB5F28E),
                          ),
                          onPressed: () {
                            setState(() {
                              isShowingActiveListing = false;
                              retailItemList = widget.soldRetailList;
                            });
                          },
                          child: Container(
                            width: screenSize.width * .16,
                            height: 60,
                            alignment: Alignment.center,
                            child: Text(
                                '(${widget.soldRetailList.length}) SOLD',
                                style: TextStyle(
                                    color: isShowingActiveListing
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 15)),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
