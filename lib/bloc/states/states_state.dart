import 'package:equatable/equatable.dart';
import 'package:valuation_tool_web/models/blackbook/state_response.dart';

abstract class StatesState extends Equatable {}

class StatesInitialState extends StatesState {
  @override
  List<Object> get props => <Object>[];
}

class GetStatesLoadingState extends StatesState {
  @override
  List<Object> get props => <Object>[];
}

class GetStatesSuccessState extends StatesState {
  GetStatesSuccessState({required this.stateList});
  final List<StateList>? stateList;
  @override
  List<Object> get props => <Object>[];
}

class GetStatesFailedState extends StatesState {
  GetStatesFailedState({required this.error});
  final String error;
  @override
  List<Object> get props => <Object>[];
}
