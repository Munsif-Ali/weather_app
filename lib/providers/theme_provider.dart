import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:weather_app/constants/app_const.dart';

class ThemeProvider extends ChangeNotifier {
  late final Box _settingsBox;

  bool get isDarkMode => _settingsBox.get(AppConst.isDarkModeKey) ?? false;

  ThemeProvider() {
    _settingsBox = Hive.box(AppConst.settingsBox);
  }

  void toggleTheme() {
    _settingsBox.put(AppConst.isDarkModeKey, !isDarkMode);
    notifyListeners();
  }
}
