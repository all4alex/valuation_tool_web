import 'used_vehicles.dart';

class VehicleResponse {
  int? warningCount;
  int? errorCount;
  List<dynamic>? messageList;
  int? tokenExpirationMinutes;
  UsedVehicles? usedVehicles;

  VehicleResponse({
    this.warningCount,
    this.errorCount,
    this.messageList,
    this.tokenExpirationMinutes,
    this.usedVehicles,
  });

  factory VehicleResponse.fromJson(Map<String, dynamic> json) {
    return VehicleResponse(
      warningCount: json['warning_count'] as int?,
      errorCount: json['error_count'] as int?,
      messageList: json['message_list'] as List<dynamic>?,
      tokenExpirationMinutes: json['token_expiration_minutes'] as int?,
      usedVehicles: json['used_vehicles'] == null
          ? null
          : UsedVehicles.fromJson(
              json['used_vehicles'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'warning_count': warningCount,
        'error_count': errorCount,
        'message_list': messageList,
        'token_expiration_minutes': tokenExpirationMinutes,
        'used_vehicles': usedVehicles?.toJson(),
      };
}
