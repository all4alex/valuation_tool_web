class RetailStatisticsResponse {
  int? warningCount;
  int? errorCount;
  List<dynamic>? messageList;
  int? tokenExpirationMinutes;
  InputParameters? inputParameters;
  EffectiveParameters? effectiveParameters;
  int? recordCount;
  ListingsStatistics? listingsStatistics;

  RetailStatisticsResponse({
    this.warningCount,
    this.errorCount,
    this.messageList,
    this.tokenExpirationMinutes,
    this.inputParameters,
    this.effectiveParameters,
    this.recordCount,
    this.listingsStatistics,
  });

  factory RetailStatisticsResponse.fromJson(Map<String, dynamic> json) {
    return RetailStatisticsResponse(
      warningCount: json['warning_count'] as int?,
      errorCount: json['error_count'] as int?,
      messageList: json['message_list'] as List<dynamic>?,
      tokenExpirationMinutes: json['token_expiration_minutes'] as int?,
      inputParameters: json['input_parameters'] == null
          ? null
          : InputParameters.fromJson(
              json['input_parameters'] as Map<String, dynamic>),
      effectiveParameters: json['effective_parameters'] == null
          ? null
          : EffectiveParameters.fromJson(
              json['effective_parameters'] as Map<String, dynamic>),
      recordCount: json['record_count'] as int?,
      listingsStatistics: json['listings_statistics'] == null
          ? null
          : ListingsStatistics.fromJson(
              json['listings_statistics'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'warning_count': warningCount,
        'error_count': errorCount,
        'message_list': messageList,
        'token_expiration_minutes': tokenExpirationMinutes,
        'input_parameters': inputParameters?.toJson(),
        'effective_parameters': effectiveParameters?.toJson(),
        'record_count': recordCount,
        'listings_statistics': listingsStatistics?.toJson(),
      };
}

class SoldStatistics {
  int? vehicleCount;
  int? minimumPrice;
  int? maximumPrice;
  int? meanPrice;
  int? medianPrice;
  int? minimumMileage;
  int? maximumMileage;
  int? meanMileage;
  int? medianMileage;
  double? meanDaysToTurn;
  double? marketDaysSupply;

  SoldStatistics({
    this.vehicleCount,
    this.minimumPrice,
    this.maximumPrice,
    this.meanPrice,
    this.medianPrice,
    this.minimumMileage,
    this.maximumMileage,
    this.meanMileage,
    this.medianMileage,
    this.meanDaysToTurn,
    this.marketDaysSupply,
  });

  factory SoldStatistics.fromJson(Map<String, dynamic> json) {
    return SoldStatistics(
      vehicleCount: json['vehicle_count'] as int?,
      minimumPrice: json['minimum_price'] as int?,
      maximumPrice: json['maximum_price'] as int?,
      meanPrice: json['mean_price'] as int?,
      medianPrice: json['median_price'] as int?,
      minimumMileage: json['minimum_mileage'] as int?,
      maximumMileage: json['maximum_mileage'] as int?,
      meanMileage: json['mean_mileage'] as int?,
      medianMileage: json['median_mileage'] as int?,
      meanDaysToTurn: (json['mean_days_to_turn'] as num?)?.toDouble(),
      marketDaysSupply: json['market_days_supply'] as double?,
    );
  }

  Map<String, dynamic> toJson() => {
        'vehicle_count': vehicleCount,
        'minimum_price': minimumPrice,
        'maximum_price': maximumPrice,
        'mean_price': meanPrice,
        'median_price': medianPrice,
        'minimum_mileage': minimumMileage,
        'maximum_mileage': maximumMileage,
        'mean_mileage': meanMileage,
        'median_mileage': medianMileage,
        'mean_days_to_turn': meanDaysToTurn,
        'market_days_supply': marketDaysSupply,
      };
}

class ListingsStatistics {
  double? meanDaysToTurn;
  double? marketDaysSupply;
  ActiveStatistics? activeStatistics;
  SoldStatistics? soldStatistics;

  ListingsStatistics({
    this.meanDaysToTurn,
    this.marketDaysSupply,
    this.activeStatistics,
    this.soldStatistics,
  });

  factory ListingsStatistics.fromJson(Map<String, dynamic> json) {
    return ListingsStatistics(
      meanDaysToTurn: (json['mean_days_to_turn'] as num?)?.toDouble(),
      marketDaysSupply: json['market_days_supply'] as double?,
      activeStatistics: json['active_statistics'] == null
          ? null
          : ActiveStatistics.fromJson(
              json['active_statistics'] as Map<String, dynamic>),
      soldStatistics: json['sold_statistics'] == null
          ? null
          : SoldStatistics.fromJson(
              json['sold_statistics'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'mean_days_to_turn': meanDaysToTurn,
        'market_days_supply': marketDaysSupply,
        'active_statistics': activeStatistics?.toJson(),
        'sold_statistics': soldStatistics?.toJson(),
      };
}

class InputParameters {
  String? vin;
  String? zipcode;
  int? minimumMileage;
  int? maximumMileage;
  int? radiusMiles;
  bool? inState;
  bool? allTrims;
  int? dayRange;
  bool? priceAnalysis;

  InputParameters({
    this.vin,
    this.zipcode,
    this.minimumMileage,
    this.maximumMileage,
    this.radiusMiles,
    this.inState,
    this.allTrims,
    this.dayRange,
    this.priceAnalysis,
  });

  factory InputParameters.fromJson(Map<String, dynamic> json) {
    return InputParameters(
      vin: json['vin'] as String?,
      zipcode: json['zipcode'] as String?,
      minimumMileage: json['minimum_mileage'] as int?,
      maximumMileage: json['maximum_mileage'] as int?,
      radiusMiles: json['radius_miles'] as int?,
      inState: json['in_state'] as bool?,
      allTrims: json['all_trims'] as bool?,
      dayRange: json['day_range'] as int?,
      priceAnalysis: json['price_analysis'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        'vin': vin,
        'zipcode': zipcode,
        'minimum_mileage': minimumMileage,
        'maximum_mileage': maximumMileage,
        'radius_miles': radiusMiles,
        'in_state': inState,
        'all_trims': allTrims,
        'day_range': dayRange,
        'price_analysis': priceAnalysis,
      };
}

class EffectiveParameters {
  String? vin;
  String? zipcode;
  int? minimumMileage;
  int? maximumMileage;
  int? radiusMiles;
  bool? inState;
  bool? allTrims;
  int? dayRange;
  bool? priceAnalysis;
  int? dealerId;

  EffectiveParameters({
    this.vin,
    this.zipcode,
    this.minimumMileage,
    this.maximumMileage,
    this.radiusMiles,
    this.inState,
    this.allTrims,
    this.dayRange,
    this.priceAnalysis,
    this.dealerId,
  });

  factory EffectiveParameters.fromJson(Map<String, dynamic> json) {
    return EffectiveParameters(
      vin: json['vin'] as String?,
      zipcode: json['zipcode'] as String?,
      minimumMileage: json['minimum_mileage'] as int?,
      maximumMileage: json['maximum_mileage'] as int?,
      radiusMiles: json['radius_miles'] as int?,
      inState: json['in_state'] as bool?,
      allTrims: json['all_trims'] as bool?,
      dayRange: json['day_range'] as int?,
      priceAnalysis: json['price_analysis'] as bool?,
      dealerId: json['dealer_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'vin': vin,
        'zipcode': zipcode,
        'minimum_mileage': minimumMileage,
        'maximum_mileage': maximumMileage,
        'radius_miles': radiusMiles,
        'in_state': inState,
        'all_trims': allTrims,
        'day_range': dayRange,
        'price_analysis': priceAnalysis,
        'dealer_id': dealerId,
      };
}

class ActiveStatistics {
  int? vehicleCount;
  int? minimumPrice;
  int? maximumPrice;
  int? meanPrice;
  int? medianPrice;
  int? minimumMileage;
  int? maximumMileage;
  int? meanMileage;
  int? medianMileage;
  int? meanDaysToTurn;
  int? marketDaysSupply;

  ActiveStatistics({
    this.vehicleCount,
    this.minimumPrice,
    this.maximumPrice,
    this.meanPrice,
    this.medianPrice,
    this.minimumMileage,
    this.maximumMileage,
    this.meanMileage,
    this.medianMileage,
    this.meanDaysToTurn,
    this.marketDaysSupply,
  });

  factory ActiveStatistics.fromJson(Map<String, dynamic> json) {
    return ActiveStatistics(
      vehicleCount: json['vehicle_count'] as int?,
      minimumPrice: json['minimum_price'] as int?,
      maximumPrice: json['maximum_price'] as int?,
      meanPrice: json['mean_price'] as int?,
      medianPrice: json['median_price'] as int?,
      minimumMileage: json['minimum_mileage'] as int?,
      maximumMileage: json['maximum_mileage'] as int?,
      meanMileage: json['mean_mileage'] as int?,
      medianMileage: json['median_mileage'] as int?,
      meanDaysToTurn: json['mean_days_to_turn'] as int?,
      marketDaysSupply: json['market_days_supply'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'vehicle_count': vehicleCount,
        'minimum_price': minimumPrice,
        'maximum_price': maximumPrice,
        'mean_price': meanPrice,
        'median_price': medianPrice,
        'minimum_mileage': minimumMileage,
        'maximum_mileage': maximumMileage,
        'mean_mileage': meanMileage,
        'median_mileage': medianMileage,
        'mean_days_to_turn': meanDaysToTurn,
        'market_days_supply': marketDaysSupply,
      };
}
