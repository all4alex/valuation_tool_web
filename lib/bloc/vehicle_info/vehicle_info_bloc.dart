import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valuation_tool_web/models/firestore/vehicle_item.dart';
import 'package:valuation_tool_web/services/firestore/firestore_vehicle_service.dart';

import 'vehicle_info_state.dart';

class VehicleInfoBloc extends Cubit<VehicleInfoState> {
  VehicleInfoBloc() : super(VehicleInfoInitialState());

  FirestoreVehicleService _firestoreVehicleService = FirestoreVehicleService();

  void updateRunNumber({required VehicleItem vehicleItem}) async {
    emit(UpdateRunNumberLoadingState());
    try {
      bool success = await _firestoreVehicleService.updateVehicle(
          vehicleItem: vehicleItem);
      if (success) {
        emit(UpdateRunNumberSuccessState(vehicleItem: vehicleItem));
      }
    } catch (e) {
      emit(UpdateRunNumberFailedState(error: e.toString()));
    }
  }

  void updateAuction({required VehicleItem vehicleItem}) async {
    emit(UpdateAuctionLoadingState());
    try {
      bool success = await _firestoreVehicleService.updateVehicle(
          vehicleItem: vehicleItem);
      if (success) {
        emit(UpdateAuctionSuccessState(vehicleItem: vehicleItem));
      }
    } catch (e) {
      emit(UpdateAuctionFailedState(error: e.toString()));
    }
  }

  void updateMileage({required VehicleItem vehicleItem}) async {
    emit(UpdateMileageLoadingState());
    try {
      bool success = await _firestoreVehicleService.updateVehicle(
          vehicleItem: vehicleItem);
      if (success) {
        emit(UpdateMileageSuccessState(vehicleItem: vehicleItem));
      }
    } catch (e) {
      emit(UpdateMileageFailedState(error: e.toString()));
    }
  }
}
