import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:valuation_tool_web/models/retail_statistics_response.dart';

class RetailListingItem extends StatefulWidget {
  RetailListingItem({
    required this.retailItemResponse,
    required this.onClick,
  });
  final RetailItemResponse retailItemResponse;
  final Function onClick;

  @override
  _RetailListingItemState createState() => _RetailListingItemState();
}

class _RetailListingItemState extends State<RetailListingItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.retailItemResponse.style ?? 'Empty',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.retailItemResponse.dealerName ?? 'Empty',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
                ),
                Text('Mileage: ${widget.retailItemResponse.mileage}',
                    style: TextStyle(fontSize: 13)),
                Text('Fuel type: ${widget.retailItemResponse.fuelTypeFromVin}',
                    style: TextStyle(fontSize: 13)),
                Text('Series: ${widget.retailItemResponse.series}',
                    style: TextStyle(fontSize: 13)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Price: ${widget.retailItemResponse.price}',
                    style: TextStyle(fontSize: 13)),
                Text(
                    'Price Changes: ${widget.retailItemResponse.numberPriceChanges}',
                    style: TextStyle(fontSize: 13)),
                Text(
                    'Days On Market: ${widget.retailItemResponse.daysOnMarket}',
                    style: TextStyle(fontSize: 13)),
                // Text(widget.isClean ? 'Clean' : 'Not Clean',
                //     style: TextStyle(
                //         fontSize: 13,
                //         color: widget.isClean
                //             ? Theme.of(context).primaryColor
                //             : Colors.red)),
                Text(widget.retailItemResponse.listingType ?? 'empty',
                    style: TextStyle(
                        fontSize: 13,
                        color: widget.retailItemResponse.listingType == 'Active'
                            ? Colors.green
                            : Colors.red)),
              ],
            )
          ]),
        ],
      ),
      onTap: widget.onClick(),
    );
  }
}
