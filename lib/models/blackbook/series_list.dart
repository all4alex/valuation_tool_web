import 'style_list.dart';

class SeriesList {
  List<StyleList>? styleList;
  String? name;

  SeriesList({this.styleList, this.name});

  factory SeriesList.fromJson(Map<String, dynamic> json) => SeriesList(
        styleList: (json['style_list'] as List<dynamic>?)
            ?.map((e) => StyleList.fromJson(e as Map<String, dynamic>))
            .toList(),
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'style_list': styleList?.map((e) => e.toJson()).toList(),
        'name': name,
      };
}
