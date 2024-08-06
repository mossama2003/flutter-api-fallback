import 'package:flutter_api_fallback/features/product/data/models/product_model.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final List<ProductModel> products;

  HomeSuccessState(this.products);
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState(this.message);
}
