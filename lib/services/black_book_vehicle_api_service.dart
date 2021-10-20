import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:valuation_tool_web/models/blackbook/make_by_year_response.dart';
import 'package:valuation_tool_web/models/blackbook/vehicle_by_make_response.dart';
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
