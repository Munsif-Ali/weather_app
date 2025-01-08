import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/app_const.dart';
import 'package:weather_app/extensions/date_extensions.dart';
import 'package:weather_app/theme/app_colors.dart';

import '../providers/cities_list_provider.dart';
import '../widgets/add_city_dialog.dart';
import '../widgets/cities_shimmer_list.dart';
import '../widgets/time_text_widget.dart';

class CitiesPage extends StatelessWidget {
  const CitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cities')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Consumer<CitiesListProvider>(
          builder: (context, provider, child) {
            if (provider.cities.isEmpty) {
              return const Center(child: Text('No cities added yet'));
            }

            if (provider.isLoading) {
              return CitiesShimmerList();
            }

            return AnimationLimiter(
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: provider.cities.length,
                itemBuilder: (context, index) {
                  final city = provider.cities[index];
                  final isPinned = provider.pinnedCityId == city.id;
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      duration: const Duration(milliseconds: 375),
                      child: FadeInAnimation(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                getWeatherTileColor(
                                        city.list.first.weather.first.icon)
                                    .withAlpha(150),
                                getWeatherTileColor(
                                    city.list.first.weather.first.icon),
                              ],
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                AppConst.iconUrl.replaceFirst(
                                  '{icon}',
                                  "${city.list.first.weather.first.icon}@4x",
                                ),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        'Updated at: ${city.updatedAt.formattedTime}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time_rounded,
                                          size: 15,
                                        ),
                                        SizedBox(width: 5),
                                        TimeTextWidget(
                                          timezone: city.timezone,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Image.network(
                                          AppConst.iconUrl.replaceFirst(
                                            '{icon}',
                                            city.currentWeather.weather.first
                                                .icon,
                                          ),
                                          width: 30,
                                        ),
                                        Text(
                                          city.currentWeather.weather.first
                                              .main,
                                        ),
                                      ],
                                    ),
                                    // Temperature
                                    Row(
                                      children: [
                                        Text(
                                          city.currentWeather.main.temp
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          '°C',
                                          style: const TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        provider.pinCity(city);
                                      },
                                      icon: Icon(
                                        isPinned
                                            ? Icons.push_pin
                                            : Icons.push_pin_outlined,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        if (isPinned) {
                                          provider
                                              .pinCity(provider.cities.first);
                                        }
                                        provider.removeCity(city.id);
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'addCity',
        onPressed: () {
          // showDialog(context: context, builder: (context) => AddCItyDialog());
          showGeneralDialog(
            context: context,
            pageBuilder: (context, animation1, animation2) {
              return AddCityDialog();
            },
            transitionDuration: const Duration(milliseconds: 500),
            transitionBuilder: (context, animation1, animation2, child) {
              return FadeTransition(
                opacity: animation1,
                child: Transform.scale(
                  scale: animation1.value,
                  child: child,
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
