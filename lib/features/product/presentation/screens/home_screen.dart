import 'package:flutter/material.dart';
import 'package:flutter_api_fallback/core/style/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/custom_widgets/custom_text_button.dart';
import '../controllers/home_cubit.dart';
import '../controllers/home_states.dart';
import '../../../../core/app_helper/show_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Center(child: Text('Products',
        style: TextStyle(color: AppColors.white),)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoadingState) {
                    return const CircularProgressIndicator();
                  } else if (state is HomeSuccessState) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showPopupDialog(
                        context,
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: state.products.map((product) {
                            return ListTile(
                              title: Text(product.title),
                              subtitle: Text('\$${product.price}'),
                            );
                          }).toList(),
                        ),
                      );
                    });
                    return const SizedBox();
                  } else if (state is HomeErrorState) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showPopupDialog(context, Text(state.message));
                    });
                    return const SizedBox();
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(height: 20),
              CustomTextButton(text: 'Fetch Data', onTap: () => context.read<HomeCubit>().fetchData(),)

            ],
          ),
        ),
      ),
    );
  }
}
