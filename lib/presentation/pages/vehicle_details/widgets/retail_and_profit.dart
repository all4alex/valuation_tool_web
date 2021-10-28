import 'package:flutter/material.dart';
import 'package:valuation_tool_web/models/used_vehicle_list.dart';

class RetailAndProfit extends StatelessWidget {
  RetailAndProfit({required this.usedVehicleListItem});
  final UsedVehicleListItem usedVehicleListItem;
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
            RetailButton(),
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

class RetailButton extends StatelessWidget {
  const RetailButton({
    Key? key,
  }) : super(key: key);

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
          onPressed: () {},
          child: Container(
              width: MediaQuery.of(context).size.width * .15,
              height: 40,
              alignment: Alignment.center,
              child: const Text('(20) RETAIL MARKET',
                  style: TextStyle(fontSize: 12))),
        )
      ],
    );
  }
}
