import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valuation_tool_web/models/blackbook/make_by_year_response.dart';
import 'package:valuation_tool_web/models/blackbook/style_list.dart';
import 'package:valuation_tool_web/models/blackbook/vehicle_by_make_response.dart';
import 'package:valuation_tool_web/repository/black_book_vehicle_repository.dart';

import 'category_search_state.dart';

class CategorySearchBloc extends Cubit<CategorySearchState> {
  CategorySearchBloc({required this.blackBookRepository})
      : super(CategorySearchInitialState());

  final BlackBookRepository blackBookRepository;

  void getMakeByYear({required String year}) async {
    emit(GetMakeByYearLoadingState());
    try {
      MakeByYearResponse makeByYearResponse =
          await blackBookRepository.findModelsByYear(year: year);
      emit(GetMakeByYearSuccessState(makeByYearResponse: makeByYearResponse));
    } catch (e) {
      emit(GetMakeByYearFailedState(error: e.toString()));
    }
  }

  void getVehicleByYearAndMake(
      {required String make, required String year}) async {
    emit(GetVehicleByMakeLoadingState());
    try {
      VehicleByMakeResponse vehicleByMakeResponse =
          await blackBookRepository.findVehicleByMake(make: make, year: year);
      emit(GetVehicleByMakeSuccessState(
          vehicleByMakeResponse: vehicleByMakeResponse));
    } catch (e) {
      emit(GetVehicleByMakeFailedState(error: e.toString()));
    }
  }

  void getSeriesByModel(
      {required VehicleByMakeResponse vehicleByMakeResponse,
      required String selectedModel}) async {
    emit(GetSeriesByModelLoadingState());
    try {
      int index = vehicleByMakeResponse
          .drilldown!.classList![0].yearList![0].makeList![0].modelList!
          .indexWhere((element) => element.name == selectedModel);

      List<String?> list = vehicleByMakeResponse.drilldown!.classList![0]
          .yearList![0].makeList![0].modelList![index].seriesList!
          .map((e) => e.name)
          .toList();

      emit(GetSeriesByModelSuccessState(seriesList: list));
    } catch (e) {
      emit(GetSeriesByModelFailedState(error: e.toString()));
    }
  }

  void getStyleBySeries(
      {required VehicleByMakeResponse vehicleByMakeResponse,
      required String selectedModel,
      required String selectedSeries}) async {
    emit(GetStyleBySeriesLoadingState());
    try {
      int index = vehicleByMakeResponse
          .drilldown!.classList![0].yearList![0].makeList![0].modelList!
          .indexWhere((element) => element.name == selectedModel);
      int index2 = vehicleByMakeResponse.drilldown!.classList![0].yearList![0]
          .makeList![0].modelList![index].seriesList!
          .indexWhere((element) => element.name == selectedSeries);
      List<StyleList?> list = vehicleByMakeResponse
          .drilldown!
          .classList![0]
          .yearList![0]
          .makeList![0]
          .modelList![index]
          .seriesList![index2]
          .styleList!;

      emit(GetStyleBySeriesSuccessState(styleList: list));
    } catch (e) {
      emit(GetStyleBySeriesFailedState(error: e.toString()));
    }
  }
}
