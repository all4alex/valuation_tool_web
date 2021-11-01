class StateResponse {
  int? warningCount;
  int? errorCount;
  List<dynamic>? messageList;
  int? tokenExpirationMinutes;
  States? states;

  StateResponse({
    this.warningCount,
    this.errorCount,
    this.messageList,
    this.tokenExpirationMinutes,
    this.states,
  });

  factory StateResponse.fromJson(Map<String, dynamic> json) {
    return StateResponse(
      warningCount: json['warning_count'] as int?,
      errorCount: json['error_count'] as int?,
      messageList: json['message_list'] as List<dynamic>?,
      tokenExpirationMinutes: json['token_expiration_minutes'] as int?,
      states: json['states'] == null
          ? null
          : States.fromJson(json['states'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'warning_count': warningCount,
        'error_count': errorCount,
        'message_list': messageList,
        'token_expiration_minutes': tokenExpirationMinutes,
        'states': states?.toJson(),
      };
}

class StateList {
  String? abbreviation;
  String? name;
  String? carRegion;
  String? truckRegion;

  StateList({
    this.abbreviation,
    this.name,
    this.carRegion,
    this.truckRegion,
  });

  factory StateList.fromJson(Map<String, dynamic> json) => StateList(
        abbreviation: json['abbreviation'] as String?,
        name: json['name'] as String?,
        carRegion: json['car_region'] as String?,
        truckRegion: json['truck_region'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'abbreviation': abbreviation,
        'name': name,
        'car_region': carRegion,
        'truck_region': truckRegion,
      };
}

class States {
  List<StateList>? stateList;
  int? template;
  int? version;
  bool? dataIncluded;
  bool? dataAvailable;

  States({
    this.stateList,
    this.template,
    this.version,
    this.dataIncluded,
    this.dataAvailable,
  });

  factory States.fromJson(Map<String, dynamic> json) => States(
        stateList: (json['state_list'] as List<dynamic>?)
            ?.map((e) => StateList.fromJson(e as Map<String, dynamic>))
            .toList(),
        template: json['template'] as int?,
        version: json['version'] as int?,
        dataIncluded: json['data_included'] as bool?,
        dataAvailable: json['data_available'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'state_list': stateList?.map((e) => e.toJson()).toList(),
        'template': template,
        'version': version,
        'data_included': dataIncluded,
        'data_available': dataAvailable,
      };
}
