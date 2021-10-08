import 'package:dio/dio.dart';
import 'package:valuation_tool_web/models/vehicle_response.dart';
import 'package:valuation_tool_web/services/api_interceptor.dart';
import 'package:valuation_tool_web/services/black_book_vehicle_api_service.dart';

abstract class BlackBookRepository {
  Future<VehicleResponse> getVehicleByVin({
    required String vin,
  });
}

class BlackBookRepositoryImpl implements BlackBookRepository {
  BlackBookRepositoryImpl();

  final BlackBookVehicleApiService _apiService =
      BlackBookVehicleApiService(Dio()..interceptors.add(ApiInterceptor()));

  @override
  Future<VehicleResponse> getVehicleByVin({required String vin}) {
    return _apiService.searchVehicle(vin: vin);
  }
}
