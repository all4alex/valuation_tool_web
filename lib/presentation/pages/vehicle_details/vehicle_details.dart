import 'dart:html';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:valuation_tool_web/bloc/black_book/black_book_bloc.dart';
import 'package:valuation_tool_web/bloc/black_book/black_book_state.dart';
import 'package:valuation_tool_web/bloc/folder/folder_bloc.dart';
import 'package:valuation_tool_web/bloc/folder/folder_state.dart';
import 'package:valuation_tool_web/bloc/upload_image/upload_image_bloc.dart';
import 'package:valuation_tool_web/bloc/upload_image/upload_image_state.dart';
import 'package:valuation_tool_web/bloc/vehicle_list/vehicle_list_bloc.dart';
import 'package:valuation_tool_web/models/add_deduct_list.dart';
import 'package:valuation_tool_web/models/firestore/vehicle_item.dart';
import 'package:valuation_tool_web/models/used_vehicle_list.dart';
import 'package:valuation_tool_web/models/used_vehicles.dart';
import 'package:valuation_tool_web/presentation/pages/vehicle_details/widgets/retail_and_profit.dart';
import 'package:valuation_tool_web/presentation/pages/vehicle_details/widgets/vehicle_activity.dart';
import 'package:valuation_tool_web/presentation/pages/vehicle_details/widgets/vehicle_notes.dart';
import 'package:valuation_tool_web/presentation/widgets/add_condition_modal_body.dart';
import 'package:valuation_tool_web/presentation/widgets/add_mileage_modal_body.dart';
import 'package:valuation_tool_web/presentation/widgets/add_region_modal_body.dart';

import 'package:valuation_tool_web/presentation/widgets/blackbook/black_book_retail_data.dart';
import 'package:valuation_tool_web/presentation/widgets/blackbook/black_book_trade_in_data.dart';
import 'package:valuation_tool_web/presentation/widgets/blackbook/black_book_wholesale_data.dart';
import 'package:valuation_tool_web/presentation/widgets/info_item_with_spacing.dart';
import 'package:valuation_tool_web/presentation/widgets/page_view.dart';
import 'package:valuation_tool_web/presentation/widgets/select_folder_dialog_body.dart';
import 'package:valuation_tool_web/services/firestore/firestore_vehicle_service.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'widgets/blackbook_values.dart';
import 'widgets/vehicle_basic_info.dart';
import 'widgets/vehicle_detailed_info.dart';
import 'widgets/vehicle_details_actions.dart';
import 'widgets/vehicle_details_tag.dart';
import 'widgets/vehicle_highlights_overview.dart';
import 'widgets/vehicle_price_overview.dart';

enum VehicleQuality { rough, average, clean }

class VehicleDetailsArgs {
  VehicleDetailsArgs(
      {this.mileage, this.vin, this.uvc, this.isNew, this.folderName});
  final String? mileage;
  final String? vin;
  final String? uvc;
  final bool? isNew;
  final String? folderName;
}

class VehicleDetails extends StatefulWidget {
  const VehicleDetails({required this.onAddSuccess});
  final Function onAddSuccess;

  @override
  State<VehicleDetails> createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  late BlackBookBloc blackBookBloc;
  late VehicleDetailsArgs args = VehicleDetailsArgs();
  late FolderBloc folderBloc;
  late UploadImageBloc uploadImageBloc;

  String text = '';

  late VehicleItem vehicleItem = VehicleItem();
  @override
  void initState() {
    blackBookBloc = BlocProvider.of<BlackBookBloc>(context);
    uploadImageBloc = BlocProvider.of<UploadImageBloc>(context);
    blackBookBloc.reInit();
    Future.delayed(Duration.zero, () {
      // args = ModalRoute.of(context)!.settings.arguments as VehicleDetailsArgs;

      //uncomment bellow line if working/testing on vehicle details page
      args = VehicleDetailsArgs(
          vin: 'JM1GL1VM5M1607776', uvc: null, mileage: null, isNew: false);

      print('THE MILEAGE: ${args.mileage}');
      blackBookBloc.getVehiclDataByVin(
          vin: args.vin,
          uvc: args.uvc,
          mileage: args.mileage,
          isNew: args.isNew,
          folderName: args.folderName);
      folderBloc = BlocProvider.of<FolderBloc>(context);
    });

    super.initState();
  }

  TextStyle roboto = GoogleFonts.roboto();
  final ButtonStyle buttonStyle =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  final ButtonStyle buttonStyle2 = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), primary: Colors.green);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      height: screenSize.height,
      alignment: Alignment.center,
      child: BlocListener<BlackBookBloc, BlackBookState>(
          listener: (BuildContext context, BlackBookState state) {
        if (state is BlackBookLoadingState) {
        } else if (state is BlackBookSuccessState) {
          widget.onAddSuccess();
        } else if (state is BlackBookFailedState) {
          print('THE error: ${state.error}');
        }
      }, child: SingleChildScrollView(
        child: BlocBuilder<BlackBookBloc, BlackBookState>(
            builder: (BuildContext context, BlackBookState state) {
          if (state is BlackBookLoadingState ||
              state is BlackBookInitialState) {
            return Center(child: const CircularProgressIndicator());
          } else if (state is BlackBookSuccessState) {
            UsedVehicleListItem usedVehicleListItem =
                state.vehicleResponse.usedVehicles!.usedVehicleList![0];
            String driveTrain = usedVehicleListItem.drivetrain.toString();
            String transmission = usedVehicleListItem.transmission.toString();
            String year = usedVehicleListItem.modelYear.toString();
            String make = usedVehicleListItem.make.toString();
            String model = usedVehicleListItem.model.toString();
            String location =
                '${usedVehicleListItem.country}, ${usedVehicleListItem.state}';
            String style = usedVehicleListItem.style.toString();
            String fuelType = usedVehicleListItem.fuelType.toString();
            String folderName = state.vehicleItem.folder!;
            vehicleItem = state.vehicleItem;
            return Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VehicleBasicInfo(
                        imageUrl: state.vehicleItem.imageUrl ?? '',
                        title: '$year $make $model',
                        subTitle:
                            '${usedVehicleListItem.series} - ${usedVehicleListItem.style}',
                        vin: state.vehicleItem.vin!,
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          VehiclePriceOverview(
                            backgroundColor: Color(0xff36334E),
                            title: 'Wholesale Overview',
                            price: usedVehicleListItem.baseWholeAvg!,
                            minPrice: usedVehicleListItem.baseWholeRough!,
                            maxPrice: usedVehicleListItem.baseWholeClean!,
                          ),
                          const SizedBox(width: 15),
                          VehiclePriceOverview(
                            backgroundColor: Color(0xff4EAC12),
                            title: 'Retail Overview',
                            price: usedVehicleListItem.baseRetailAvg!,
                            minPrice: usedVehicleListItem.baseRetailRough!,
                            maxPrice: usedVehicleListItem.baseRetailClean!,
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      VehicleHighlightsOverview(
                          highlightsList: state.highlightsList),
                      const SizedBox(height: 15),
                      VehicleDetailedInfo(
                          usedVehicleListItem: usedVehicleListItem,
                          vehicleItem: state.vehicleItem),
                      const SizedBox(height: 15),
                      VehicleNotes(
                          email: 'alex.ayso@valuation.com',
                          name: '$year $make $model',
                          vin: state.vehicleItem.vin!),
                      const SizedBox(height: 15),
                      VehicleActivity(
                        email: 'alex.ayso@valuation.com',
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      VehicleDetailsActions(
                        folderName: folderName,
                        vehicleItem: vehicleItem,
                      ),
                      // VehicleDetailsTag(
                      //   regions: 'Utah',
                      //   mileage: state.vehicleItem.miles!,
                      //   condition: 'Average',
                      // ),
                      VehicleDetailsTag(
                        region: 'Utah',
                        vehicleItem: vehicleItem,
                      ),

                      const SizedBox(height: 10),
                      RetailAndProfit(
                        usedVehicleListItem: usedVehicleListItem,
                        retailStatisticsResponse:
                            state.retailStatisticsResponse,
                        vehicleName: '$year $make $model',
                      ),
                      BlackBookValues(
                        title: '$year $make $model',
                        usedVehicles: state.vehicleResponse.usedVehicles!,
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Center(child: const Text('Unable to get vehicle data'));
          }
        }),
      )),
    );
  }
}
