import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valuation_tool_web/bloc/folder/folder_dialog/folder_dialog_state.dart';
import 'package:valuation_tool_web/models/firestore/folder_item.dart';
import 'package:valuation_tool_web/services/firestore/firestore_folder_service.dart';
import 'package:valuation_tool_web/services/firestore/firestore_vehicle_service.dart';

class FolderDialogBloc extends Cubit<FolderDialogState> {
  FolderDialogBloc() : super(FolderDialogInitialState());

  FirestoreFolderService _firestoreFolderService = FirestoreFolderService();
  FirestoreVehicleService _firestoreVehicleService = FirestoreVehicleService();

  void getAllFolderFromDialog() async {
    emit(GetFoldersDialogLoadingState());
    try {
      List<FolderItem> list = await _firestoreFolderService.getAllFolders(
          email: 'alex.ayso@valuation.com');
      List<FolderItem> updatedList = <FolderItem>[];
      for (FolderItem item in list) {
        item.folderCount = await _firestoreVehicleService.getFolderCount(
            folderName: item.folderName.toString());
        updatedList.add(item);
      }

      emit(GetFoldersDialogSuccessState(list: updatedList));
    } catch (e) {
      emit(GetFoldersDialogFailedState(error: e.toString()));
    }
  }
}
