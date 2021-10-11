// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valuation_tool_web/models/vehicle_response.dart';
import 'package:valuation_tool_web/repository/black_book_vehicle_repository.dart';

import 'black_book_state.dart';

class BlackBookBloc extends Cubit<BlackBookState> {
  BlackBookBloc({required this.blackBookRepository})
      : super(BlackBookInitialState());

  final BlackBookRepository blackBookRepository;

  void getVehiclDataByVin({required String vin}) async {
    emit(BlackBookLoadingState());
    try {
      VehicleResponse vehicleResponse =
          await blackBookRepository.getVehicleByVin(vin: vin);
      print(
          'THE DATA: ${vehicleResponse.usedVehicles!.usedVehicleList![0].msrp}');

      emit(BlackBookSuccessState(vehicleResponse: vehicleResponse));
    } on DioError catch (e) {
      emit(BlackBookFailedState(error: e.response!.data));
    } catch (e) {
      emit(BlackBookFailedState(error: e.toString()));
    }
  }
}
