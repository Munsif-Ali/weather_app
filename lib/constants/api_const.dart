import 'package:flutter/material.dart';

class ApiConst {
  static String baseUrl = "http://api.openweathermap.org/data/2.5/";
  static String weatherForcast =
      "/forecast?appid={API_KEY}&q={CITY_NAME}&units=metric&lat={LAT}&lon={LON}";
}
