import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/widgets/analysis/series/muscle_activation_serie.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TrainingTypeRepartitionGraph extends StatefulWidget {
  final Map<String, double> typeRepartition;
  const TrainingTypeRepartitionGraph({Key? key, required this.typeRepartition})
      : super(key: key);

  @override
  State<TrainingTypeRepartitionGraph> createState() =>
      _TrainingTypeRepartitionGraphState();
}

class _TrainingTypeRepartitionGraphState
    extends State<TrainingTypeRepartitionGraph> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: AspectRatio(
        aspectRatio: 1,
        child: PieChart(
          PieChartData(
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 0,
              centerSpaceRadius: 0,
              sections: buildSections()),
        ),
      ),
    );
  }

  List<MuscleActivationSerie> getMuscleActivationSeriesFromTraining() {
    List<MuscleActivationSerie> muscleActivations = [
    ];
    var i = 0;
    List<Color> colors = [
      CustomTheme.middleGreen,
      Colors.grey,
      CustomTheme.green
    ];
    for (var element in widget.typeRepartition.entries) {
      i++;
      if (element.value != 0) {
        muscleActivations.add(MuscleActivationSerie(
            muscleName: element.key,
            ratio: element.value * 100,
            color: colors[i % colors.length]));
      }
    }

    return muscleActivations;
  }

  List<PieChartSectionData> buildSections() {
    // const List<MuscleActivationSerie> muscleActivations = [
    //   MuscleActivationSerie(
    //       muscleName: "Hypertrophy", ratio: 30, color: CustomTheme.middleGreen),
    //   MuscleActivationSerie(
    //       muscleName: "Strength", ratio: 40, color: Colors.grey),
    //   MuscleActivationSerie(
    //       muscleName: "Endurance", ratio: 30, color: CustomTheme.green)
    // ];

    var muscleActivations = getMuscleActivationSeriesFromTraining();
    final isTouched = false;
    final fontSize = isTouched ? 20.0 : 16.0;
    final radius = isTouched ? 110.0 : 100.0;
    final widgetSize = isTouched ? 55.0 : 40.0;

    return muscleActivations
        .map((muscleActivation) => PieChartSectionData(
              color: muscleActivation.color,
              value: 15,
              title: muscleActivation.muscleName,
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffffffff)),
              // badgeWidget: _Badge(
              //   'assets/worker-svgrepo-com.svg',
              //   size: widgetSize,
              //   borderColor: muscleActivation.color,
              // ),
              badgePositionPercentageOffset: .98,
            ))
        .toList();
  }
}

class _Badge extends StatelessWidget {
  final String svgAsset;
  final double size;
  final Color borderColor;

  const _Badge(
    this.svgAsset, {
    Key? key,
    required this.size,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: const Center(
        child: Icon(Icons.fitness_center),
      ),
    );
  }
}
