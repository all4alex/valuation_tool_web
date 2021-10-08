import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:valuation_tool_web/models/vehicle_response.dart';
part 'black_book_vehicle_api_service.g.dart';

@RestApi(baseUrl: 'https://service.blackbookcloud.com/')
abstract class BlackBookVehicleApiService {
  factory BlackBookVehicleApiService(Dio dio) = _BlackBookVehicleApiService;

  @GET('UsedCarWS/UsedCarWS/UsedVehicle/VIN/{vin}')
  Future<VehicleResponse> searchVehicle({
    @Path() String vin,
  });
}
