import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF1E90FF);
  static const Color secondary = Color(0xFF00BFFF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color alert = Color(0xFFDC143C);
  static const Color success = Color(0xFF32CD32);
  static const Color darkModeShimmer1stColor = Color(0xFF2D2D2D);
  static const Color lightModeShimmer1stColor = Color(0xFFE0E0E0);
  static const Color darkModeShimmer2ndColor = Color(0xFF4F4F4F);
  static const Color lightModeShimmer2ndColor = Color(0xFFFFFFFF);
}

Color getWeatherTileColor(String condition) {
  switch (condition) {
    case '01d':
    case '01n':
      return Color(0xFF87CEEB);
    case '02d':
    case '02n':
      return Color(0xFFADD8E6);
    case '03d':
    case '03n':
      return Color(0xFFB0C4DE);
    case '04d':
    case '04n':
      return Color(0xFFA9A9A9);
    case '09d':
    case '09n':
      return Color(0xFF778899);
    case '10d':
    case '10n':
      return Color(0xFF4682B4);
    case '11d':
    case '11n':
      return Color(0xFF800080);
    case '13d':
    case '13n':
      return Color(0xFFFFFFFF);
    case '50d':
    case '50n':
      return Color(0xFFD3D3D3);
    default:
      return Colors.grey;
  }
}
