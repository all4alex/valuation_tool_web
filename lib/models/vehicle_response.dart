import 'message_list.dart';
import 'used_vehicles.dart';

class VehicleResponse {
  int? warningCount;
  int? errorCount;
  List<MessageList>? messageList;
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
      messageList: (json['message_list'] as List<dynamic>?)
          ?.map((e) => MessageList.fromJson(e as Map<String, dynamic>))
          .toList(),
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
        'message_list': messageList?.map((e) => e.toJson()).toList(),
        'token_expiration_minutes': tokenExpirationMinutes,
        'used_vehicles': usedVehicles?.toJson(),
      };
}
