class RetailStatisticsResponse {
  int? warningCount;
  int? errorCount;
  List<dynamic>? messageList;
  int? tokenExpirationMinutes;
  InputParameters? inputParameters;
  EffectiveParameters? effectiveParameters;
  int? recordCount;
  ListingsStatistics? listingsStatistics;
  List<RetailItemResponse>? listings;

  RetailStatisticsResponse({
    this.warningCount,
    this.errorCount,
    this.messageList,
    this.tokenExpirationMinutes,
    this.inputParameters,
    this.effectiveParameters,
    this.recordCount,
    this.listingsStatistics,
    this.listings,
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
      listings: (json['listings'] as List<dynamic>?)
          ?.map((e) => RetailItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
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

class RetailItemResponse {
  String? listingId;
  String? listingHeading;
  String? listingType;
  String? listingUrl;
  String? listingFirstDate;
  String? listingDropoffDate;
  int? daysOnMarket;
  String? dealerName;
  String? dealerStreet;
  String? dealerCity;
  String? dealerState;
  String? dealerZipcode;
  String? dealerUrl;
  String? dealerEmail;
  String? dealerPhone;
  String? dealerType;
  String? stockType;
  String? vin;
  String? uvc;
  int? mileage;
  int? price;
  int? msrp;
  String? modelYear;
  String? make;
  String? model;
  String? series;
  String? style;
  bool? certified;
  bool? hasLeather;
  bool? hasNavigation;
  String? exteriorColor;
  String? exteriorColorCategory;
  String? interiorColor;
  String? interiorColorCategory;
  bool? priceAnalysis;
  String? wheelbaseFromVin;
  String? drivetrainFromVin;
  String? engineFromVin;
  String? transmissionFromVin;
  String? fuelTypeFromVin;
  String? optionalFeatures;
  String? standardFeatures;
  String? sellerNotes;
  int? numberPriceChanges;
  String? priceHistoryDelimited;
  List<PriceHistory>? priceHistory;
  double? distanceToDealer;

  RetailItemResponse({
    this.listingId,
    this.listingHeading,
    this.listingType,
    this.listingUrl,
    this.listingFirstDate,
    this.listingDropoffDate,
    this.daysOnMarket,
    this.dealerName,
    this.dealerStreet,
    this.dealerCity,
    this.dealerState,
    this.dealerZipcode,
    this.dealerUrl,
    this.dealerEmail,
    this.dealerPhone,
    this.dealerType,
    this.stockType,
    this.vin,
    this.uvc,
    this.mileage,
    this.price,
    this.msrp,
    this.modelYear,
    this.make,
    this.model,
    this.series,
    this.style,
    this.certified,
    this.hasLeather,
    this.hasNavigation,
    this.exteriorColor,
    this.exteriorColorCategory,
    this.interiorColor,
    this.interiorColorCategory,
    this.priceAnalysis,
    this.wheelbaseFromVin,
    this.drivetrainFromVin,
    this.engineFromVin,
    this.transmissionFromVin,
    this.fuelTypeFromVin,
    this.optionalFeatures,
    this.standardFeatures,
    this.sellerNotes,
    this.numberPriceChanges,
    this.priceHistoryDelimited,
    this.priceHistory,
    this.distanceToDealer,
  });

  factory RetailItemResponse.fromJson(Map<String, dynamic> json) =>
      RetailItemResponse(
        listingId: json['listing_id'] as String?,
        listingHeading: json['listing_heading'] as String?,
        listingType: json['listing_type'] as String?,
        listingUrl: json['listing_url'] as String?,
        listingFirstDate: json['listing_first_date'] as String?,
        listingDropoffDate: json['listing_dropoff_date'] as String?,
        daysOnMarket: json['days_on_market'] as int?,
        dealerName: json['dealer_name'] as String?,
        dealerStreet: json['dealer_street'] as String?,
        dealerCity: json['dealer_city'] as String?,
        dealerState: json['dealer_state'] as String?,
        dealerZipcode: json['dealer_zipcode'] as String?,
        dealerUrl: json['dealer_url'] as String?,
        dealerEmail: json['dealer_email'] as String?,
        dealerPhone: json['dealer_phone'] as String?,
        dealerType: json['dealer_type'] as String?,
        stockType: json['stock_type'] as String?,
        vin: json['vin'] as String?,
        uvc: json['uvc'] as String?,
        mileage: json['mileage'] as int?,
        price: json['price'] as int?,
        msrp: json['msrp'] as int?,
        modelYear: json['model_year'] as String?,
        make: json['make'] as String?,
        model: json['model'] as String?,
        series: json['series'] as String?,
        style: json['style'] as String?,
        certified: json['certified'] as bool?,
        hasLeather: json['has_leather'] as bool?,
        hasNavigation: json['has_navigation'] as bool?,
        exteriorColor: json['exterior_color'] as String?,
        exteriorColorCategory: json['exterior_color_category'] as String?,
        interiorColor: json['interior_color'] as String?,
        interiorColorCategory: json['interior_color_category'] as String?,
        priceAnalysis: json['price_analysis'] as bool?,
        wheelbaseFromVin: json['wheelbase_from_vin'] as String?,
        drivetrainFromVin: json['drivetrain_from_vin'] as String?,
        engineFromVin: json['engine_from_vin'] as String?,
        transmissionFromVin: json['transmission_from_vin'] as String?,
        fuelTypeFromVin: json['fuel_type_from_vin'] as String?,
        optionalFeatures: json['optional_features'] as String?,
        standardFeatures: json['standard_features'] as String?,
        sellerNotes: json['seller_notes'] as String?,
        numberPriceChanges: json['number_price_changes'] as int?,
        priceHistoryDelimited: json['price_history_delimited'] as String?,
        priceHistory: (json['price_history'] as List<dynamic>?)
            ?.map((e) => PriceHistory.fromJson(e as Map<String, dynamic>))
            .toList(),
        distanceToDealer: (json['distance_to_dealer'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'listing_id': listingId,
        'listing_heading': listingHeading,
        'listing_type': listingType,
        'listing_url': listingUrl,
        'listing_first_date': listingFirstDate,
        'listing_dropoff_date': listingDropoffDate,
        'days_on_market': daysOnMarket,
        'dealer_name': dealerName,
        'dealer_street': dealerStreet,
        'dealer_city': dealerCity,
        'dealer_state': dealerState,
        'dealer_zipcode': dealerZipcode,
        'dealer_url': dealerUrl,
        'dealer_email': dealerEmail,
        'dealer_phone': dealerPhone,
        'dealer_type': dealerType,
        'stock_type': stockType,
        'vin': vin,
        'uvc': uvc,
        'mileage': mileage,
        'price': price,
        'msrp': msrp,
        'model_year': modelYear,
        'make': make,
        'model': model,
        'series': series,
        'style': style,
        'certified': certified,
        'has_leather': hasLeather,
        'has_navigation': hasNavigation,
        'exterior_color': exteriorColor,
        'exterior_color_category': exteriorColorCategory,
        'interior_color': interiorColor,
        'interior_color_category': interiorColorCategory,
        'price_analysis': priceAnalysis,
        'wheelbase_from_vin': wheelbaseFromVin,
        'drivetrain_from_vin': drivetrainFromVin,
        'engine_from_vin': engineFromVin,
        'transmission_from_vin': transmissionFromVin,
        'fuel_type_from_vin': fuelTypeFromVin,
        'optional_features': optionalFeatures,
        'standard_features': standardFeatures,
        'seller_notes': sellerNotes,
        'number_price_changes': numberPriceChanges,
        'price_history_delimited': priceHistoryDelimited,
        'price_history': priceHistory?.map((e) => e.toJson()).toList(),
        'distance_to_dealer': distanceToDealer,
      };
}

class PriceHistory {
  String? changeDate;
  int? price;
  int? mileage;

  PriceHistory({this.changeDate, this.price, this.mileage});

  factory PriceHistory.fromJson(Map<String, dynamic> json) => PriceHistory(
        changeDate: json['change_date'] as String?,
        price: json['price'] as int?,
        mileage: json['mileage'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'change_date': changeDate,
        'price': price,
        'mileage': mileage,
      };
}
