import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valuation_tool_web/models/firestore/folder_item.dart';
import 'package:valuation_tool_web/models/firestore/vehicle_item.dart';
import 'package:valuation_tool_web/services/firestore/firestore_folder_service.dart';
import 'package:valuation_tool_web/services/firestore/firestore_vehicle_service.dart';

import 'vehicle_list_state.dart';

class VehicleListBloc extends Cubit<VehicleListState> {
  VehicleListBloc() : super(VehicleListInitialState());

  FirestoreVehicleService _firestoreVehicleService = FirestoreVehicleService();
  FirestoreFolderService firestoreFolderService = FirestoreFolderService();

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

  void getVehicleListPerFolder({required String folderName}) async {
    emit(VehicleListLoadingState());
    try {
      List<VehicleItem> vehicleItemList = await _firestoreVehicleService
          .getVehiclesPerFolder(folderName: folderName);
      FolderItem folderItem =
          await firestoreFolderService.getFolderData(folderName: folderName);

      emit(VehicleListSuccessState(
          list: vehicleItemList, folderItem: folderItem));
    } catch (e) {
      emit(VehicleListFailedState(error: e.toString()));
    }
  }
}
