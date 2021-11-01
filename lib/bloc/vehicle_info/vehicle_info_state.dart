import 'package:equatable/equatable.dart';
import 'package:valuation_tool_web/models/firestore/vehicle_item.dart';

abstract class VehicleInfoState extends Equatable {}

class VehicleInfoInitialState extends VehicleInfoState {
  @override
  List<Object> get props => <Object>[];
}

class UpdateRunNumberLoadingState extends VehicleInfoState {
  @override
  List<Object> get props => <Object>[];
}

class UpdateRunNumberSuccessState extends VehicleInfoState {
  UpdateRunNumberSuccessState({required this.vehicleItem});
  final VehicleItem vehicleItem;
  @override
  List<Object> get props => <Object>[];
}

class UpdateRunNumberFailedState extends VehicleInfoState {
  UpdateRunNumberFailedState({required this.error});
  final String error;
  @override
  List<Object> get props => <Object>[];
}

class UpdateAuctionLoadingState extends VehicleInfoState {
  @override
  List<Object> get props => <Object>[];
}

class UpdateAuctionSuccessState extends VehicleInfoState {
  UpdateAuctionSuccessState({required this.vehicleItem});
  final VehicleItem vehicleItem;
  @override
  List<Object> get props => <Object>[];
}

class UpdateAuctionFailedState extends VehicleInfoState {
  UpdateAuctionFailedState({required this.error});
  final String error;
  @override
  List<Object> get props => <Object>[];
}

class UpdateMileageLoadingState extends VehicleInfoState {
  @override
  List<Object> get props => <Object>[];
}

class UpdateMileageSuccessState extends VehicleInfoState {
  UpdateMileageSuccessState({required this.vehicleItem});
  final VehicleItem vehicleItem;
  @override
  List<Object> get props => <Object>[];
}

class UpdateMileageFailedState extends VehicleInfoState {
  UpdateMileageFailedState({required this.error});
  final String error;
  @override
  List<Object> get props => <Object>[];
}
