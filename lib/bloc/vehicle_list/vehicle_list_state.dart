import 'package:equatable/equatable.dart';
import 'package:valuation_tool_web/models/firestore/vehicle_item.dart';
import 'package:valuation_tool_web/models/vehicle_response.dart';

abstract class VehicleListState extends Equatable {}

class VehicleListInitialState extends VehicleListState {
  @override
  List<Object> get props => <Object>[];
}

class VehicleListLoadingState extends VehicleListState {
  @override
  List<Object> get props => <Object>[];
}

class VehicleListSuccessState extends VehicleListState {
  VehicleListSuccessState({required this.list});
  final List<VehicleItem> list;
  @override
  List<Object> get props => <Object>[];
}

class VehicleListFailedState extends VehicleListState {
  VehicleListFailedState({required this.error});
  final String error;
  @override
  List<Object> get props => <Object>[];
}
