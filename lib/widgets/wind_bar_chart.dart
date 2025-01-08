import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/weather_model.dart';

class WindBarChart extends StatelessWidget {
  const WindBarChart({super.key, required this.forecast});

  final List<Forecast> forecast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WindBarChartLegend(),
        const SizedBox(height: 8),
        SizedBox(
          height: 200,
          child: BarChart(
            BarChartData(
              gridData: FlGridData(show: false),
              borderData: FlBorderData(
                border: Border(
                  bottom: BorderSide(color: Colors.black),
                  left: BorderSide(color: Colors.black),
                ),
              ),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    reservedSize: 60,
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      if (value.toInt() % 2 == 0) {
                        final DateTime dateTime = DateTime.parse(
                          // weatherData['list'][value.toInt()]
                          //     ['dt_txt'],
                          forecast[value.toInt()].dtTxt,
                        );
                        final format = DateFormat('hh:mm a');
                        return RotatedBox(
                          quarterTurns: 3,
                          child: Text(
                            format.format(dateTime),
                            style: TextStyle(fontSize: 10),
                            maxLines: 1,
                          ),
                        );
                      }
                      return SizedBox();
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    maxIncluded: false,
                    getTitlesWidget: (value, meta) {
                      if (value.toInt() % 1 == 0) {
                        return Text(
                          '${value.toInt()} m/s',
                          style: TextStyle(fontSize: 10),
                        );
                      }
                      return SizedBox();
                    },
                  ),
                ),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              barGroups: [
                for (var i = 0; i < 7; i++)
                  BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        // toY: weatherData['list'][i]['wind']['speed']
                        //     .toDouble(),
                        toY: forecast[i].wind.speed.toDouble(),
                        color: Colors.blueAccent,
                      ),
                      BarChartRodData(
                        // toY: weatherData['list'][i]['wind']['gust']
                        //     .toDouble(),
                        toY: forecast[i].wind.gust.toDouble(),
                        color: Colors.redAccent,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class WindBarChartLegend extends StatelessWidget {
  const WindBarChartLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        LegendItem(color: Colors.blueAccent, text: 'Wind Speed'),
        SizedBox(width: 16),
        LegendItem(color: Colors.redAccent, text: 'Wind Gust'),
      ],
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({
    super.key,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(text),
      ],
    );
  }
}
