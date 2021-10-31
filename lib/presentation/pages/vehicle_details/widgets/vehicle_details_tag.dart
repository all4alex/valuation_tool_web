import 'package:flutter/material.dart';
import 'package:valuation_tool_web/presentation/widgets/info_item_with_spacing.dart';

class VehicleDetailsTag extends StatelessWidget {
  const VehicleDetailsTag({
    required this.mileage,
    required this.regions,
    required this.condition,
    Key? key,
  }) : super(key: key);

  final String mileage;
  final String regions;
  final String condition;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width * .38,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InfoItemWithSpacing(
              name: 'Mileage:', info: mileage, isClickable: true),
          InfoItemWithSpacing(name: 'Region:', info: 'Utah', isClickable: true),
          InfoItemWithSpacing(
              name: 'Condition:', info: 'Average', isClickable: true),
        ],
      ),
    );
  }
}
