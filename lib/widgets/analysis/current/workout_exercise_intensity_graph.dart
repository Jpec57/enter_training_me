import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WorkoutExerciseIntensityGraph extends StatefulWidget {
  final Training realisedTraining;
  final Training? referenceTraining;
  final double barWidth;
  final double barsSpace;
  final double groupSpace;
  final double graphHeight;

  const WorkoutExerciseIntensityGraph(
      {Key? key,
      required this.realisedTraining,
      this.referenceTraining,
      this.graphHeight = 250.0,
      this.barWidth = 50.0,
      this.groupSpace = 10.0,
      this.barsSpace = 10.0})
      : super(key: key);

  @override
  State<WorkoutExerciseIntensityGraph> createState() =>
      _WorkoutExerciseIntensityGraphState();
}

class _WorkoutExerciseIntensityGraphState
    extends State<WorkoutExerciseIntensityGraph> {
  final Color leftBarColor = CustomTheme.grey;
  final Color rightBarColor = Colors.white;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  BarChartGroupData makeGroupData(
      {required int x, required double y1, double? y2}) {
    List<BarChartRodData> rods = [
      BarChartRodData(
          y: y1,
          colors: [leftBarColor],
          width: widget.barWidth,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )),
    ];

    if (y2 != null) {
      rods.add(
        BarChartRodData(
            y: y2,
            colors: [rightBarColor],
            width: widget.barWidth,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            )),
      );
    }

    return BarChartGroupData(
      barsSpace: widget.barsSpace,
      x: x,
      barRods: rods,
      showingTooltipIndicators: [rods.length - 1],
    );
  }

  List<BarChartGroupData> buildDataFromTraining(
      {required Training realisedTraining, Training? referenceTraining}) {
    List<BarChartGroupData> barGroups = [];

    List<RealisedExercise> realisedExos = realisedTraining.exercisesAsFlatList;
    List<RealisedExercise>? refExos = referenceTraining?.exercisesAsFlatList;

    int k = 0;
    for (var i = 0; i < realisedExos.length; i++) {
      var currentExo = realisedExos[i];

      if (refExos != null && i < refExos.length) {
        var refExo = refExos[i];
        barGroups.add(makeGroupData(
            x: k,
            y1: refExo.maxEstimated1RMInSet,
            y2: currentExo.maxEstimated1RMInSet));
        // barGroups.add(makeGroupData(
        // x: k, y1: refExo.intensity, y2: currentExo.intensity));
      } else {
        // barGroups.add(makeGroupData(x: i, y1: currentExo.intensity));
        barGroups.add(makeGroupData(x: i, y1: currentExo.maxEstimated1RMInSet));
      }
      k++;
    }

    return barGroups;
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.black,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
                rod.y.round().toString(),
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center);
          },
        ),
      );

  @override
  void initState() {
    super.initState();
    final List<BarChartGroupData> items = buildDataFromTraining(
        realisedTraining: widget.realisedTraining,
        referenceTraining: widget.referenceTraining);
    rawBarGroups = items;
    showingBarGroups = items;
  }

  double get maxY {
    double max = 0;
    for (var group in rawBarGroups) {
      for (var rod in group.barRods) {
        var y = rod.y;
        if (max < y) {
          max = y;
        }
      }
    }
    return max * 1.1;
  }

  @override
  Widget build(BuildContext context) {
    double minWidth = MediaQuery.of(context).size.width;
    double graphWidth =
        ((widget.realisedTraining.exercisesAsFlatList.length) + 1) *
            (widget.barWidth * 2 + widget.barsSpace + widget.groupSpace);
    if (graphWidth < minWidth) {
      graphWidth = minWidth;
    }

    return SizedBox(
      height: widget.graphHeight,
      width: graphWidth,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: graphWidth,
          child: BarChart(
            BarChartData(
              maxY: maxY,
              titlesData: FlTitlesData(
                show: true,
                leftTitles: SideTitles(
                  showTitles: true,
                  getTextStyles: (context, value) => const TextStyle(
                      color: Color(0xff7589a2),
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                  reservedSize: 50,
                  interval: (maxY > 0 ? maxY : 10) / 5,
                  getTitles: (value) {
                    if (value >= 1000) {
                      var units = (value % 1000).toInt();
                      return "${value ~/ 1000}K${units > 0 ? units.toString() : ""}";
                    }
                    return value.toInt().toString();
                  },
                ),
                rightTitles: SideTitles(showTitles: false),
                topTitles: SideTitles(showTitles: false),
                bottomTitles: SideTitles(
                  showTitles: true,
                  // rotateAngle: 90,
                  reservedSize: widget.graphHeight * 0.3,
                  getTextStyles: (context, value) => const TextStyle(
                      color: Color(0xff7589a2),
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 14),
                  margin: 10,
                  getTitles: (double value) {
                    return "E${value.toInt()}";
                    return widget
                        .realisedTraining
                        .exercisesAsFlatList[value.toInt() %
                            widget.realisedTraining.exercisesAsFlatList.length]
                        .exerciseReference
                        .shortName;
                  },
                ),
              ),
              // rangeAnnotations: RangeAnnotations(
              //     verticalRangeAnnotations: [
              //       VerticalRangeAnnotation(
              //           x1: 0, x2: 100, color: Colors.yellow)
              //     ]),
              borderData: FlBorderData(
                show: false,
              ),
              barGroups: showingBarGroups,
              barTouchData: barTouchData,

              groupsSpace: widget.groupSpace,
              gridData: FlGridData(
                  show: true,
                  drawHorizontalLine: true,
                  drawVerticalLine: true,
                  verticalInterval: 50),
            ),
          ),
        ),
      ),
    );
  }
}
