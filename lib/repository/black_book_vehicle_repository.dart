import 'package:dio/dio.dart';
import 'package:valuation_tool_web/models/blackbook/make_by_year_response.dart';
import 'package:valuation_tool_web/models/blackbook/vehicle_by_make_response.dart';
import 'package:valuation_tool_web/models/retail_statistics_response.dart';
import 'package:valuation_tool_web/models/vehicle_response.dart';
import 'package:valuation_tool_web/app/utils/api/api_interceptor.dart';
import 'package:valuation_tool_web/services/blackbook/black_book_vehicle_api_service.dart';

abstract class BlackBookRepository {
  Future<VehicleResponse> getVehicleByVin({
    required String vin,
  });
  Future<VehicleResponse> getVehicleByUvc({
    required String uvc,
  });

  Future<RetailStatisticsResponse> searchRetailStatsByVIN({
    required String vin,
    required String mileage,
    required String zipcode,
  });

  Future<RetailStatisticsResponse> searchRetailStatsByUVC({
    required String uvc,
    required String mileage,
    required String zipcode,
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

  @override
  Future<RetailStatisticsResponse> searchRetailStatsByUVC(
      {required String uvc, required String mileage, required String zipcode}) {
    return _apiService.searchRetailStatsByUVC(
        uvc: uvc, maximumMileage: mileage, zipcode: zipcode);
  }

  @override
  Future<RetailStatisticsResponse> searchRetailStatsByVIN(
      {required String vin, required String mileage, required String zipcode}) {
    return _apiService.searchRetailStatsByVIN(
        vin: vin, maximumMileage: mileage, zipcode: zipcode);
  }
}
