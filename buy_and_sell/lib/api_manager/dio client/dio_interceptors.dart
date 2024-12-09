import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data["header"]["errorCode"] == 401) {}
    return super.onResponse(response, handler);
  }
}
