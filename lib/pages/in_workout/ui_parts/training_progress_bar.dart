import 'package:enter_training_me/custom_theme.dart';
import 'package:flutter/material.dart';

class TrainingProgressBar extends StatelessWidget {
  final void Function()? onPressed;
  final double progress;
  final Color backgroundColor;
  final Color progressColor;

  const TrainingProgressBar({Key? key, this.onPressed, this.progress = 0.3, this.backgroundColor = CustomTheme.green, this.progressColor = CustomTheme.middleGreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          //TODO Workout duration
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text("00:02:13", style: TextStyle(color:Colors.white),),
          ),
          Flexible(
            child: Container(
              height: 10,
              decoration: BoxDecoration(
                  color: backgroundColor,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Row(
                children: [
                  Expanded(
                      flex: (progress * 100).toInt(),
                      child: Container(
                        color: progressColor,
                      )),
                  Expanded(
                      flex: ((1-progress) * 100).toInt(),
                      child: Container()),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text("${(progress * 100).toInt()}%", style: TextStyle(color:Colors.white),),
          )
        ],
      ),
    );
  }
}
