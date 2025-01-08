import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/weather_model.dart';

class HumidityBarChart extends StatelessWidget {
  const HumidityBarChart({super.key, required this.forecast});

  final List<Forecast> forecast;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
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
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() % 10 == 0) {
                    return Text(
                      '${value.toInt()}%',
                      style: TextStyle(fontSize: 10),
                    );
                  }
                  return SizedBox();
                },
              ),
            ),
            bottomTitles: AxisTitles(
              axisNameWidget: Text(
                'Time',
                style: TextStyle(fontSize: 16),
              ),
              sideTitles: SideTitles(
                reservedSize: 60,
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
                showTitles: true,
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          barGroups: [
            for (var i = 0; i < 15; i++)
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    // toY: weatherData['list'][i]['main']
                    //         ['humidity']
                    //     .toDouble(),
                    toY: forecast[i].main.humidity.toDouble(),
                  ),
                ],
              ),
          ],
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  // '${weatherData['list'][group.x.toInt()]['main']['humidity']}%',
                  '${forecast[group.x.toInt()].main.humidity}%',
                  TextStyle(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
