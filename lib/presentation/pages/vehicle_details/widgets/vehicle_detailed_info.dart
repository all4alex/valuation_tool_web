import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valuation_tool_web/bloc/vehicle_info/vehicle_info_bloc.dart';
import 'package:valuation_tool_web/bloc/vehicle_info/vehicle_info_state.dart';
import 'package:valuation_tool_web/models/firestore/vehicle_item.dart';
import 'package:valuation_tool_web/models/used_vehicle_list.dart';
import 'package:valuation_tool_web/presentation/widgets/add_auction_modal_body.dart';
import 'package:valuation_tool_web/presentation/widgets/add_run_number_modal_body.dart';
import 'package:valuation_tool_web/presentation/widgets/info_item_with_spacing.dart';

class VehicleDetailedInfo extends StatelessWidget {
  VehicleDetailedInfo(
      {required this.usedVehicleListItem, required this.vehicleItem});
  final UsedVehicleListItem usedVehicleListItem;
  final VehicleItem vehicleItem;
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
              Divider(),
              SizedBox(height: 5),
              Info(
                  usedVehicleListItem: usedVehicleListItem,
                  vehicleItem: vehicleItem),
              SizedBox(height: 30),
              CarfaxButton(),
              const SizedBox(height: 10),
            ]));
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

class Info extends StatefulWidget {
  Info({Key? key, required this.usedVehicleListItem, required this.vehicleItem})
      : super(key: key);

  final UsedVehicleListItem usedVehicleListItem;
  final VehicleItem vehicleItem;

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  late VehicleItem vehicleItem;
  late VehicleInfoBloc vehicleInfoBloc;

  @override
  void initState() {
    vehicleInfoBloc = BlocProvider.of<VehicleInfoBloc>(context);
    vehicleItem = widget.vehicleItem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            InfoItemWithSpacing(
                name: 'Style:', info: '${widget.usedVehicleListItem.style}'),
            InfoItemWithSpacing(
                name: 'Fuel Type:',
                info: '${widget.usedVehicleListItem.fuelType}'),
            BlocBuilder<VehicleInfoBloc, VehicleInfoState>(
                builder: (BuildContext context, VehicleInfoState state) {
              if (state is UpdateRunNumberLoadingState) {
                return InfoItemWithSpacing(
                  name: 'Run Number:',
                  infoWidget: SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator()),
                  isClickable: true,
                  modalWidget: AddRunNumberModalBody(
                    vehicleItem: vehicleItem,
                  ),
                );
              } else if (state is UpdateRunNumberSuccessState) {
                vehicleItem = state.vehicleItem;
              }
              return InfoItemWithSpacing(
                name: 'Run Number:',
                info: vehicleItem.runNumber ?? 'Add',
                isClickable: true,
                modalWidget: AddRunNumberModalBody(
                  vehicleItem: vehicleItem,
                ),
              );
            }),
            // Container(
            //     width: 150,
            //     child: InfoItemWithSpacing(
            //         name: 'Mileage:', info: '$mileage', isClickable: true)),
          ]),
        ),
        Expanded(
          flex: 1,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            InfoItemWithSpacing(
                name: 'Drive Train:',
                info: '${widget.usedVehicleListItem.drivetrain}'),
            InfoItemWithSpacing(name: 'Location:', info: 'Lehi, UT'),
            BlocBuilder<VehicleInfoBloc, VehicleInfoState>(
                builder: (BuildContext context, VehicleInfoState state) {
              if (state is UpdateAuctionLoadingState) {
                return InfoItemWithSpacing(
                  name: 'Auction:',
                  infoWidget: SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator()),
                  isClickable: true,
                  modalWidget: AddAuctionModalBody(
                    vehicleItem: vehicleItem,
                  ),
                );
              } else if (state is UpdateAuctionSuccessState) {
                vehicleItem = state.vehicleItem;
              }
              return InfoItemWithSpacing(
                name: 'Auction:',
                info: vehicleItem.auction ?? 'Add',
                isClickable: true,
                modalWidget: AddAuctionModalBody(
                  vehicleItem: vehicleItem,
                ),
              );
            }),
            // Container(
            //     width: 150,
            //     child: InfoItemWithSpacing(
            //         name: 'Region:', info: 'Utah', isClickable: true)),
          ]),
        ),
      ],
    );
  }
}
