import 'package:enter_training_me/models/muscle_experience.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExercisedMuscleRadarRepartitionGraph extends StatefulWidget {
  final List<MuscleExperience> muscleExperiences;
  const ExercisedMuscleRadarRepartitionGraph(
      {Key? key, required this.muscleExperiences})
      : super(key: key);

  @override
  State<ExercisedMuscleRadarRepartitionGraph> createState() =>
      _ExercisedMuscleRadarRepartitionGraphState();
}

class _ExercisedMuscleRadarRepartitionGraphState
    extends State<ExercisedMuscleRadarRepartitionGraph> {
  int selectedDataSetIndex = -1;
  final gridColor = const Color(0xff68739f);
  final titleColor = const Color(0xff8c95db);
  final fashionColor = const Color(0xffe15665);
  final artColor = const Color(0xff63e7e5);
  final boxingColor = const Color(0xff83dea7);
  final entertainmentColor = Colors.white70;
  final offRoadColor = const Color(0xFFFFF59D);

  @override
  Widget build(BuildContext context) {
    var dataSets = showingDataSets();

    bool isNotEmpty = widget.muscleExperiences
        .any((muscleExperience) => muscleExperience.experience > 0);
    if (!isNotEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(child: Text("No data available")),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rawDataSets(widget.muscleExperiences)
                .asMap()
                .map((index, value) {
                  final isSelected = index == selectedDataSetIndex;
                  return MapEntry(
                    index,
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDataSetIndex = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        height: 26,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? gridColor.withOpacity(0.5)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(46),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 6),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInToLinear,
                              padding: EdgeInsets.all(isSelected ? 8 : 6),
                              decoration: BoxDecoration(
                                color: value.color,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInToLinear,
                              style: TextStyle(
                                color: isSelected ? value.color : gridColor,
                              ),
                              child: Text(value.title),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })
                .values
                .toList(),
          ),
          AspectRatio(
            aspectRatio: 1.3,
            child: RadarChart(
              RadarChartData(
                radarTouchData: RadarTouchData(
                    touchCallback: (FlTouchEvent event, response) {
                  if (!event.isInterestedForInteractions) {
                    setState(() {
                      selectedDataSetIndex = -1;
                    });
                    return;
                  }
                  setState(() {
                    selectedDataSetIndex =
                        response?.touchedSpot?.touchedDataSetIndex ?? -1;
                  });
                }),
                dataSets: dataSets,
                radarBackgroundColor: Colors.transparent,
                borderData: FlBorderData(show: false),
                radarBorderData: const BorderSide(color: Colors.transparent),
                titlePositionPercentageOffset: 0.2,
                titleTextStyle: TextStyle(color: titleColor, fontSize: 14),
                // getTitle: (index) {
                //   var muscle = widget.muscleExperiences[index].muscle;
                //   muscle = muscle[0].toUpperCase() + muscle.substring(1);
                //   return muscle.length > 5
                //       ? muscle.substring(0, 5) + "."
                //       : muscle;
                // },
                tickCount: 1,
                ticksTextStyle:
                    const TextStyle(color: Colors.transparent, fontSize: 10),
                tickBorderData: const BorderSide(color: Colors.transparent),
                gridBorderData: BorderSide(color: gridColor, width: 2),
              ),
              swapAnimationDuration: const Duration(milliseconds: 400),
            ),
          ),
        ],
      ),
    );
  }

  List<RadarDataSet> showingDataSets() {
    return rawDataSets(widget.muscleExperiences).asMap().entries.map((entry) {
      var index = entry.key;
      var rawDataSet = entry.value;

      final isSelected = index == selectedDataSetIndex
          ? true
          : selectedDataSetIndex == -1
              ? true
              : false;

      return RadarDataSet(
        fillColor: isSelected
            ? rawDataSet.color.withOpacity(0.2)
            : rawDataSet.color.withOpacity(0.05),
        borderColor:
            isSelected ? rawDataSet.color : rawDataSet.color.withOpacity(0.25),
        entryRadius: isSelected ? 3 : 2,
        dataEntries:
            rawDataSet.values.map((e) => RadarEntry(value: e)).toList(),
        borderWidth: isSelected ? 2.3 : 2,
      );
    }).toList();
  }

  List<RawDataSet> rawDataSets(List<MuscleExperience> muscleExperiences) {
    double min = muscleExperiences
        .map((e) => e.experience)
        .reduce((value, element) => (value > element ? element : value))
        .toDouble();
    double max = muscleExperiences
        .map((e) => e.experience)
        .reduce((value, element) => (value < element ? element : value))
        .toDouble();
    return [
      RawDataSet(
        title: 'Maximum',
        color: fashionColor,
        values: muscleExperiences.map((muscle) => max).toList(),
      ),
      RawDataSet(
        title: 'User',
        color: entertainmentColor,
        values: muscleExperiences
            .map((muscleExperience) => muscleExperience.experience.toDouble())
            .toList(),
      ),
      RawDataSet(
        title: 'Minimum',
        color: artColor,
        values: muscleExperiences.map((muscle) => min).toList(),
      ),
    ];
  }
}

class RawDataSet {
  final String title;
  final Color color;
  final List<double> values;

  RawDataSet({
    required this.title,
    required this.color,
    required this.values,
  });
}
