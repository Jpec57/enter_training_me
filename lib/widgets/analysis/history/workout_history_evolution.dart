import 'dart:math';
import 'package:enter_training_me/models/models.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class WorkoutHistoryEvolution extends StatefulWidget {
  final List<Training> trainings;
  const WorkoutHistoryEvolution({Key? key, required this.trainings})
      : super(key: key);

  @override
  State<WorkoutHistoryEvolution> createState() =>
      _WorkoutHistoryEvolutionState();
}

class _WorkoutHistoryEvolutionState extends State<WorkoutHistoryEvolution> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  List<FlSpot> generateSpotFromTrainings() {
    List<FlSpot> spots = [];

    for (var i = 0; i < widget.trainings.length; i++) {
      spots.add(FlSpot(i.toDouble(), widget.trainings[i].intensity.toDouble()));
    }
    return spots;
  }

  @override
  Widget build(BuildContext context) {
    var maxSpotPerSizeWidth = 10;
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
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                // 10 points per mobile width
                width: (widget.trainings.length > maxSpotPerSizeWidth
                    ? (MediaQuery.of(context).size.width /
                            maxSpotPerSizeWidth) *
                        widget.trainings.length
                    : MediaQuery.of(context).size.width),
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 18.0, left: 12.0, top: 24, bottom: 12),
                  child: LineChart(
                    mainData(),
                  ),
                ),
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
          reservedSize: 50,
          interval: 1,
          rotateAngle: 90,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 12),
          getTitles: (value) {
            int index = value.toInt();
            return (DateFormat.yMd())
                .format(widget.trainings[index].createdAt!);
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
      lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(getTooltipItems: (spots) {
        List<LineTooltipItem> items = [];
        for (var spot in spots) {
          items.add(LineTooltipItem("${spot.y}", const TextStyle()));
        }
        return items;
      })),
      lineBarsData: [
        LineChartBarData(
          spots: generateSpotFromTrainings(),
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
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
