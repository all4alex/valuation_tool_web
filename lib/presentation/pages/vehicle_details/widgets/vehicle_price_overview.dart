import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VehiclePriceOverview extends StatefulWidget {
  VehiclePriceOverview({
    required this.title,
    required this.price,
    required this.minPrice,
    required this.maxPrice,
    required this.backgroundColor,
  });
  final String title;
  final int price;
  final int minPrice;
  final int maxPrice;

  final Color backgroundColor;

  @override
  State<VehiclePriceOverview> createState() => _VehiclePriceOverviewState();
}

class _VehiclePriceOverviewState extends State<VehiclePriceOverview> {
  final formatCurrency = new NumberFormat.simpleCurrency(decimalDigits: 0);
  late String price;
  late String minPrice;
  late String maxPrice;
  @override
  void initState() {
    price = formatCurrency.format(widget.price);
    minPrice = formatCurrency.format(widget.minPrice);
    maxPrice = formatCurrency.format(widget.maxPrice);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
        height: 100,
        width: screenSize.width * .16,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
                spreadRadius: 0),
          ],
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SelectableText(
                widget.title,
                style: TextStyle(fontSize: 13, color: Colors.white),
              ),
              SelectableText(
                '$price',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
              SelectableText(
                '$minPrice to $maxPrice',
                style: TextStyle(fontSize: 13, color: Colors.white),
              )
            ]));
  }
}
