import 'package:flutter/material.dart';

class VehicleItem {
  final String? id;
  final String? addedDate;
  final String? name;
  final String? subName;
  final String? vin;
  final String? miles;
  final String? folder;
  final String? user;

  VehicleItem(
      {this.id,
      this.addedDate,
      this.name,
      this.subName,
      this.vin,
      this.miles,
      this.folder,
      this.user});

  factory VehicleItem.fromJson(Map<String, dynamic> json) => VehicleItem(
        id: json['id'],
        addedDate: json['addedDate'],
        name: json['name'],
        subName: json['subName'],
        vin: json['vin'],
        miles: json['miles'],
        folder: json['folder'],
        user: json['user'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'addedDate': addedDate,
        'name': name,
        'subName': subName,
        'vin': vin,
        'miles': miles,
        'folder': folder,
        'user': user,
      };
}
