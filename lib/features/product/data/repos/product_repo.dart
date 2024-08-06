import 'package:dartz/dartz.dart';
import 'package:flutter_api_fallback/features/product/data/models/product_model.dart';

abstract class ProductRepo {
  Future<Either<String, List<ProductModel>>> fetchProducts();
}
