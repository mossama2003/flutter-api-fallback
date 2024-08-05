import 'package:flutter/cupertino.dart';

class AppSize {
  static const double _baseWidth = 334;
  static const double _baseHeight = 502;

  static double widthScale(BuildContext context, double size) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return size * (screenWidth / _baseWidth);
  }

  static double heightScale(BuildContext context, double size) {
    final double screenWidth = MediaQuery.of(context).size.height;
    return size * (screenWidth / _baseHeight);
  }

  static double textScale(BuildContext context, double size) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return size * (screenWidth / _baseWidth);
  }
}
