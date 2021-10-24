import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:valuation_tool_web/services/firestore/firestore_vehicle_service.dart';

import 'add_to_folder_state.dart';

class AddToFolderBloc extends Cubit<AddToFolderState> {
  AddToFolderBloc() : super(AddToFolderInitialState());

  FirestoreVehicleService _firestoreVehicleService = FirestoreVehicleService();

  void addToFolder({required String folderName, required String id}) async {
    emit(AddToFolderLoadingState());
    try {
      await _firestoreVehicleService.updateFolder(
          folderName: folderName, id: id);
      emit(AddToFolderSuccessState(folderName: folderName));
    } catch (e) {
      print('THE FOLDER $e');
      emit(AddToFolderFailedState(error: e.toString()));
    }
  }
}
