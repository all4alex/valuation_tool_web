import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valuation_tool_web/models/firestore/folder_item.dart';
import 'package:valuation_tool_web/models/firestore/vehicle_item.dart';
import 'package:valuation_tool_web/services/firestore/firestore_folder_service.dart';
import 'package:valuation_tool_web/services/firestore/firestore_vehicle_service.dart';

import 'folder_state.dart';

class FolderBloc extends Cubit<FolderState> {
  FolderBloc() : super(FolderInitialState());

  FirestoreFolderService _firestoreFolderService = FirestoreFolderService();
  FirestoreVehicleService _firestoreVehicleService = FirestoreVehicleService();

  void getAllFolder() async {
    emit(GetFoldersLoadingState());
    try {
      List<FolderItem> list = await _firestoreFolderService.getAllFolders(
          email: 'alex.ayso@valuation.com');
      List<FolderItem> updatedList = <FolderItem>[];
      for (FolderItem item in list) {
        item.folderCount = await _firestoreVehicleService.getFolderCount(
            folderName: item.folderName.toString());
        updatedList.add(item);
      }

      emit(GetFoldersSuccessState(list: updatedList));
    } catch (e) {
      emit(GetFoldersFailedState(error: e.toString()));
    }
  }

  void getAllFolderFromDialog() async {
    emit(GetFoldersFromDialogLoadingState());
    try {
      List<FolderItem> list = await _firestoreFolderService.getAllFolders(
          email: 'alex.ayso@valuation.com');
      List<FolderItem> updatedList = <FolderItem>[];
      for (FolderItem item in list) {
        item.folderCount = await _firestoreVehicleService.getFolderCount(
            folderName: item.folderName.toString());
        updatedList.add(item);
      }

      emit(GetFoldersFromDialogSuccessState(list: updatedList));
    } catch (e) {
      emit(GetFoldersFromDialogFailedState(error: e.toString()));
    }
  }

  void addFolder({required FolderItem folderItem}) async {
    emit(AddFolderLoadingState());
    try {
      bool success =
          await _firestoreFolderService.addFolder(folderItem: folderItem);
      if (success) {
        this.getAllFolder();
      }
    } catch (e) {
      emit(AddFolderFailedState(error: e.toString()));
    }
  }

  void deleteFolder(
      {required FolderItem folderItem,
      required List<VehicleItem> vehicleItemList}) async {
    emit(DeleteFolderLoadingState());
    try {
      bool success =
          await _firestoreFolderService.deleteFolder(folderItem: folderItem);
      for (VehicleItem item in vehicleItemList) {
        await _firestoreVehicleService.updateFolder(
            folderName: 'Add to folder', id: item.id!);
      }
      if (success) {
        emit(DeleteFolderSuccessState());
      } else {
        emit(DeleteFolderFailedState(error: 'Delete folder failed'));
      }
    } catch (e) {
      emit(DeleteFolderFailedState(error: e.toString()));
    }
  }
}
