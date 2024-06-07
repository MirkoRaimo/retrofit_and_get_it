import 'package:dio/dio.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.I;
void setupLocator() {
  // final Dio dio = Dio(BaseOptions(contentType: 'application/json'));
  // locator.registerSingleton<ApiService>(ApiService(dio));

  final dio = Dio(); // Provide a dio instance
  dio.options.headers['Demo-Header'] =
      'demo header'; // config your dio headers globally
  final client = ApiService(dio);
  locator.registerSingleton<ApiService>(client);
}
