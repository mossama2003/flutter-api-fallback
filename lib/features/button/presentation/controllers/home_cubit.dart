import 'package:flutter/cupertino.dart';
import 'package:flutter_api_fallback/core/data_source/remote/dio_helper.dart';
import 'package:flutter_api_fallback/features/button/data/repos/button_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_states.dart';


class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.repo) : super(HomeInitState());
  ButtonRepo repo;

  static HomeCubit get(BuildContext _) => BlocProvider.of(_);

  Future<void> fetchData() async {
    emit(HomeLoadingState());

    try {
      List<dynamic> data = await DioHelper.fetchData();
      emit(HomeSuccessState(data.toString()));
    } catch (e) {
      emit(HomeErrorState('Failed to fetch data from both APIs'));
    }
  }
}
