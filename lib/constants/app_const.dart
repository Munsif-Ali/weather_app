import 'package:flutter/material.dart';

class AppConst {
  // Hive Box
  static const String settingsBox = 'settingsBox';
  static const String weatherDataBox = 'weatherDataBox';

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static const String iconUrl = "http://openweathermap.org/img/wn/{icon}.png";

  static const String isDarkModeKey = 'isDarkMode';
  static const String pinnedCityIdKey = 'pinnedCityId';
}
