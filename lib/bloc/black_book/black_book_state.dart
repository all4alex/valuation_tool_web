import 'package:equatable/equatable.dart';
import 'package:valuation_tool_web/models/firestore/vehicle_item.dart';
import 'package:valuation_tool_web/models/vehicle_response.dart';
import 'package:valuation_tool_web/presentation/pages/vehicle_details/view_models/vehicle_highlights_vm.dart';

abstract class BlackBookState extends Equatable {}

class BlackBookInitialState extends BlackBookState {
  @override
  List<Object> get props => <Object>[];
}

class BlackBookLoadingState extends BlackBookState {
  @override
  List<Object> get props => <Object>[];
}

class BlackBookSuccessState extends BlackBookState {
  BlackBookSuccessState(
      {required this.vehicleResponse,
      required this.vehicleName,
      required this.vehicleItem,
      required this.highlightsList});
  final VehicleResponse vehicleResponse;
  final String vehicleName;
  final VehicleItem vehicleItem;
  final List<VehicleHighlightsVM> highlightsList;
  @override
  List<Object> get props => <Object>[];
}

class BlackBookFailedState extends BlackBookState {
  BlackBookFailedState({required this.error});
  final String error;
  @override
  List<Object> get props => <Object>[];
}
