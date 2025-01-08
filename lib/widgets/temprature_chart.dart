import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/weather_model.dart';

class TempratureChart extends StatelessWidget {
  const TempratureChart({super.key, required this.forecast});

  final List<Forecast> forecast;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() % 2 == 0) {
                    return Text(
                      '${value.toInt()} °C',
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
                    final DateTime dateTime =
                        DateTime.parse(forecast[value.toInt()].dtTxt);
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
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                for (var i = 0; i < 15; i++)
                  FlSpot(
                    i.toDouble(),
                    forecast[i].main.temp.toDouble(),
                  ),
              ],
              isCurved: true,
              barWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}
