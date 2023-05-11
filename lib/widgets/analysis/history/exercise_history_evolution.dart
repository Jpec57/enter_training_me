import 'dart:math';
import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/models/performance_set.dart';
import 'package:enter_training_me/services/repositories/performance_repository.dart';
import 'package:enter_training_me/widgets/lists/reference_exercise_list.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ExerciseHistoryEvolution extends StatefulWidget {
  final List<ReferenceExercise> referenceExercises;
  ExerciseHistoryEvolution({Key? key, this.referenceExercises = const []})
      : assert(referenceExercises.isNotEmpty),
        super(key: key);

  @override
  State<ExerciseHistoryEvolution> createState() =>
      _ExerciseHistoryEvolutionState();
}

class _ExerciseHistoryEvolutionState extends State<ExerciseHistoryEvolution> {
  late Future<List<PerformanceSet>> _setsFuture;
  late ReferenceExercise currentReferenceExercise;
  late ScrollController _scrollController;
  final double percentMargin = 0.05;

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    currentReferenceExercise = widget.referenceExercises.first;
    setState(() {
      _setsFuture = RepositoryProvider.of<PerformanceRepository>(context)
          .getPerfForReferenceExercise(currentReferenceExercise.id!);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future reloadSpots(ReferenceExercise? refExo) async {
    if (refExo != null) {
      currentReferenceExercise = refExo;
    }
    setState(() {
      _setsFuture = RepositoryProvider.of<PerformanceRepository>(context)
          .getPerfForReferenceExercise(currentReferenceExercise.id!)
          .then((value) {
        // _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        return value;
      });
    });
  }

  List<FlSpot> generateSpotFromSets(List<ExerciseSet> sets) {
    List<FlSpot> spots = [];

    for (var i = 0; i < sets.length; i++) {
      spots.add(FlSpot(i.toDouble(), sets[i].estimated1RM));
    }
    return spots;
  }

  LineChartData mainData(List<ExerciseSet> sets) {
    List<FlSpot> spots = generateSpotFromSets(sets);
    List<double> yCoordinates = spots.map((spot) => spot.y).toList();
    double minY = yCoordinates
            .reduce((value, element) => min(value, element))
            .toDouble() *
        (1 - percentMargin);
    double maxY = yCoordinates
            .reduce((value, element) => max(value, element))
            .toDouble() *
        (1 + percentMargin);

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
      // titlesData: FlTitlesData(
      //   show: true,
      //   rightTitles: SideTitles(showTitles: false),
      //   topTitles: SideTitles(showTitles: false),
      //   bottomTitles: SideTitles(
      //     showTitles: true,
      //     reservedSize: 50,
      //     interval: 1,
      //     rotateAngle: 90,
      //     getTextStyles: (context, value) => const TextStyle(
      //         color: Color(0xff68737d),
      //         fontWeight: FontWeight.bold,
      //         fontSize: 12),
      //     getTitles: (value) {
      //       int index = value.toInt();
      //       var date = sets[index].realisedDate;
      //       return date != null
      //           ? (DateFormat.yMd())
      //               .format(DateTime.fromMillisecondsSinceEpoch(date))
      //           : "Unknown";
      //     },
      //     margin: 8,
      //   ),
      //   leftTitles: SideTitles(
      //     showTitles: true,
      //     interval: (maxY - minY) / 4,
      //     getTextStyles: (context, value) => const TextStyle(
      //       color: Color(0xff67727d),
      //       fontWeight: FontWeight.bold,
      //       fontSize: 15,
      //     ),
      //     getTitles: (value) {
      //       return "${value.toInt()}";
      //     },
      //     reservedSize: 50,
      //     margin: 12,
      //   ),
      // ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: (spots.length.toDouble() - 1),
      minY: minY,
      maxY: maxY,
      lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(getTooltipItems: (spots) {
        List<LineTooltipItem> items = [];
        for (var spot in spots) {
          items.add(LineTooltipItem("${spot.y.toInt()}", const TextStyle()));
        }
        return items;
      })),
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          // colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            // colors:
            //     gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var maxSpotPerSizeWidth = 10;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
              color: Color(0xff232d37)),
          child: FutureBuilder(
            future: _setsFuture,
            builder: (BuildContext context,
                AsyncSnapshot<List<PerformanceSet>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData &&
                  snapshot.data!.isNotEmpty) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    child: SizedBox(
                      width: snapshot.data!.length > maxSpotPerSizeWidth
                          ? (MediaQuery.of(context).size.width /
                                  maxSpotPerSizeWidth) *
                              snapshot.data!.length
                          : MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 18.0, left: 12.0, top: 24, bottom: 12),
                        child: LineChart(
                          mainData(snapshot.data!.map((e) => e.set).toList()),
                        ),
                      ),
                    ),
                  ),
                );
              }
              return Text("${snapshot.connectionState} ${snapshot.data}");
            },
          ),
        ),
        InkWell(
            onTap: () {
              showBottomSheet(
                  context: context,
                  builder: (dialogContext) => Container(
                        color: Colors.grey[900],
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: SafeArea(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                  color: CustomTheme.middleGreen,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Select an exercise",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4),
                                  )),
                              Expanded(
                                child: ReferenceExerciseList(
                                    preloadedExos: widget.referenceExercises,
                                    onExerciseChosen:
                                        (ReferenceExercise exercise) {
                                      reloadSpots(exercise);
                                      Navigator.of(dialogContext).pop();
                                    }),
                              )
                            ],
                          ),
                        ),
                      ));
            },
            child: Center(
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(currentReferenceExercise.name,
                    style: Theme.of(context).textTheme.headline4),
              ),
            )),
      ],
    );
  }
}
