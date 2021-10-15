import 'dart:math';

import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/widgets/analysis/series/workout_intensity_over_time_serie.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class TrainingHistoryEvolution extends StatefulWidget {
  final List<Training> trainings;
  const TrainingHistoryEvolution({Key? key, required this.trainings})
      : super(key: key);

  @override
  State<TrainingHistoryEvolution> createState() =>
      _TrainingHistoryEvolutionState();
}

class _TrainingHistoryEvolutionState extends State<TrainingHistoryEvolution> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  List<FlSpot> generateSpotFromTrainings() {
    List<FlSpot> spots = [];
    /*
              [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          */
    for (var i = 0; i < widget.trainings.length; i++) {
      spots.add(FlSpot(i.toDouble(), widget.trainings[i].intensity.toDouble()));
    }
    return spots;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Color(0xff232d37)),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 18.0, left: 12.0, top: 24, bottom: 12),
              child: LineChart(
                mainData(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    double minY = widget.trainings
            .map((e) => e.intensity)
            .reduce((value, element) => min(value, element))
            .toDouble() -
        200;
    double maxY = widget.trainings
            .map((e) => e.intensity)
            .reduce((value, element) => max(value, element))
            .toDouble() +
        200;

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            return "${value.toInt()}";
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: (maxY - minY) / 4,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            return "${value.toInt()}";
          },
          reservedSize: 50,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: widget.trainings.length.toDouble() - 1,
      minY: minY,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: generateSpotFromTrainings(),
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
