import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:valuation_tool_web/models/blackbook/make_by_year_response.dart';
import 'package:valuation_tool_web/models/blackbook/vehicle_by_make_response.dart';
import 'package:valuation_tool_web/models/retail_statistics_response.dart';
import 'package:valuation_tool_web/models/vehicle_response.dart';
part 'black_book_vehicle_api_service.g.dart';

@RestApi(baseUrl: 'https://service.blackbookcloud.com/')
abstract class BlackBookVehicleApiService {
  factory BlackBookVehicleApiService(Dio dio) = _BlackBookVehicleApiService;

  @GET('UsedCarWS/UsedCarWS/UsedVehicle/VIN/{vin}')
  Future<VehicleResponse> searchVehicle({
    @Path() required String vin,
  });

  @GET('UsedCarWS/UsedCarWS/UsedVehicle/UVC/{uvc}')
  Future<VehicleResponse> searchVehicleByUVC({
    @Path() required String uvc,
  });

  @GET('/RetailAPI/RetailAPI/ListingsStatistics')
  Future<RetailStatisticsResponse> searchRetailStatsByVIN({
    @Query('vin') required String vin,
    @Query('maximum_mileage') required String maximumMileage,
    @Query('zipcode') required String zipcode,
  });

  @GET('RetailAPI/RetailAPI/ListingsStatistics')
  Future<RetailStatisticsResponse> searchRetailStatsByUVC({
    @Query('uvc') required String uvc,
    @Query('maximum_mileage') required String maximumMileage,
    @Query('zipcode') required String zipcode,
  });

  @GET('UsedCarWS/UsedCarWS/Drilldown/ALL/{year}')
  Future<MakeByYearResponse> findModelsByYear({
    @Path() required String year,
  });

  @GET('UsedCarWS/UsedCarWS/Drilldown/ALL/{year}/{make}')
  Future<VehicleByMakeResponse> findByYearAndMake({
    @Path() required String year,
    @Path() required String make,
  });
}
