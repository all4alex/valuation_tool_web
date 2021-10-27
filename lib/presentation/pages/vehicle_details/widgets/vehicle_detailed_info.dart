import 'package:flutter/material.dart';
import 'package:valuation_tool_web/models/used_vehicle_list.dart';
import 'package:valuation_tool_web/presentation/widgets/info_item_with_spacing.dart';

class VehicleDetailedInfo extends StatelessWidget {
  VehicleDetailedInfo(
      {required this.usedVehicleListItem, required this.mileage});
  final UsedVehicleListItem usedVehicleListItem;
  final String mileage;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
        width: screenSize.width * .32 + 15,
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
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SelectableText(
                'Details',
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff191919),
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 5),
              Info(usedVehicleListItem: usedVehicleListItem, mileage: mileage),
              SizedBox(height: 30),
              CarfaxButton(),
              const SizedBox(height: 30),
              Row(
                children: [
                  RetailButton(),
                  const SizedBox(
                    width: 15,
                  ),
                  ProfitCalculatorButton()
                ],
              )
            ]));
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
              width: MediaQuery.of(context).size.width * .127,
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
              width: MediaQuery.of(context).size.width * .127,
              height: 40,
              alignment: Alignment.center,
              child: const Text('(20) RETAIL MARKET',
                  style: TextStyle(fontSize: 12))),
        )
      ],
    );
  }
}

class CarfaxButton extends StatelessWidget {
  const CarfaxButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/images/carfax_logo.png'),
                const SizedBox(height: 10),
                Text(
                    'CARFAX™ periodically requires users to re-authorize their accounts. Please click the button below to do so.',
                    style: TextStyle(
                        color: Color(0xff777777),
                        fontSize: 12,
                        overflow: TextOverflow.clip)),
              ]),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20)),
          onPressed: () {},
          child: Container(
              width: 170,
              height: 40,
              alignment: Alignment.center,
              child: const Text('LINK CARFAX', style: TextStyle(fontSize: 12))),
        ),
      ],
    );
  }
}

class Info extends StatelessWidget {
  const Info({
    Key? key,
    required this.usedVehicleListItem,
    required this.mileage,
  }) : super(key: key);

  final UsedVehicleListItem usedVehicleListItem;
  final String mileage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(children: [
          Container(
              width: 150,
              child: InfoItemWithSpacing(
                  name: 'Style:', info: '${usedVehicleListItem.style}')),
          Container(
              width: 150,
              child: InfoItemWithSpacing(
                  name: 'Fuel Type:', info: '${usedVehicleListItem.fuelType}')),
          Container(
              width: 150,
              child: InfoItemWithSpacing(
                  name: 'Run Number:', info: 'Empty', isClickable: true)),
          Container(
              width: 150,
              child: InfoItemWithSpacing(
                  name: 'Mileage:', info: '$mileage', isClickable: true)),
        ]),
        SizedBox(width: 70),
        Column(children: [
          Container(
              width: 150,
              child: InfoItemWithSpacing(
                  name: 'Drive Train:',
                  info: '${usedVehicleListItem.drivetrain}')),
          Container(
              width: 150,
              child: InfoItemWithSpacing(name: 'Location:', info: 'Lehi, UT')),
          Container(
              width: 150,
              child: InfoItemWithSpacing(
                  name: 'Auction:', info: 'Demo', isClickable: true)),
          Container(
              width: 150,
              child: InfoItemWithSpacing(
                  name: 'Region:', info: 'Utah', isClickable: true)),
        ]),
      ],
    );
  }
}
