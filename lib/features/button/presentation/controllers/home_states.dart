import 'package:flutter/foundation.dart';

@immutable
abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final String data;

  HomeSuccessState(this.data);
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState(this.message);
}
