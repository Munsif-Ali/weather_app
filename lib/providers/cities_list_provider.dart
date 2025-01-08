import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:weather_app/constants/api_const.dart';
import 'package:weather_app/constants/app_const.dart';
import 'package:weather_app/extensions/context_extensions.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/api_services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CitiesListProvider extends ChangeNotifier {
  List<WeatherModel> _cities = [];
  List<WeatherModel> get cities => _cities;

  WeatherModel? pinnedCity;

  late final ApiService _apiService;
  late final Box _citiesBox;
  late final Box _settingsBox;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  int? get pinnedCityId => pinnedCity?.id;

  CitiesListProvider() {
    _apiService = ApiService();
    _citiesBox = Hive.box(AppConst.weatherDataBox);
    _settingsBox = Hive.box(AppConst.settingsBox);

    final pinnedCityId = _settingsBox.get(AppConst.pinnedCityIdKey);
    if (pinnedCityId != null) {
      final pinnedCityData = _citiesBox.get(pinnedCityId);
      if (pinnedCityData != null) {
        pinnedCity = WeatherModel.fromJson(jsonDecode(pinnedCityData));
        checkAndUpdateCity(pinnedCityId);
      }
    }

    _cities = _citiesBox.values
        .map((e) => WeatherModel.fromJson(jsonDecode(e)))
        .toList();

    sortCities();
  }

  // Check city update time and update if needed
  Future<void> checkAndUpdateCity(int cityId) async {
    final cityData = _citiesBox.get(cityId);
    if (cityData != null) {
      final city = WeatherModel.fromJson(jsonDecode(cityData));
      final diff = DateTime.now().difference(city.updatedAt).inMinutes;
      if (diff > 30) {
        final apiKey = dotenv.env['OPENWEATHER_API_KEY'];
        final response = await _apiService.getRequest(
          ApiConst.weatherForcast
              .replaceFirst("{API_KEY}", apiKey!)
              .replaceFirst("{CITY_NAME}", city.name),
        );
        if (response.statusCode == 200 && response.data != null) {
          final data = response.data;
          data["updatedAt"] = DateTime.now().toIso8601String();
          final weatherModel = WeatherModel.fromJson(data);
          _cities.removeWhere((element) => element.id == cityId);
          _cities.add(weatherModel);
          await _citiesBox.put(
            weatherModel.id,
            jsonEncode(weatherModel.toJson()),
          );
          notifyListeners();
        }
      }
    }
  }

  Future<bool> addCity({
    String? cityName,
    Coord? coord,
    bool isPinned = false,
  }) async {
    assert(cityName != null || coord != null);
    _isLoading = true;
    notifyListeners();

    try {
      final apiKey = dotenv.env['OPENWEATHER_API_KEY'];
      log("ApiKey: $apiKey");
      String url = ApiConst.weatherForcast.replaceFirst(
        "{API_KEY}",
        apiKey!,
      );
      if (cityName != null) {
        url = url.replaceFirst("{CITY_NAME}", cityName);
        url = url.replaceFirst("{LAT}", "");
        url = url.replaceFirst("{LON}", "");
      } else {
        url = url.replaceFirst("{LAT}", "${coord!.lat}");
        url = url.replaceFirst("{LON}", "${coord.lon}");
        url = url.replaceFirst("{CITY_NAME}", "");
      }
      log("URL: $url");
      final response = await _apiService.getRequest(url);

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        data["updatedAt"] = DateTime.now().toIso8601String();
        final weatherModel = WeatherModel.fromJson(data);
        _cities.remove(weatherModel);
        _cities.add(weatherModel);
        if (pinnedCity == null || (coord != null && isPinned)) {
          pinnedCity = weatherModel;
          _settingsBox.put(AppConst.pinnedCityIdKey, weatherModel.id);
        }
        await _citiesBox.put(
          weatherModel.id,
          jsonEncode(weatherModel.toJson()),
        );
        sortCities();
        _isLoading = false;
        notifyListeners();
        return true;
      }

      _isLoading = false;
      notifyListeners();
      AppConst.navigatorKey.currentContext?.showSnackBar(
        "City not found",
        isError: true,
      );
      return false;
    } catch (e, st) {
      log(e.toString(), stackTrace: st);
      AppConst.navigatorKey.currentContext?.showSnackBar(
        "City not found",
        isError: true,
      );
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> loadCities() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 4));
    for (final city in _cities) {
      await checkAndUpdateCity(city.id);
    }
    _isLoading = false;
    sortCities();
  }

  void removeCity(int cityId) {
    _cities.removeWhere((element) => element.id == cityId);
    _citiesBox.delete(cityId);
    notifyListeners();
  }

  void pinCity(WeatherModel city) {
    pinnedCity = city;
    _settingsBox.put("pinnedCityId", city.id);
    sortCities();
  }

  void sortCities() {
    _cities.sort((a, b) {
      if (pinnedCity != null) {
        if (a.id == pinnedCity!.id) {
          return -1;
        } else if (b.id == pinnedCity!.id) {
          return 1;
        }
      }
      return a.name.compareTo(b.name);
    });
    notifyListeners();
  }
}
