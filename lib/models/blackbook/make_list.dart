import 'model_list.dart';

class MakeList {
  List<ModelList>? modelList;
  String? name;

  MakeList({this.modelList, this.name});

  factory MakeList.fromJson(Map<String, dynamic> json) => MakeList(
        modelList: (json['model_list'] as List<dynamic>?)
            ?.map((e) => ModelList.fromJson(e as Map<String, dynamic>))
            .toList(),
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'model_list': modelList?.map((e) => e.toJson()).toList(),
        'name': name,
      };
}
