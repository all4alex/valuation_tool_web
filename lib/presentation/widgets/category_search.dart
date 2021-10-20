import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valuation_tool_web/bloc/category_search/category_search_bloc.dart';
import 'package:valuation_tool_web/bloc/category_search/category_search_state.dart';
import 'package:valuation_tool_web/models/blackbook/style_list.dart';
import 'package:valuation_tool_web/models/blackbook/vehicle_by_make_response.dart';

import 'custom_dropdown.dart';

class CategorySearch extends StatefulWidget {
  CategorySearch({required this.onFilledUp});
  final Function(String uvc) onFilledUp;
  @override
  State<CategorySearch> createState() => _CategorySearchState();
}

class _CategorySearchState extends State<CategorySearch> {
  late CategorySearchBloc categorySearchBloc;
  String year = '';
  String make = '';
  String model = '';
  String series = '';
  String style = '';

  List<String?> makeList = <String>[];
  List<String?> modelList = <String>[];
  List<String?> seriesList = <String>[];
  List<StyleList?> styleList = <StyleList>[];
  VehicleByMakeResponse vehicleByMakeResponse = VehicleByMakeResponse();

  @override
  void initState() {
    categorySearchBloc = BlocProvider.of<CategorySearchBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDropdown(
          hint: 'Please select a year',
          items: generateListOfYear(),
          onChanged: (String? val) {
            if (val!.isNotEmpty) {
              year = val;
              categorySearchBloc.getMakeByYear(year: val);
            }
          },
        ),
        const SizedBox(height: 5),
        BlocBuilder<CategorySearchBloc, CategorySearchState>(
            builder: (BuildContext context, CategorySearchState state) {
          if (state is GetMakeByYearLoadingState) {
            return CircularProgressIndicator();
          }
          if (state is GetMakeByYearSuccessState) {
            makeList = state.makeByYearResponse.drilldown!.classList![0]
                .yearList![0].makeList!
                .map((e) => e.name)
                .toList();
          }
          if (state is GetMakeByYearFailedState) {
            return Text(state.error);
          }

          return Column(
            children: [
              CustomDropdown(
                hint: 'Please select a make',
                items: makeList,
                onChanged: (String? val) {
                  if (val!.isNotEmpty) {
                    make = val;
                    categorySearchBloc.getVehicleByYearAndMake(
                        year: year, make: val);
                  }
                },
              ),
              const SizedBox(height: 5),
              BlocBuilder<CategorySearchBloc, CategorySearchState>(
                  builder: (BuildContext context, CategorySearchState state) {
                if (state is GetVehicleByMakeLoadingState) {
                  return CircularProgressIndicator();
                }
                if (state is GetVehicleByMakeSuccessState) {
                  vehicleByMakeResponse = state.vehicleByMakeResponse;
                  modelList = state.vehicleByMakeResponse.drilldown!
                      .classList![0].yearList![0].makeList![0].modelList!
                      .map((e) => e.name)
                      .toList();
                }
                if (state is GetVehicleByMakeFailedState) {
                  return Text(state.error);
                }
                return Column(
                  children: [
                    CustomDropdown(
                      hint: 'Please select a model',
                      items: modelList,
                      onChanged: (String? val) {
                        if (val!.isNotEmpty) {
                          model = val;
                          categorySearchBloc.getSeriesByModel(
                              vehicleByMakeResponse: vehicleByMakeResponse,
                              selectedModel: model);
                        }
                      },
                    ),
                    const SizedBox(height: 5),
                    BlocBuilder<CategorySearchBloc, CategorySearchState>(
                        builder:
                            (BuildContext context, CategorySearchState state) {
                      print('THE STATE: $state');
                      if (state is GetSeriesByModelLoadingState) {
                        return CircularProgressIndicator();
                      }
                      if (state is GetSeriesByModelSuccessState) {
                        seriesList = state.seriesList;
                      }
                      if (state is GetVehicleByMakeFailedState) {
                        return Text(state.error);
                      }
                      return CustomDropdown(
                        initialVal: null,
                        hint: 'Please select a series',
                        items: seriesList,
                        onChanged: (String? val) {
                          if (val!.isNotEmpty) {
                            series = val;
                            categorySearchBloc.getStyleBySeries(
                                vehicleByMakeResponse: vehicleByMakeResponse,
                                selectedModel: model,
                                selectedSeries: series);
                          }
                        },
                      );
                    }),
                    const SizedBox(height: 5),
                    BlocBuilder<CategorySearchBloc, CategorySearchState>(
                        builder:
                            (BuildContext context, CategorySearchState state) {
                      print('THE STATE: $state');

                      if (state is GetStyleBySeriesLoadingState) {
                        return CircularProgressIndicator();
                      }
                      if (state is GetStyleBySeriesSuccessState) {
                        styleList = state.styleList;
                      }
                      if (state is GetStyleBySeriesFailedState) {
                        return Text(state.error);
                      }
                      return CustomDropdown(
                        initialVal: null,
                        hint: 'Please select a style',
                        items: styleList.map((e) => e!.name).toList(),
                        onChanged: (String? val) {
                          int selectedIndex = styleList
                              .indexWhere((element) => element!.name == val);
                          String? uvc = styleList[selectedIndex]!.uvc;
                          widget.onFilledUp(uvc!);
                        },
                      );
                    }),
                  ],
                );
              }),
            ],
          );
        }),
      ],
    );
  }

  List<String> generateListOfYear() {
    List<String> listOfYears = [];
    for (int i = 2021; i > 1980; i--) {
      listOfYears.add(i.toString());
    }
    return listOfYears;
  }
}
