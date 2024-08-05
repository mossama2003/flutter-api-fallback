import 'package:dio/dio.dart';
import '../end_points.dart';

class DioHelper {
  static late Dio _dio;

  /// Initialize Dio
  static Future<void> init() async {
    _dio = Dio(
      BaseOptions(
        baseUrl: BASE_URL,
        receiveTimeout: const Duration(seconds: 20),
        connectTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 20),
        receiveDataWhenStatusError: true,
        followRedirects: true,
        validateStatus: (status) => status! < 599,
      ),
    );
  }

  static Future<List<dynamic>> fetchData() async {
    List<dynamic> data;

    try {
      // Attempt to fetch data from the primary API
      Response response = await _dio.get(PRO);
      if (response.statusCode == 200) {
        data = response.data;
        if (data.isNotEmpty) {
          return data;
        }
      }
    } catch (e) {
      print('Primary API request failed: $e');
    }

    try {
      // If primary API fails or returns empty, fetch data from the secondary API
      Response response = await _dio.get(PRODUCTS);
      if (response.statusCode == 200) {
        data = response.data;
        return data;
      }
    } catch (e) {
      print('Secondary API request failed: $e');
      throw Exception('Failed to fetch data from both APIs');
    }
    return [];
  }
}