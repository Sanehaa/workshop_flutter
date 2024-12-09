import 'package:buy_and_sell/api_manager/dio%20client/dio_client.dart';
import 'package:buy_and_sell/api_manager/dio%20client/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../models/featured_product_model.dart';

class ProductProvider with ChangeNotifier {
  final Dio _dio = DioClient.dio;

  static const String _baseURL = 'http://192.168.7.108:3000';

  List<FeaturedProduct> _products = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<FeaturedProduct> get products => _products;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> loadProducts() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await _dio.get(Endpoints.getprods);
      final data = response.data;

      if (data is Map<String, dynamic> && data['products'] != null) {
        final List<dynamic> productsList = data['products'];
        _products = productsList.map((json) {
          final product = FeaturedProduct.fromJson(json);

          final updatedImages = product.images.map((image) => '$_baseURL$image').toList();

          return FeaturedProduct(
            id: product.id,
            name: product.name,
            description: product.description,
            price: product.price,
            images: updatedImages,
          );
        }).toList();
      } else {
        throw Exception('Unexpected response structure: $data');
      }
    } catch (e) {
      _errorMessage = 'Error loading products: $e';
      print(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
