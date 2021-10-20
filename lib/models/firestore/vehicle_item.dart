import 'package:flutter/material.dart';

class VehicleItem {
  String? id;
  String? imageUrl;
  String? addedDate;
  String? name;
  String? subName;
  String? vin;
  String? miles;
  String? folder;
  String? user;

  VehicleItem(
      {this.id,
      this.imageUrl,
      this.addedDate,
      this.name,
      this.subName,
      this.vin,
      this.miles,
      this.folder,
      this.user});

  factory VehicleItem.fromJson(Map<String, dynamic> json) => VehicleItem(
        id: json['id'],
        imageUrl: json['imageUrl'],
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
        'imageUrl': imageUrl,
        'addedDate': addedDate,
        'name': name,
        'subName': subName,
        'vin': vin,
        'miles': miles,
        'folder': folder,
        'user': user,
      };
}
