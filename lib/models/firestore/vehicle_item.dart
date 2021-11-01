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
  String? runNumber;
  String? auction;

  VehicleItem({
    this.id,
    this.imageUrl,
    this.addedDate,
    this.name,
    this.subName,
    this.vin,
    this.miles,
    this.folder,
    this.user,
    this.runNumber,
    this.auction,
  });

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
        runNumber: json['runNumber'],
        auction: json['auction'],
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
        'runNumber': runNumber,
        'auction': auction,
      };

  VehicleItem copyWith({
    String? id,
    String? imageUrl,
    String? addedDate,
    String? name,
    String? subName,
    String? vin,
    String? miles,
    String? folder,
    String? user,
    String? runNumber,
    String? auction,
  }) =>
      VehicleItem(
        id: id ?? this.id,
        imageUrl: imageUrl ?? this.imageUrl,
        addedDate: addedDate ?? this.addedDate,
        name: name ?? this.name,
        subName: subName ?? this.subName,
        vin: vin ?? this.vin,
        miles: miles ?? this.miles,
        folder: folder ?? this.folder,
        user: user ?? this.user,
        runNumber: runNumber ?? this.runNumber,
        auction: auction ?? this.auction,
      );
}
