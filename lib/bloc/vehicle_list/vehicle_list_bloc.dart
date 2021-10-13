import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valuation_tool_web/models/firestore/vehicle_item.dart';
import 'package:valuation_tool_web/services/firestore/firestore_vehicle_service.dart';

import 'vehicle_list_state.dart';

class VehicleListBloc extends Cubit<VehicleListState> {
  VehicleListBloc() : super(VehicleListInitialState());

  FirestoreVehicleService _firestoreVehicleService = FirestoreVehicleService();

  void getVehicleList() async {
    emit(VehicleListLoadingState());
    try {
      List<VehicleItem> vehicleItemList = await _firestoreVehicleService
          .getAllVehicles(email: 'alex.ayso@valuation.com');
      emit(VehicleListSuccessState(list: vehicleItemList));
    } catch (e) {
      emit(VehicleListFailedState(error: e.toString()));
    }
  }
}
