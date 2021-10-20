import 'make_list.dart';

class YearList {
  List<MakeList>? makeList;
  String? name;

  YearList({this.makeList, this.name});

  factory YearList.fromJson(Map<String, dynamic> json) => YearList(
        makeList: (json['make_list'] as List<dynamic>?)
            ?.map((e) => MakeList.fromJson(e as Map<String, dynamic>))
            .toList(),
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'make_list': makeList?.map((e) => e.toJson()).toList(),
        'name': name,
      };
}
