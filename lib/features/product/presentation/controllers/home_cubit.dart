import 'package:flutter/cupertino.dart';
import 'package:flutter_api_fallback/features/product/data/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import '../../data/repos/product_repo_impl.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeState> {
  final ProductRepoImpl productRepository;

  HomeCubit(this.productRepository) : super(HomeInitState());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> fetchData() async {
    emit(HomeLoadingState());

    final Either<String, List<ProductModel>> result = await productRepository.fetchProducts();

    result.fold(
          (failure) => emit(HomeErrorState(failure)),
          (products) => emit(HomeSuccessState(products)),
    );
  }
}
