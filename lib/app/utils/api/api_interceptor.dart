import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ApiInterceptor extends Interceptor {
  Logger logger = Logger(
    filter: null, // Use the default LogFilter (-> only log in debug mode)
    printer: PrettyPrinter(), // Use the PrettyPrinter to format and print log
    output: null, // Use the default LogOutput (-> send everything to console)
  );
  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    logger.d('RESPONSE STATUSCODE: ${response.statusCode}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    logger.d('ERROR: $err');
    return super.onError(err, handler);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    logger.d('REQUEST URL: ${options.uri}');
    logger.d('REQUEST BODY: ${options.data}');
    if (options.baseUrl.contains('service.blackbookcloud.com')) {
      options.headers.addAll(<String, dynamic>{
        'Authorization': 'Basic Z3JlZW5saWdodF9BUElfVUM6dXRhaDg0MDQy',
      });
    }
    return super.onRequest(options, handler);
  }
}
