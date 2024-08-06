import 'package:flutter/material.dart';
import 'package:flutter_api_fallback/features/product/data/repos/product_repo_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/product/presentation/controllers/home_cubit.dart';
import 'features/product/presentation/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Assuming DioHelper.init() is a necessary setup step.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the repository
    final productRepository = ProductRepoImpl();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => HomeCubit(ProductRepoImpl()),
        child: const HomeScreen(),
      ),
    );
  }
}
