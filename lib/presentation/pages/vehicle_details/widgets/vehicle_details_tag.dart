import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valuation_tool_web/bloc/vehicle_info/vehicle_info_bloc.dart';
import 'package:valuation_tool_web/bloc/vehicle_info/vehicle_info_state.dart';
import 'package:valuation_tool_web/models/firestore/vehicle_item.dart';
import 'package:valuation_tool_web/presentation/widgets/add_condition_modal_body.dart';
import 'package:valuation_tool_web/presentation/widgets/add_mileage_modal_body.dart';
import 'package:valuation_tool_web/presentation/widgets/add_region_modal_body.dart';
import 'package:valuation_tool_web/presentation/widgets/info_item_with_spacing.dart';

class VehicleDetailsTag extends StatefulWidget {
  const VehicleDetailsTag({
    required this.region,
    required this.vehicleItem,
    Key? key,
  }) : super(key: key);

  final String region;
  final VehicleItem vehicleItem;

  @override
  State<VehicleDetailsTag> createState() => _VehicleDetailsTagState();
}

class _VehicleDetailsTagState extends State<VehicleDetailsTag> {
  late VehicleItem vehicleItem;

  @override
  void initState() {
    vehicleItem = widget.vehicleItem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width * .38,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocBuilder<VehicleInfoBloc, VehicleInfoState>(
              builder: (BuildContext context, VehicleInfoState state) {
            if (state is UpdateMileageLoadingState) {
              return Center(child: const CircularProgressIndicator());
            } else if (state is UpdateMileageSuccessState) {
              vehicleItem = state.vehicleItem;
            }
            return InfoItemWithSpacing(
              name: 'Mileage:',
              info: vehicleItem.miles!,
              isClickable: true,
              space: 5,
              modalWidget: AddMileageModalBody(vehicleItem: vehicleItem),
            );
          }),
          InfoItemWithSpacing(
            name: 'Region:',
            info: widget.region,
            isClickable: true,
            space: 5,
            modalWidget: AddRegionModalBody(),
          ),
          InfoItemWithSpacing(
            name: 'Condition:',
            info: 'Average',
            isClickable: true,
            infoColor: Colors.orange,
            space: 5,
            modalWidget: AddConditionModalBody(),
          ),
        ],
      ),
    );
  }
}
