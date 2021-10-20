import 'series_list.dart';

class ModelList {
  List<SeriesList>? seriesList;
  String? name;

  ModelList({this.seriesList, this.name});

  factory ModelList.fromJson(Map<String, dynamic> json) => ModelList(
        seriesList: (json['series_list'] as List<dynamic>?)
            ?.map((e) => SeriesList.fromJson(e as Map<String, dynamic>))
            .toList(),
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'series_list': seriesList?.map((e) => e.toJson()).toList(),
        'name': name,
      };
}
