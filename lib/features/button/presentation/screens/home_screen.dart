import 'package:flutter/material.dart';
import 'package:flutter_api_fallback/core/constants/app_size.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_api_fallback/core/custom_widgets/custom_text_button.dart';

import '../../../../core/app_helper/show_dialog.dart';
import '../controllers/home_cubit.dart';
import '../controllers/home_states.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void showPopup(BuildContext context, String data) {
    showPopupDialog(context, SingleChildScrollView(child: Text(data)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSize.widthScale(context, 20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoadingState) {
                  return const CircularProgressIndicator();
                } else if (state is HomeSuccessState) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showPopup(context, state.data);
                  });
                } else if (state is HomeErrorState) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showPopup(context, state.message);
                  });
                }
                return const SizedBox();
              },
            ),
            SizedBox(height: AppSize.heightScale(context, 20)),
            CustomTextButton(
              text: 'Fetch Data',
              onTap: () => context.read<HomeCubit>().fetchData(),
            ),
          ],
        ),
      ),
    );
  }
}
