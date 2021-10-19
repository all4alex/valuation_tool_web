import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valuation_tool_web/services/storage/vehicle_storage_service.dart';

import 'upload_image_state.dart';

class UploadImageBloc extends Cubit<UploadImageState> {
  UploadImageBloc() : super(UploadImageInitialState());

  VehicleStorageService _vehicleStorageService = VehicleStorageService();

  void uploadImage(
      {required Uint8List imageByte, required String fileName}) async {
    emit(UploadImageLoadingState());
    try {
      String imageUrl = await _vehicleStorageService.uploadVehicleImage(
          imageByte: imageByte, fileName: fileName);
      emit(UploadImageSuccessState(imageUrl: imageUrl));
    } catch (e) {
      emit(UploadImageFailedState(error: e.toString()));
    }
  }

  // void getVehicleListPerFolder({required String folderName}) async {
  //   emit(UploadImageLoadingState());
  //   try {
  //     List<VehicleItem> vehicleItemList = await _firestoreVehicleService
  //         .getVehiclesPerFolder(folderName: folderName);
  //     emit(UploadImageSuccessState(imageUrl: 'ads'));
  //   } catch (e) {
  //     emit(UploadImageFailedState(error: e.toString()));
  //   }
  // }
}
