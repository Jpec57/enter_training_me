import 'package:enter_training_me/custom_theme.dart';
import 'package:flutter/material.dart';

class ExerciseContainer extends StatelessWidget {
  final Widget child;
  const ExerciseContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: CustomTheme.middleGreen.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(5, 3),
            )
          ],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          color: CustomTheme.middleGreen),
      child: child,
    );
  }
}
