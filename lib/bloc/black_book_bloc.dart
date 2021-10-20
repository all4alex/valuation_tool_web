import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:valuation_tool_web/models/firestore/vehicle_item.dart';
import 'package:valuation_tool_web/models/used_vehicle_list.dart';
import 'package:valuation_tool_web/models/used_vehicles.dart';
import 'package:valuation_tool_web/models/vehicle_response.dart';
import 'package:valuation_tool_web/repository/black_book_vehicle_repository.dart';
import 'package:valuation_tool_web/services/firestore/firestore_vehicle_service.dart';

import 'black_book_state.dart';

class BlackBookBloc extends Cubit<BlackBookState> {
  BlackBookBloc({required this.blackBookRepository})
      : super(BlackBookInitialState());

  final BlackBookRepository blackBookRepository;
  FirestoreVehicleService _firestoreVehicleService = FirestoreVehicleService();

  void getVehiclDataByVin({String? vin, String? uvc, String? mileage}) async {
    emit(BlackBookLoadingState());
    try {
      VehicleResponse vehicleResponse;
      print('THE VIN: $vin');
      print('THE VIN: $uvc');

      if (vin!.isNotEmpty) {
        vehicleResponse = await blackBookRepository.getVehicleByVin(vin: vin);
      } else {
        vehicleResponse = await blackBookRepository.getVehicleByUvc(uvc: uvc!);
      }
      print(
          'THE DATA: ${vehicleResponse.usedVehicles!.usedVehicleList![0].msrp}');
      UsedVehicles usedVehicleListItem = vehicleResponse.usedVehicles!;
      String year =
          usedVehicleListItem.usedVehicleList![0].modelYear.toString();
      String make = usedVehicleListItem.usedVehicleList![0].make.toString();
      String model = usedVehicleListItem.usedVehicleList![0].model.toString();
      String vehicleName = '$year $make $model';
      //save to firestore
      if (mileage != null) {
        await _addVehicleToFirestore(
            vehicleResponse,
            vin.isNotEmpty
                ? vin
                : vehicleResponse.usedVehicles!.usedVehicleList![0].vin!,
            mileage);
      }
      VehicleItem vehicleItem = await _firestoreVehicleService.getVehicleData(
          vin.isNotEmpty
              ? vin
              : vehicleResponse.usedVehicles!.usedVehicleList![0].vin!,
          'alex.ayso@valuation.com');

      emit(BlackBookSuccessState(
          vehicleResponse: vehicleResponse,
          vehicleName: vehicleName,
          vehicleItem: vehicleItem));
    } on DioError catch (e) {
      emit(BlackBookFailedState(error: e.response!.data));
    } catch (e) {
      emit(BlackBookFailedState(error: e.toString()));
    }
  }

  Future<bool> _addVehicleToFirestore(
      VehicleResponse vehicleResponse, String vin, String mileage) {
    UsedVehicleListItem usedVehicleListItem =
        vehicleResponse.usedVehicles!.usedVehicleList![0];

    String year = usedVehicleListItem.modelYear.toString();
    String make = usedVehicleListItem.make.toString();
    String model = usedVehicleListItem.model.toString();
    String vehicleName = '$year $make $model';

    DateFormat dateFormat = DateFormat('MM-dd-yyyy');
    String currentDateTime = dateFormat.format(DateTime.now()).toString();

    String? subName =
        '${usedVehicleListItem.series}|${usedVehicleListItem.style}';

    VehicleItem vehicleItem = VehicleItem(
        user: 'alex.ayso@valuation.com',
        addedDate: currentDateTime,
        name: vehicleName,
        subName: subName,
        vin: vin,
        miles: mileage,
        folder: 'Add to folder');

    return _firestoreVehicleService.addVehicle(vehicleItem: vehicleItem);
  }
}
