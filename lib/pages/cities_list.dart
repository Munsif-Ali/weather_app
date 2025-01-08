import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_model.dart';

import '../providers/cities_list_provider.dart';
import '../theme/app_colors.dart';

class CityListScreen extends StatefulWidget {
  const CityListScreen({super.key});

  @override
  State<CityListScreen> createState() => _CityListScreenState();
}

class _CityListScreenState extends State<CityListScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late List<WeatherModel> cities;

  @override
  void initState() {
    super.initState();
    cities = context.read<CitiesListProvider>().cities;
  }

  void _pinCity(city) {
    setState(() {
      final currentIndex = cities.indexOf(city);
      if (currentIndex > 0) {
        // Remove city from its current position
        final removedCity = cities.removeAt(currentIndex);

        // Insert the city at the top
        cities.insert(0, removedCity);

        // Animate the change
        _listKey.currentState?.removeItem(
          currentIndex,
          (context, animation) => _buildCityTile(city, animation),
        );
        _listKey.currentState?.insertItem(0);
      }
    });
  }

  Widget _buildCityTile(WeatherModel city, Animation<double> animation) {
    final provider = context.read<CitiesListProvider>();
    return SizeTransition(
      sizeFactor: animation,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [
              getWeatherTileColor(city.list.first.weather.first.icon)
                  .withAlpha(150),
              getWeatherTileColor(city.list.first.weather.first.icon),
            ],
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    city.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    city.country,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () => _pinCity(city),
                  icon: Icon(
                    provider.pinnedCityId == city.id
                        ? Icons.push_pin
                        : Icons.push_pin_outlined,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (provider.pinnedCityId == city.id) {
                      provider.pinCity(provider.cities.first);
                    }
                    provider.removeCity(city.id);
                    _removeCity(city);
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _removeCity(city) {
    setState(() {
      final index = cities.indexOf(city);
      cities.removeAt(index);
      _listKey.currentState?.removeItem(
        index,
        (context, animation) => _buildCityTile(city, animation),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      initialItemCount: cities.length,
      itemBuilder: (context, index, animation) {
        final city = cities[index];
        return _buildCityTile(city, animation);
      },
    );
  }
}
