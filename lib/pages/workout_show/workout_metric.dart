import 'package:flutter/material.dart';

class WorkoutMetric extends StatelessWidget {
  final String metric;
  final String unit;
  const WorkoutMetric({Key? key, required this.metric, required this.unit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: metric,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          children: [
            TextSpan(
              text: unit,
              style:
                  const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
            )
          ]),
    );
  }
}
