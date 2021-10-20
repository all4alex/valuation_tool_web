import 'drilldown.dart';

class VehicleByMakeResponse {
  int? warningCount;
  int? errorCount;
  List<dynamic>? messageList;
  int? tokenExpirationMinutes;
  Drilldown? drilldown;

  VehicleByMakeResponse({
    this.warningCount,
    this.errorCount,
    this.messageList,
    this.tokenExpirationMinutes,
    this.drilldown,
  });

  factory VehicleByMakeResponse.fromJson(Map<String, dynamic> json) {
    return VehicleByMakeResponse(
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
