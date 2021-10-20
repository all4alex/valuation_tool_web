import 'class_list.dart';

class Drilldown {
  List<ClassList>? classList;
  int? template;
  int? version;
  bool? dataIncluded;
  bool? dataAvailable;

  Drilldown({
    this.classList,
    this.template,
    this.version,
    this.dataIncluded,
    this.dataAvailable,
  });

  factory Drilldown.fromJson(Map<String, dynamic> json) => Drilldown(
        classList: (json['class_list'] as List<dynamic>?)
            ?.map((e) => ClassList.fromJson(e as Map<String, dynamic>))
            .toList(),
        template: json['template'] as int?,
        version: json['version'] as int?,
        dataIncluded: json['data_included'] as bool?,
        dataAvailable: json['data_available'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'class_list': classList?.map((e) => e.toJson()).toList(),
        'template': template,
        'version': version,
        'data_included': dataIncluded,
        'data_available': dataAvailable,
      };
}
