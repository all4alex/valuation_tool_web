import 'package:equatable/equatable.dart';
import 'package:valuation_tool_web/models/vehicle_response.dart';

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
  BlackBookSuccessState({required this.vehicleResponse});
  final VehicleResponse vehicleResponse;
  @override
  List<Object> get props => <Object>[];
}

class BlackBookFailedState extends BlackBookState {
  BlackBookFailedState({required this.error});
  final String error;
  @override
  List<Object> get props => <Object>[];
}
