class MakeByYearResponse {
  int? warningCount;
  int? errorCount;
  List<dynamic>? messageList;
  int? tokenExpirationMinutes;
  Drilldown? drilldown;

  MakeByYearResponse({
    this.warningCount,
    this.errorCount,
    this.messageList,
    this.tokenExpirationMinutes,
    this.drilldown,
  });

  factory MakeByYearResponse.fromJson(Map<String, dynamic> json) {
    return MakeByYearResponse(
      warningCount: json['warning_count'] as int?,
      errorCount: json['error_count'] as int?,
      messageList: json['message_list'] as List<dynamic>?,
      tokenExpirationMinutes: json['token_expiration_minutes'] as int?,
      drilldown: json['drilldown'] == null
          ? null
          : Drilldown.fromJson(json['drilldown'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'warning_count': warningCount,
        'error_count': errorCount,
        'message_list': messageList,
        'token_expiration_minutes': tokenExpirationMinutes,
        'drilldown': drilldown?.toJson(),
      };
}

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

class MakeList {
  List<dynamic>? modelList;
  String? name;

  MakeList({this.modelList, this.name});

  factory MakeList.fromJson(Map<String, dynamic> json) => MakeList(
        modelList: json['model_list'] as List<dynamic>?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'model_list': modelList,
        'name': name,
      };
}
