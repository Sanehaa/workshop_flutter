import 'package:buy_and_sell/api_manager/dio%20client/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../api_manager/dio client/dio_client.dart';

class OrderServiceProvider extends ChangeNotifier {
  final Dio _dio = DioClient.dio;

  bool _isLoading = false;
  String? _errorMessage;
  Map<String, dynamic>? _orderResponse;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Map<String, dynamic>? get orderResponse => _orderResponse;

  Future<void> createOrder(Map<String, dynamic> orderData) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _dio.post(Endpoints.checkout, data: orderData);
      _orderResponse = response.data;
      print('Order created: $_orderResponse');
    } on DioError catch (e) {
      if (e.response != null) {
        _errorMessage = e.response?.data['message'] ?? 'Failed to create order.';
      } else {
        _errorMessage = 'Unexpected error: ${e.message}';
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
