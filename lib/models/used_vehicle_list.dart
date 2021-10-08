import 'mileage_list.dart';

class UsedVehicleListItem {
  String? publishDate;
  String? dataFreq;
  String? state;
  String? country;
  String? vin;
  String? uvc;
  String? groupnum;
  String? modelYear;
  String? make;
  String? model;
  String? series;
  String? style;
  String? mileageCat;
  String? classCode;
  String? className;
  String? descriptionScore;
  bool? firstValuesFlag;
  String? riskScore;
  int? baseWholeXclean;
  int? mileageWholeXclean;
  int? addDeductWholeXclean;
  int? regionalWholeXclean;
  int? adjustedWholeXclean;
  int? baseWholeClean;
  int? mileageWholeClean;
  int? addDeductWholeClean;
  int? regionalWholeClean;
  int? adjustedWholeClean;
  int? baseWholeAvg;
  int? mileageWholeAvg;
  int? addDeductWholeAvg;
  int? regionalWholeAvg;
  int? adjustedWholeAvg;
  int? baseWholeRough;
  int? mileageWholeRough;
  int? addDeductWholeRough;
  int? regionalWholeRough;
  int? adjustedWholeRough;
  int? baseRetailXclean;
  int? mileageRetailXclean;
  int? addDeductRetailXclean;
  int? regionalRetailXclean;
  int? adjustedRetailXclean;
  int? baseRetailClean;
  int? mileageRetailClean;
  int? addDeductRetailClean;
  int? regionalRetailClean;
  int? adjustedRetailClean;
  int? baseRetailAvg;
  int? mileageRetailAvg;
  int? addDeductRetailAvg;
  int? regionalRetailAvg;
  int? adjustedRetailAvg;
  int? baseRetailRough;
  int? mileageRetailRough;
  int? addDeductRetailRough;
  int? regionalRetailRough;
  int? adjustedRetailRough;
  int? baseTradeinClean;
  int? mileageTradeinClean;
  int? addDeductTradeinClean;
  int? regionalTradeinClean;
  int? adjustedTradeinClean;
  int? baseTradeinAvg;
  int? mileageTradeinAvg;
  int? addDeductTradeinAvg;
  int? regionalTradeinAvg;
  int? adjustedTradeinAvg;
  int? baseTradeinRough;
  int? mileageTradeinRough;
  int? addDeductTradeinRough;
  int? regionalTradeinRough;
  int? adjustedTradeinRough;
  int? baseFinadv;
  int? mileageFinadv;
  int? addDeductFinadv;
  int? regionalFinadv;
  int? adjustedFinadv;
  int? region2;
  int? region3;
  int? region4;
  int? region5;
  int? region6;
  int? msrp;
  int? retailEquipped;
  String? priceIncludes;
  double? wheelBase;
  String? tireSize;
  int? gvw;
  String? seatCap;
  String? fuelType;
  String? fuelCap;
  String? fuelDelivery;
  String? hwyMpg;
  String? cityMpg;
  String? engineDescription;
  String? cylinders;
  String? engineDisplacement;
  String? baseHp;
  double? taxableHp;
  String? torque;
  String? oilCap;
  String? transmission;
  String? drivetrain;
  String? numGears;
  String? extDoors;
  String? moonSunroof;
  String? airbags;
  String? antiCorrosionWarranty;
  String? basicWarranty;
  String? powertrainWarranty;
  String? roadAssistWarranty;
  List<dynamic>? addDeductList;
  List<MileageList>? mileageList;
  List<String>? modelNumberList;

  UsedVehicleListItem({
    this.publishDate,
    this.dataFreq,
    this.state,
    this.country,
    this.vin,
    this.uvc,
    this.groupnum,
    this.modelYear,
    this.make,
    this.model,
    this.series,
    this.style,
    this.mileageCat,
    this.classCode,
    this.className,
    this.descriptionScore,
    this.firstValuesFlag,
    this.riskScore,
    this.baseWholeXclean,
    this.mileageWholeXclean,
    this.addDeductWholeXclean,
    this.regionalWholeXclean,
    this.adjustedWholeXclean,
    this.baseWholeClean,
    this.mileageWholeClean,
    this.addDeductWholeClean,
    this.regionalWholeClean,
    this.adjustedWholeClean,
    this.baseWholeAvg,
    this.mileageWholeAvg,
    this.addDeductWholeAvg,
    this.regionalWholeAvg,
    this.adjustedWholeAvg,
    this.baseWholeRough,
    this.mileageWholeRough,
    this.addDeductWholeRough,
    this.regionalWholeRough,
    this.adjustedWholeRough,
    this.baseRetailXclean,
    this.mileageRetailXclean,
    this.addDeductRetailXclean,
    this.regionalRetailXclean,
    this.adjustedRetailXclean,
    this.baseRetailClean,
    this.mileageRetailClean,
    this.addDeductRetailClean,
    this.regionalRetailClean,
    this.adjustedRetailClean,
    this.baseRetailAvg,
    this.mileageRetailAvg,
    this.addDeductRetailAvg,
    this.regionalRetailAvg,
    this.adjustedRetailAvg,
    this.baseRetailRough,
    this.mileageRetailRough,
    this.addDeductRetailRough,
    this.regionalRetailRough,
    this.adjustedRetailRough,
    this.baseTradeinClean,
    this.mileageTradeinClean,
    this.addDeductTradeinClean,
    this.regionalTradeinClean,
    this.adjustedTradeinClean,
    this.baseTradeinAvg,
    this.mileageTradeinAvg,
    this.addDeductTradeinAvg,
    this.regionalTradeinAvg,
    this.adjustedTradeinAvg,
    this.baseTradeinRough,
    this.mileageTradeinRough,
    this.addDeductTradeinRough,
    this.regionalTradeinRough,
    this.adjustedTradeinRough,
    this.baseFinadv,
    this.mileageFinadv,
    this.addDeductFinadv,
    this.regionalFinadv,
    this.adjustedFinadv,
    this.region2,
    this.region3,
    this.region4,
    this.region5,
    this.region6,
    this.msrp,
    this.retailEquipped,
    this.priceIncludes,
    this.wheelBase,
    this.tireSize,
    this.gvw,
    this.seatCap,
    this.fuelType,
    this.fuelCap,
    this.fuelDelivery,
    this.hwyMpg,
    this.cityMpg,
    this.engineDescription,
    this.cylinders,
    this.engineDisplacement,
    this.baseHp,
    this.taxableHp,
    this.torque,
    this.oilCap,
    this.transmission,
    this.drivetrain,
    this.numGears,
    this.extDoors,
    this.moonSunroof,
    this.airbags,
    this.antiCorrosionWarranty,
    this.basicWarranty,
    this.powertrainWarranty,
    this.roadAssistWarranty,
    this.addDeductList,
    this.mileageList,
    this.modelNumberList,
  });

  factory UsedVehicleListItem.fromJson(Map<String, dynamic> json) {
    return UsedVehicleListItem(
      publishDate: json['publish_date'] as String?,
      dataFreq: json['data_freq'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      vin: json['vin'] as String?,
      uvc: json['uvc'] as String?,
      groupnum: json['groupnum'] as String?,
      modelYear: json['model_year'] as String?,
      make: json['make'] as String?,
      model: json['model'] as String?,
      series: json['series'] as String?,
      style: json['style'] as String?,
      mileageCat: json['mileage_cat'] as String?,
      classCode: json['class_code'] as String?,
      className: json['class_name'] as String?,
      descriptionScore: json['description_score'] as String?,
      firstValuesFlag: json['first_values_flag'] as bool?,
      riskScore: json['risk_score'] as String?,
      baseWholeXclean: json['base_whole_xclean'] as int?,
      mileageWholeXclean: json['mileage_whole_xclean'] as int?,
      addDeductWholeXclean: json['add_deduct_whole_xclean'] as int?,
      regionalWholeXclean: json['regional_whole_xclean'] as int?,
      adjustedWholeXclean: json['adjusted_whole_xclean'] as int?,
      baseWholeClean: json['base_whole_clean'] as int?,
      mileageWholeClean: json['mileage_whole_clean'] as int?,
      addDeductWholeClean: json['add_deduct_whole_clean'] as int?,
      regionalWholeClean: json['regional_whole_clean'] as int?,
      adjustedWholeClean: json['adjusted_whole_clean'] as int?,
      baseWholeAvg: json['base_whole_avg'] as int?,
      mileageWholeAvg: json['mileage_whole_avg'] as int?,
      addDeductWholeAvg: json['add_deduct_whole_avg'] as int?,
      regionalWholeAvg: json['regional_whole_avg'] as int?,
      adjustedWholeAvg: json['adjusted_whole_avg'] as int?,
      baseWholeRough: json['base_whole_rough'] as int?,
      mileageWholeRough: json['mileage_whole_rough'] as int?,
      addDeductWholeRough: json['add_deduct_whole_rough'] as int?,
      regionalWholeRough: json['regional_whole_rough'] as int?,
      adjustedWholeRough: json['adjusted_whole_rough'] as int?,
      baseRetailXclean: json['base_retail_xclean'] as int?,
      mileageRetailXclean: json['mileage_retail_xclean'] as int?,
      addDeductRetailXclean: json['add_deduct_retail_xclean'] as int?,
      regionalRetailXclean: json['regional_retail_xclean'] as int?,
      adjustedRetailXclean: json['adjusted_retail_xclean'] as int?,
      baseRetailClean: json['base_retail_clean'] as int?,
      mileageRetailClean: json['mileage_retail_clean'] as int?,
      addDeductRetailClean: json['add_deduct_retail_clean'] as int?,
      regionalRetailClean: json['regional_retail_clean'] as int?,
      adjustedRetailClean: json['adjusted_retail_clean'] as int?,
      baseRetailAvg: json['base_retail_avg'] as int?,
      mileageRetailAvg: json['mileage_retail_avg'] as int?,
      addDeductRetailAvg: json['add_deduct_retail_avg'] as int?,
      regionalRetailAvg: json['regional_retail_avg'] as int?,
      adjustedRetailAvg: json['adjusted_retail_avg'] as int?,
      baseRetailRough: json['base_retail_rough'] as int?,
      mileageRetailRough: json['mileage_retail_rough'] as int?,
      addDeductRetailRough: json['add_deduct_retail_rough'] as int?,
      regionalRetailRough: json['regional_retail_rough'] as int?,
      adjustedRetailRough: json['adjusted_retail_rough'] as int?,
      baseTradeinClean: json['base_tradein_clean'] as int?,
      mileageTradeinClean: json['mileage_tradein_clean'] as int?,
      addDeductTradeinClean: json['add_deduct_tradein_clean'] as int?,
      regionalTradeinClean: json['regional_tradein_clean'] as int?,
      adjustedTradeinClean: json['adjusted_tradein_clean'] as int?,
      baseTradeinAvg: json['base_tradein_avg'] as int?,
      mileageTradeinAvg: json['mileage_tradein_avg'] as int?,
      addDeductTradeinAvg: json['add_deduct_tradein_avg'] as int?,
      regionalTradeinAvg: json['regional_tradein_avg'] as int?,
      adjustedTradeinAvg: json['adjusted_tradein_avg'] as int?,
      baseTradeinRough: json['base_tradein_rough'] as int?,
      mileageTradeinRough: json['mileage_tradein_rough'] as int?,
      addDeductTradeinRough: json['add_deduct_tradein_rough'] as int?,
      regionalTradeinRough: json['regional_tradein_rough'] as int?,
      adjustedTradeinRough: json['adjusted_tradein_rough'] as int?,
      baseFinadv: json['base_finadv'] as int?,
      mileageFinadv: json['mileage_finadv'] as int?,
      addDeductFinadv: json['add_deduct_finadv'] as int?,
      regionalFinadv: json['regional_finadv'] as int?,
      adjustedFinadv: json['adjusted_finadv'] as int?,
      region2: json['region2'] as int?,
      region3: json['region3'] as int?,
      region4: json['region4'] as int?,
      region5: json['region5'] as int?,
      region6: json['region6'] as int?,
      msrp: json['msrp'] as int?,
      retailEquipped: json['retail_equipped'] as int?,
      priceIncludes: json['price_includes'] as String?,
      wheelBase: (json['wheel_base'] as num?)?.toDouble(),
      tireSize: json['tire_size'] as String?,
      gvw: json['gvw'] as int?,
      seatCap: json['seat_cap'] as String?,
      fuelType: json['fuel_type'] as String?,
      fuelCap: json['fuel_cap'] as String?,
      fuelDelivery: json['fuel_delivery'] as String?,
      hwyMpg: json['hwy_mpg'] as String?,
      cityMpg: json['city_mpg'] as String?,
      engineDescription: json['engine_description'] as String?,
      cylinders: json['cylinders'] as String?,
      engineDisplacement: json['engine_displacement'] as String?,
      baseHp: json['base_hp'] as String?,
      taxableHp: (json['taxable_hp'] as num?)?.toDouble(),
      torque: json['torque'] as String?,
      oilCap: json['oil_cap'] as String?,
      transmission: json['transmission'] as String?,
      drivetrain: json['drivetrain'] as String?,
      numGears: json['num_gears'] as String?,
      extDoors: json['ext_doors'] as String?,
      moonSunroof: json['moon_sunroof'] as String?,
      airbags: json['airbags'] as String?,
      antiCorrosionWarranty: json['anti_corrosion_warranty'] as String?,
      basicWarranty: json['basic_warranty'] as String?,
      powertrainWarranty: json['powertrain_warranty'] as String?,
      roadAssistWarranty: json['road_assist_warranty'] as String?,
      addDeductList: json['add_deduct_list'] as List<dynamic>?,
      mileageList: (json['mileage_list'] as List<dynamic>?)
          ?.map((e) => MileageList.fromJson(e as Map<String, dynamic>))
          .toList(),
      modelNumberList: json['model_number_list'] as List<String>?,
    );
  }

  Map<String, dynamic> toJson() => {
        'publish_date': publishDate,
        'data_freq': dataFreq,
        'state': state,
        'country': country,
        'vin': vin,
        'uvc': uvc,
        'groupnum': groupnum,
        'model_year': modelYear,
        'make': make,
        'model': model,
        'series': series,
        'style': style,
        'mileage_cat': mileageCat,
        'class_code': classCode,
        'class_name': className,
        'description_score': descriptionScore,
        'first_values_flag': firstValuesFlag,
        'risk_score': riskScore,
        'base_whole_xclean': baseWholeXclean,
        'mileage_whole_xclean': mileageWholeXclean,
        'add_deduct_whole_xclean': addDeductWholeXclean,
        'regional_whole_xclean': regionalWholeXclean,
        'adjusted_whole_xclean': adjustedWholeXclean,
        'base_whole_clean': baseWholeClean,
        'mileage_whole_clean': mileageWholeClean,
        'add_deduct_whole_clean': addDeductWholeClean,
        'regional_whole_clean': regionalWholeClean,
        'adjusted_whole_clean': adjustedWholeClean,
        'base_whole_avg': baseWholeAvg,
        'mileage_whole_avg': mileageWholeAvg,
        'add_deduct_whole_avg': addDeductWholeAvg,
        'regional_whole_avg': regionalWholeAvg,
        'adjusted_whole_avg': adjustedWholeAvg,
        'base_whole_rough': baseWholeRough,
        'mileage_whole_rough': mileageWholeRough,
        'add_deduct_whole_rough': addDeductWholeRough,
        'regional_whole_rough': regionalWholeRough,
        'adjusted_whole_rough': adjustedWholeRough,
        'base_retail_xclean': baseRetailXclean,
        'mileage_retail_xclean': mileageRetailXclean,
        'add_deduct_retail_xclean': addDeductRetailXclean,
        'regional_retail_xclean': regionalRetailXclean,
        'adjusted_retail_xclean': adjustedRetailXclean,
        'base_retail_clean': baseRetailClean,
        'mileage_retail_clean': mileageRetailClean,
        'add_deduct_retail_clean': addDeductRetailClean,
        'regional_retail_clean': regionalRetailClean,
        'adjusted_retail_clean': adjustedRetailClean,
        'base_retail_avg': baseRetailAvg,
        'mileage_retail_avg': mileageRetailAvg,
        'add_deduct_retail_avg': addDeductRetailAvg,
        'regional_retail_avg': regionalRetailAvg,
        'adjusted_retail_avg': adjustedRetailAvg,
        'base_retail_rough': baseRetailRough,
        'mileage_retail_rough': mileageRetailRough,
        'add_deduct_retail_rough': addDeductRetailRough,
        'regional_retail_rough': regionalRetailRough,
        'adjusted_retail_rough': adjustedRetailRough,
        'base_tradein_clean': baseTradeinClean,
        'mileage_tradein_clean': mileageTradeinClean,
        'add_deduct_tradein_clean': addDeductTradeinClean,
        'regional_tradein_clean': regionalTradeinClean,
        'adjusted_tradein_clean': adjustedTradeinClean,
        'base_tradein_avg': baseTradeinAvg,
        'mileage_tradein_avg': mileageTradeinAvg,
        'add_deduct_tradein_avg': addDeductTradeinAvg,
        'regional_tradein_avg': regionalTradeinAvg,
        'adjusted_tradein_avg': adjustedTradeinAvg,
        'base_tradein_rough': baseTradeinRough,
        'mileage_tradein_rough': mileageTradeinRough,
        'add_deduct_tradein_rough': addDeductTradeinRough,
        'regional_tradein_rough': regionalTradeinRough,
        'adjusted_tradein_rough': adjustedTradeinRough,
        'base_finadv': baseFinadv,
        'mileage_finadv': mileageFinadv,
        'add_deduct_finadv': addDeductFinadv,
        'regional_finadv': regionalFinadv,
        'adjusted_finadv': adjustedFinadv,
        'region2': region2,
        'region3': region3,
        'region4': region4,
        'region5': region5,
        'region6': region6,
        'msrp': msrp,
        'retail_equipped': retailEquipped,
        'price_includes': priceIncludes,
        'wheel_base': wheelBase,
        'tire_size': tireSize,
        'gvw': gvw,
        'seat_cap': seatCap,
        'fuel_type': fuelType,
        'fuel_cap': fuelCap,
        'fuel_delivery': fuelDelivery,
        'hwy_mpg': hwyMpg,
        'city_mpg': cityMpg,
        'engine_description': engineDescription,
        'cylinders': cylinders,
        'engine_displacement': engineDisplacement,
        'base_hp': baseHp,
        'taxable_hp': taxableHp,
        'torque': torque,
        'oil_cap': oilCap,
        'transmission': transmission,
        'drivetrain': drivetrain,
        'num_gears': numGears,
        'ext_doors': extDoors,
        'moon_sunroof': moonSunroof,
        'airbags': airbags,
        'anti_corrosion_warranty': antiCorrosionWarranty,
        'basic_warranty': basicWarranty,
        'powertrain_warranty': powertrainWarranty,
        'road_assist_warranty': roadAssistWarranty,
        'add_deduct_list': addDeductList,
        'mileage_list': mileageList?.map((e) => e.toJson()).toList(),
        'model_number_list': modelNumberList,
      };
}
