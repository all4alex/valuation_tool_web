import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:valuation_tool_web/models/firestore/vehicle_item.dart';
import 'package:valuation_tool_web/models/retail_statistics_response.dart';
import 'package:valuation_tool_web/models/used_vehicle_list.dart';
import 'package:valuation_tool_web/models/used_vehicles.dart';
import 'package:valuation_tool_web/models/vehicle_response.dart';
import 'package:valuation_tool_web/presentation/pages/vehicle_details/view_models/vehicle_highlights_vm.dart';
import 'package:valuation_tool_web/repository/black_book_vehicle_repository.dart';
import 'package:valuation_tool_web/services/firestore/firestore_vehicle_service.dart';

import 'black_book_state.dart';

class BlackBookBloc extends Cubit<BlackBookState> {
  BlackBookBloc({required this.blackBookRepository})
      : super(BlackBookInitialState());

  final BlackBookRepository blackBookRepository;
  FirestoreVehicleService _firestoreVehicleService = FirestoreVehicleService();
  void reInit() {
    emit(BlackBookLoadingState());
  }

  void getVehiclDataByVin(
      {String? vin,
      String? uvc,
      String? mileage,
      bool? isNew,
      String? folderName}) async {
    emit(BlackBookLoadingState());
    try {
      VehicleResponse vehicleResponse;
      RetailStatisticsResponse retailStatisticsResponse;
      String miles = '';
      if (isNew!) {
        miles = mileage!;
      } else {
        miles = await _firestoreVehicleService
            .getVehicleData(vin: vin!, email: 'alex.ayso@valuation.com')
            .then((value) => value.miles!);
      }

      if (vin!.isNotEmpty) {
        vehicleResponse = await blackBookRepository.getVehicleByVin(vin: vin);
        retailStatisticsResponse =
            await blackBookRepository.searchRetailListingByVIN(
                vin: vin,
                mileage: miles,
                zipcode: '84101',
                listingPerPage: '200',
                listingType: 'both');
      } else {
        vehicleResponse = await blackBookRepository.getVehicleByUvc(uvc: uvc!);
        retailStatisticsResponse =
            await blackBookRepository.searchRetailListingsByUVC(
                uvc: uvc,
                mileage: miles,
                zipcode: '84101',
                listingPerPage: '200',
                listingType: 'both');
      }
      List<VehicleHighlightsVM> highlightsList =
          _getVehicleHighlights(retailStatisticsResponse, vehicleResponse);

      UsedVehicles usedVehicleListItem = vehicleResponse.usedVehicles!;
      String year =
          usedVehicleListItem.usedVehicleList![0].modelYear.toString();
      String make = usedVehicleListItem.usedVehicleList![0].make.toString();
      String model = usedVehicleListItem.usedVehicleList![0].model.toString();
      String vehicleName = '$year $make $model';
      //save to firestore
      if (isNew) {
        await _addVehicleToFirestore(
            vehicleResponse,
            vin.isNotEmpty
                ? vin
                : vehicleResponse.usedVehicles!.usedVehicleList![0].vin!,
            miles,
            folderName!);
      }
      VehicleItem vehicleItem = await _firestoreVehicleService.getVehicleData(
          vin: vin.isNotEmpty
              ? vin
              : vehicleResponse.usedVehicles!.usedVehicleList![0].vin!,
          email: 'alex.ayso@valuation.com');

      emit(BlackBookSuccessState(
          vehicleResponse: vehicleResponse,
          vehicleName: vehicleName,
          vehicleItem: vehicleItem,
          highlightsList: highlightsList,
          retailStatisticsResponse: retailStatisticsResponse));
    } on DioError catch (e) {
      print(e.error);
      emit(BlackBookFailedState(error: e.response!.data));
    } catch (e) {
      print('THE ERROR: $e');
      emit(BlackBookFailedState(error: e.toString()));
    }
  }

  Future<bool> _addVehicleToFirestore(VehicleResponse vehicleResponse,
      String vin, String mileage, String folderName) {
    UsedVehicleListItem usedVehicleListItem =
        vehicleResponse.usedVehicles!.usedVehicleList![0];

    String year = usedVehicleListItem.modelYear.toString();
    String make = usedVehicleListItem.make.toString();
    String model = usedVehicleListItem.model.toString();
    String vehicleName = '$year $make $model';

    DateFormat dateFormat = DateFormat('MM-dd-yyyy');
    String currentDateTime = dateFormat.format(DateTime.now()).toString();

    String? subName =
        '${usedVehicleListItem.series} - ${usedVehicleListItem.style}';

    VehicleItem vehicleItem = VehicleItem(
        user: 'alex.ayso@valuation.com',
        addedDate: currentDateTime,
        name: vehicleName,
        subName: subName,
        vin: vin,
        miles: mileage,
        folder: folderName);

    return _firestoreVehicleService.addVehicle(vehicleItem: vehicleItem);
  }
}

List<VehicleHighlightsVM> _getVehicleHighlights(
    RetailStatisticsResponse retailStatisticsResponse,
    VehicleResponse vehicleResponse) {
  List<VehicleHighlightsVM> list = <VehicleHighlightsVM>[];
  final formatCurrency = new NumberFormat.simpleCurrency(decimalDigits: 0);

  list.add(VehicleHighlightsVM(
      isPositive: false, description: 'Error loading CARFAX™ report'));

  double retailPrice = vehicleResponse
      .usedVehicles!.usedVehicleList![0].baseRetailAvg! as double;
  double wholesalePrice =
      vehicleResponse.usedVehicles!.usedVehicleList![0].baseWholeAvg as double;
  double narrowSpread = retailPrice - wholesalePrice;

  String spread = formatCurrency.format(narrowSpread);

  list.add(VehicleHighlightsVM(
      isPositive: true,
      description:
          'Narrow spread between wholesale and retail values: $spread'));
  list.add(VehicleHighlightsVM(
      isPositive: true,
      description:
          'Average mileage: ${retailStatisticsResponse.listingsStatistics!.activeStatistics!.meanMileage}'));
  list.add(VehicleHighlightsVM(
      isPositive: true,
      description:
          'Days to turn: ${retailStatisticsResponse.listingsStatistics!.meanDaysToTurn}'));
  list.add(VehicleHighlightsVM(
      isPositive: true,
      description:
          'Days supply: ${retailStatisticsResponse.listingsStatistics!.marketDaysSupply}'));
  return list;
}
