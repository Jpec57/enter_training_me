import 'package:enter_training_me/custom_theme.dart';
import 'package:flutter/material.dart';

class ProfileMetricContainer extends StatelessWidget {
  final Widget child;
  const ProfileMetricContainer({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: CustomTheme.green, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: child,
        ));
  }
}
