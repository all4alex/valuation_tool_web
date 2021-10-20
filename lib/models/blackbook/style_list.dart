class StyleList {
  String? uvc;
  String? name;

  StyleList({this.uvc, this.name});

  factory StyleList.fromJson(Map<String, dynamic> json) => StyleList(
        uvc: json['uvc'] as String?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'uvc': uvc,
        'name': name,
      };
}
