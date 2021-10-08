class MileageList {
  String? modelYear;
  int? rangeBegin;
  int? rangeEnd;
  int? xclean;
  int? clean;
  int? avg;
  int? rough;
  int? finadv;
  String? mileageCat;

  MileageList({
    this.modelYear,
    this.rangeBegin,
    this.rangeEnd,
    this.xclean,
    this.clean,
    this.avg,
    this.rough,
    this.finadv,
    this.mileageCat,
  });

  factory MileageList.fromJson(Map<String, dynamic> json) => MileageList(
        modelYear: json['model_year'] as String?,
        rangeBegin: json['range_begin'] as int?,
        rangeEnd: json['range_end'] as int?,
        xclean: json['xclean'] as int?,
        clean: json['clean'] as int?,
        avg: json['avg'] as int?,
        rough: json['rough'] as int?,
        finadv: json['finadv'] as int?,
        mileageCat: json['mileage_cat'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'model_year': modelYear,
        'range_begin': rangeBegin,
        'range_end': rangeEnd,
        'xclean': xclean,
        'clean': clean,
        'avg': avg,
        'rough': rough,
        'finadv': finadv,
        'mileage_cat': mileageCat,
      };
}
