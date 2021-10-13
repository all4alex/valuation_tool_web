import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valuation_tool_web/models/firestore/folder_item.dart';
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
        List itemList = await _firestoreVehicleService.getVehiclesPerFolder(
            folderName: item.folderName.toString());
        item.folderCount = itemList.length;
        updatedList.add(item);
      }

      emit(GetFoldersSuccessState(list: updatedList));
    } catch (e) {
      emit(GetFoldersFailedState(error: e.toString()));
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

  void addToFolder({required String folderName, required String id}) async {
    emit(AddToFolderLoadingState());
    try {
      await _firestoreVehicleService.updateFolder(
          folderName: folderName, id: id);
      emit(AddToFolderSuccessState(folderName: folderName));
    } catch (e) {
      emit(AddToFolderFailedState(error: e.toString()));
    }
  }
}
