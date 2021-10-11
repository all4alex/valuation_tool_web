class AddDeductList {
  String? uoc;
  String? name;
  int? xclean;
  int? clean;
  int? avg;
  int? rough;
  String? auto;
  int? resid12;
  int? resid24;
  int? resid30;
  int? resid36;
  int? resid42;
  int? resid48;
  int? resid60;
  int? resid72;

  AddDeductList({
    this.uoc,
    this.name,
    this.xclean,
    this.clean,
    this.avg,
    this.rough,
    this.auto,
    this.resid12,
    this.resid24,
    this.resid30,
    this.resid36,
    this.resid42,
    this.resid48,
    this.resid60,
    this.resid72,
  });

  factory AddDeductList.fromJson(Map<String, dynamic> json) => AddDeductList(
        uoc: json['uoc'] as String?,
        name: json['name'] as String?,
        xclean: json['xclean'] as int?,
        clean: json['clean'] as int?,
        avg: json['avg'] as int?,
        rough: json['rough'] as int?,
        auto: json['auto'] as String?,
        resid12: json['resid12'] as int?,
        resid24: json['resid24'] as int?,
        resid30: json['resid30'] as int?,
        resid36: json['resid36'] as int?,
        resid42: json['resid42'] as int?,
        resid48: json['resid48'] as int?,
        resid60: json['resid60'] as int?,
        resid72: json['resid72'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'uoc': uoc,
        'name': name,
        'xclean': xclean,
        'clean': clean,
        'avg': avg,
        'rough': rough,
        'auto': auto,
        'resid12': resid12,
        'resid24': resid24,
        'resid30': resid30,
        'resid36': resid36,
        'resid42': resid42,
        'resid48': resid48,
        'resid60': resid60,
        'resid72': resid72,
      };
}
