import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/app_const.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/cities_page.dart';
import 'package:weather_app/pages/home_page.dart';
import 'package:weather_app/theme/app_theme.dart';

import 'providers/cities_list_provider.dart';
import 'providers/theme_provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  // Initialize Hive
  await Hive.initFlutter();

  // Open boxes
  await Hive.openBox(AppConst.weatherDataBox);
  await Hive.openBox(AppConst.settingsBox);

  // Hive Adapter
  Hive.registerAdapter(WeatherModelAdapter());
  // make the animation slower
  timeDilation = 2;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CitiesListProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: "Weather App",
            themeMode:
                themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            navigatorKey: AppConst.navigatorKey,
            darkTheme: AppTheme.darkTheme,
            theme: AppTheme.lightTheme,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
