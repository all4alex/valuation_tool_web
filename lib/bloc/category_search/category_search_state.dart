import 'package:equatable/equatable.dart';
import 'package:valuation_tool_web/models/blackbook/make_by_year_response.dart';
import 'package:valuation_tool_web/models/blackbook/style_list.dart';
import 'package:valuation_tool_web/models/blackbook/vehicle_by_make_response.dart';
import 'package:valuation_tool_web/models/firestore/vehicle_item.dart';

abstract class CategorySearchState extends Equatable {}

class CategorySearchInitialState extends CategorySearchState {
  @override
  List<Object> get props => <Object>[];
}

class GetMakeByYearLoadingState extends CategorySearchState {
  @override
  List<Object> get props => <Object>[];
}

class GetMakeByYearSuccessState extends CategorySearchState {
  GetMakeByYearSuccessState({required this.makeByYearResponse});
  final MakeByYearResponse makeByYearResponse;
  @override
  List<Object> get props => <Object>[];
}

class GetMakeByYearFailedState extends CategorySearchState {
  GetMakeByYearFailedState({required this.error});
  final String error;
  @override
  List<Object> get props => <Object>[];
}

class GetVehicleByMakeLoadingState extends CategorySearchState {
  @override
  List<Object> get props => <Object>[];
}

class GetVehicleByMakeSuccessState extends CategorySearchState {
  GetVehicleByMakeSuccessState({required this.vehicleByMakeResponse});
  final VehicleByMakeResponse vehicleByMakeResponse;
  @override
  List<Object> get props => <Object>[];
}

class GetVehicleByMakeFailedState extends CategorySearchState {
  GetVehicleByMakeFailedState({required this.error});
  final String error;
  @override
  List<Object> get props => <Object>[];
}

class GetSeriesByModelLoadingState extends CategorySearchState {
  @override
  List<Object> get props => <Object>[];
}

class GetSeriesByModelSuccessState extends CategorySearchState {
  GetSeriesByModelSuccessState({required this.seriesList});
  final List<String?> seriesList;
  @override
  List<Object> get props => <Object>[];
}

class GetSeriesByModelFailedState extends CategorySearchState {
  GetSeriesByModelFailedState({required this.error});
  final String error;
  @override
  List<Object> get props => <Object>[];
}

class GetStyleBySeriesLoadingState extends CategorySearchState {
  @override
  List<Object> get props => <Object>[];
}

class GetStyleBySeriesSuccessState extends CategorySearchState {
  GetStyleBySeriesSuccessState({required this.styleList});
  final List<StyleList?> styleList;
  @override
  List<Object> get props => <Object>[];
}

class GetStyleBySeriesFailedState extends CategorySearchState {
  GetStyleBySeriesFailedState({required this.error});
  final String error;
  @override
  List<Object> get props => <Object>[];
}
