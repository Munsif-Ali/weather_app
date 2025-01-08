import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/app_const.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/cities_page.dart';
import 'package:weather_app/providers/cities_list_provider.dart';
import 'package:weather_app/widgets/app_drawer.dart';

import '../helpers/helper_functions.dart';
import '../widgets/humidity_bar_chart.dart';
import '../widgets/temprature_chart.dart';
import '../widgets/wind_bar_chart.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  // static const Map<String, dynamic> weatherData = {
  //   "cod": "200",
  //   "message": 0,
  //   "cnt": 40,
  //   "list": [
  //     {
  //       "dt": 1735981200,
  //       "main": {
  //         "temp": 273.15,
  //         "feels_like": 273.15,
  //         "temp_min": 273.15,
  //         "temp_max": 275.62,
  //         "pressure": 1018,
  //         "sea_level": 1018,
  //         "grnd_level": 1013,
  //         "humidity": 93,
  //         "temp_kf": -2.47
  //       },
  //       "weather": [
  //         {
  //           "id": 804,
  //           "main": "Clouds",
  //           "description": "overcast clouds",
  //           "icon": "04d"
  //         }
  //       ],
  //       "clouds": {"all": 100},
  //       "wind": {"speed": 1.25, "deg": 160, "gust": 3.31},
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {"pod": "d"},
  //       "dt_txt": "2025-01-04 09:00:00"
  //     },
  //     {
  //       "dt": 1736402400,
  //       "main": {
  //         "temp": 274.94,
  //         "feels_like": 270.74,
  //         "temp_min": 274.94,
  //         "temp_max": 274.94,
  //         "pressure": 1000,
  //         "sea_level": 1000,
  //         "grnd_level": 996,
  //         "humidity": 77,
  //         "temp_kf": 0
  //       },
  //       "weather": [
  //         {
  //           "id": 804,
  //           "main": "Clouds",
  //           "description": "overcast clouds",
  //           "icon": "04n"
  //         }
  //       ],
  //       "clouds": {"all": 100},
  //       "wind": {"speed": 4.53, "deg": 12, "gust": 10.61},
  //       "visibility": 10000,
  //       "pop": 0,
  //       "sys": {"pod": "n"},
  //       "dt_txt": "2025-01-09 06:00:00"
  //     }
  //   ],
  //   "city": {
  //     "id": 2643743,
  //     "name": "London",
  //     "coord": {"lat": 51.5085, "lon": -0.1257},
  //     "country": "GB",
  //     "population": 1000000,
  //     "timezone": 0,
  //     "sunrise": 1735977931,
  //     "sunset": 1736006705
  //   }
  // };
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CitiesListProvider>();
    final pinnedCity = provider.pinnedCity;
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Forecast'),
        actions: [
          IconButton(
            icon: Icon(Icons.list_alt),
            onPressed: () {
              context.read<CitiesListProvider>().loadCities();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CitiesPage(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: pinnedCity == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    child: Icon(
                      Icons.warning,
                      size: 100,
                      color: Colors.red,
                    ),
                  ),
                  /* Image.asset(
                    'assets/images/illustration.png',
                    height: 200,
                  ), */
                  Text(
                    "No City Selected Yet\nPlease Add one from the cities page",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              )
            : ListView(
                children: [
                  // City Information
                  SectionTitle('City Information'),
                  buildRowData('City Name:', pinnedCity.name),
                  buildRowData('Country:', pinnedCity.country),
                  GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      InfoContainer(
                        title: "Time",
                        icon: Icons.access_time,
                        value: changeTimeToAnotherTimeZone(
                          DateTime.now(),
                          pinnedCity.timezone,
                        ),
                      ),
                      InfoContainer(
                        title: "Population",
                        icon: Icons.people,
                        value: "${pinnedCity.population}",
                      ),
                      InfoContainer(
                        title: "Sunrise",
                        icon: Icons.wb_sunny,
                        value: changeTimeToAnotherTimeZone(
                          DateTime.fromMillisecondsSinceEpoch(
                              pinnedCity.sunrise * 1000),
                          pinnedCity.timezone,
                        ),
                      ),
                      InfoContainer(
                        title: "Sunset",
                        icon: Icons.nightlight_round,
                        value: changeTimeToAnotherTimeZone(
                          DateTime.fromMillisecondsSinceEpoch(
                              pinnedCity.sunset * 1000),
                          pinnedCity.timezone,
                        ),
                      ),
                    ],
                  ),

                  // Weather Details
                  SectionTitle('Current Weather'),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Row(
                      children: [
                        Image.network(
                          AppConst.iconUrl.replaceAll(
                            '{icon}',
                            pinnedCity.currentWeather.weather.first.icon,
                          ),
                          height: 50,
                        ),
                        SizedBox(width: 8),
                        Text(
                          pinnedCity.currentWeather.weather.first.description,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      InfoContainer(
                        title: "Temperature",
                        icon: Icons.thermostat_outlined,
                        value:
                            "${pinnedCity.currentWeather.main.temp.toStringAsFixed(2)} °C",
                      ),
                      InfoContainer(
                        title: "Feels Like",
                        icon: Icons.thermostat_outlined,
                        value:
                            "${pinnedCity.currentWeather.main.feelsLike.toStringAsFixed(2)} °C",
                      ),
                      InfoContainer(
                        title: "Humidity",
                        icon: Icons.water_damage,
                        value: "${pinnedCity.currentWeather.main.humidity}%",
                      ),
                      InfoContainer(
                        title: "Sea Level",
                        icon: Icons.water,
                        value: "${pinnedCity.currentWeather.main.seaLevel}",
                      ),
                    ],
                  ),

                  // Wind Details
                  SectionTitle('Wind Details'),

                  GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      InfoContainer(
                        title: "Speed",
                        icon: Icons.speed,
                        value: "${pinnedCity.currentWeather.wind.speed} m/s",
                      ),
                      InfoContainer(
                        title: "Direction",
                        icon: Icons.navigation,
                        value: "${pinnedCity.currentWeather.wind.deg}°",
                      ),
                      InfoContainer(
                        title: "Gust",
                        icon: Icons.air,
                        value: "${pinnedCity.currentWeather.wind.gust} m/s",
                      ),
                    ],
                  ),

                  // Charts
                  SectionTitle('Temperature Chart'),
                  TempratureChart(forecast: pinnedCity.list),

                  SectionTitle('Humidity Chart'),
                  HumidityBarChart(forecast: pinnedCity.list),

                  SectionTitle('Wind Speed'),
                  WindBarChart(forecast: pinnedCity.list),

                  SizedBox(height: 50),
                ],
              ),
      ),
    );
  }

  Widget buildRowData(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          Text(value, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.title, {super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}

class InfoContainer extends StatelessWidget {
  const InfoContainer({
    super.key,
    required this.value,
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).cardColor,
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Icon(
                icon,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                value,
                style: TextStyle(fontSize: 18),
              ),
            ],
          )
        ],
      ),
    );
  }
}
