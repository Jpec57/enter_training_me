import 'package:enter_training_me/custom_theme.dart';
import 'package:flutter/material.dart';

class DefaultSectionCard extends StatelessWidget {
  final Widget child;
  const DefaultSectionCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: CustomTheme.greenGrey,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: child,
      ),
    );
  }
}
