import 'year_list.dart';

class ClassList {
  String? classCode;
  List<YearList>? yearList;
  String? name;

  ClassList({this.classCode, this.yearList, this.name});

  factory ClassList.fromJson(Map<String, dynamic> json) => ClassList(
        classCode: json['class_code'] as String?,
        yearList: (json['year_list'] as List<dynamic>?)
            ?.map((e) => YearList.fromJson(e as Map<String, dynamic>))
            .toList(),
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'class_code': classCode,
        'year_list': yearList?.map((e) => e.toJson()).toList(),
        'name': name,
      };
}
