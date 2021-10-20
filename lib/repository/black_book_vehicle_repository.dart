import 'package:dio/dio.dart';
import 'package:valuation_tool_web/models/blackbook/make_by_year_response.dart';
import 'package:valuation_tool_web/models/blackbook/vehicle_by_make_response.dart';
import 'package:valuation_tool_web/models/vehicle_response.dart';
import 'package:valuation_tool_web/services/api_interceptor.dart';
import 'package:valuation_tool_web/services/black_book_vehicle_api_service.dart';

abstract class BlackBookRepository {
  Future<VehicleResponse> getVehicleByVin({
    required String vin,
  });
  Future<VehicleResponse> getVehicleByUvc({
    required String uvc,
  });
  Future<MakeByYearResponse> findModelsByYear({
    required String year,
  });
  Future<VehicleByMakeResponse> findVehicleByMake({
    required String year,
    required String make,
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

  @override
  Future<MakeByYearResponse> findModelsByYear({required String year}) {
    return _apiService.findModelsByYear(year: year);
  }

  @override
  Future<VehicleByMakeResponse> findVehicleByMake(
      {required String year, required String make}) {
    return _apiService.findByYearAndMake(year: year, make: make);
  }

  @override
  Future<VehicleResponse> getVehicleByUvc({required String uvc}) {
    return _apiService.searchVehicleByUVC(uvc: uvc);
  }
}
