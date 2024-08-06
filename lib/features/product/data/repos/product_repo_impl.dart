import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_api_fallback/features/product/data/models/product_model.dart';
import 'package:flutter_api_fallback/features/product/data/repos/product_repo.dart';

class ProductRepoImpl implements ProductRepo {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://fakestoreapi.com'));

  @override
  Future<Either<String, List<ProductModel>>> fetchProducts() async {
    try {
      // Try fetching from the PRO endpoint first
      final response = await _dio.get('/pro');
      if (response.statusCode == 200 && response.data.isNotEmpty) {
        final List<ProductModel> products = (response.data as List)
            .map((json) => ProductModel.fromJson(json))
            .toList();
        return Right(products);
      } else {
        // If the PRO endpoint is empty, try the PRODUCTS endpoint
        return await _fetchFromProducts();
      }
    } catch (e) {
      // If there's an error, try the PRODUCTS endpoint
      return await _fetchFromProducts();
    }
  }

  Future<Either<String, List<ProductModel>>> _fetchFromProducts() async {
    try {
      final response = await _dio.get('/products');
      if (response.statusCode == 200) {
        final List<ProductModel> products = (response.data as List)
            .map((json) => ProductModel.fromJson(json))
            .toList();
        return Right(products);
      } else {
        return const Left('Failed to load products from both endpoints');
      }
    } catch (e) {
      return Left('Failed to load products from both endpoints: $e');
    }
  }
}
