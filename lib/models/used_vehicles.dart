import 'used_vehicle_list.dart';

class UsedVehicles {
  List<UsedVehicleListItem>? usedVehicleList;
  int? template;
  int? version;
  bool? dataIncluded;
  bool? dataAvailable;

  UsedVehicles({
    this.usedVehicleList,
    this.template,
    this.version,
    this.dataIncluded,
    this.dataAvailable,
  });

  factory UsedVehicles.fromJson(Map<String, dynamic> json) => UsedVehicles(
        usedVehicleList: (json['used_vehicle_list'] as List<dynamic>?)
            ?.map(
                (e) => UsedVehicleListItem.fromJson(e as Map<String, dynamic>))
            .toList(),
        template: json['template'] as int?,
        version: json['version'] as int?,
        dataIncluded: json['data_included'] as bool?,
        dataAvailable: json['data_available'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'used_vehicle_list': usedVehicleList?.map((e) => e.toJson()).toList(),
        'template': template,
        'version': version,
        'data_included': dataIncluded,
        'data_available': dataAvailable,
      };
}
