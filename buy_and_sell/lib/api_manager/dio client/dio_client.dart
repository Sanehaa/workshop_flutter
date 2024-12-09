import 'package:buy_and_sell/api_manager/dio%20client/endpoints.dart';
import 'package:dio/dio.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.117.37:3000',
      connectTimeout: Endpoints.connectionTimeout,
      receiveTimeout: Endpoints.receiveTimeout,
    ),
  );

  static Dio get dio => _dio;
}
