import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valuation_tool_web/models/retail_statistics_response.dart';
import 'package:valuation_tool_web/models/used_vehicle_list.dart';
import 'package:valuation_tool_web/presentation/widgets/retail_listing/retail_listing.dart';

class RetailAndProfit extends StatelessWidget {
  RetailAndProfit({
    required this.usedVehicleListItem,
    required this.vehicleName,
    required this.retailStatisticsResponse,
  });
  final UsedVehicleListItem usedVehicleListItem;
  final String vehicleName;
  final RetailStatisticsResponse retailStatisticsResponse;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
        width: screenSize.width * .38,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
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
        child: Row(
          children: [
            RetailButton(
                vehicleName: vehicleName,
                retailStatisticsResponse: retailStatisticsResponse),
            const SizedBox(
              width: 15,
            ),
            ProfitCalculatorButton()
          ],
        ));
  }
}

class ProfitCalculatorButton extends StatelessWidget {
  const ProfitCalculatorButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          'Profit Adjustment',
          style: TextStyle(
              fontSize: 16,
              color: Color(0xff191919),
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        Text('Check and adjust profitability',
            style: TextStyle(
                color: Color(0xff777777),
                fontSize: 12,
                overflow: TextOverflow.clip)),
        const SizedBox(height: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.green, textStyle: const TextStyle(fontSize: 20)),
          onPressed: () {},
          child: Container(
              width: MediaQuery.of(context).size.width * .15,
              height: 40,
              alignment: Alignment.center,
              child: const Text('PROFIT', style: TextStyle(fontSize: 12))),
        )
      ],
    );
  }
}

class RetailButton extends StatefulWidget {
  const RetailButton({
    required this.retailStatisticsResponse,
    required this.vehicleName,
    Key? key,
  }) : super(key: key);
  final RetailStatisticsResponse retailStatisticsResponse;

  final String vehicleName;

  @override
  State<RetailButton> createState() => _RetailButtonState();
}

class _RetailButtonState extends State<RetailButton> {
  void _showAddNotesModal(BuildContext context) async {
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 0),
      context: context,
      pageBuilder: (BuildContext context, anim1, anim2) {
        return Align(
            alignment: Alignment.center,
            child: RetailListing(
              activeRetailList: activeRetailList,
              soldRetailList: soldRetailList,
              vehicleName: widget.vehicleName,
              retailStatisticsResponse: widget.retailStatisticsResponse,
            ));
      },
      transitionBuilder:
          (BuildContext context, anim1, Animation<double> anim2, Widget child) {
        return SlideTransition(
          position:
              Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0))
                  .animate(anim1),
          child: child,
        );
      },
    );
  }

  List<RetailItemResponse> soldRetailList = <RetailItemResponse>[];
  List<RetailItemResponse> activeRetailList = <RetailItemResponse>[];
  @override
  void initState() {
    for (RetailItemResponse item in widget.retailStatisticsResponse.listings!) {
      if (item.listingType == 'Active') {
        activeRetailList.add(item);
      } else {
        soldRetailList.add(item);
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          'Retail Market',
          style: TextStyle(
              fontSize: 16,
              color: Color(0xff191919),
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        Text('View Retail Market Value Listings',
            style: TextStyle(
                color: Color(0xff777777),
                fontSize: 12,
                overflow: TextOverflow.clip)),
        const SizedBox(height: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20)),
          onPressed: () {
            _showAddNotesModal(context);
          },
          child: Container(
            width: MediaQuery.of(context).size.width * .15,
            height: 40,
            alignment: Alignment.center,
            child: Text(
                '(${activeRetailList.length + soldRetailList.length}) RETAIL MARKET',
                style: TextStyle(fontSize: 12)),
          ),
        )
      ],
    );
  }
}
