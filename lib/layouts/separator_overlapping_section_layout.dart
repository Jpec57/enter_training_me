import 'package:flutter/material.dart';

class SeparatorOverlappingSectionLayout extends StatelessWidget {
  final Widget topWidget;
  final Widget bottomWidget;
  final Widget overlappingWidget;
  final Color topWidgetBackgroundColor;
  final Color bottomWidgetBackgroundColor;
  final EdgeInsets topWidgetPadding;
  final EdgeInsets bottomWidgetPadding;

  const SeparatorOverlappingSectionLayout(
      {Key? key,
      required this.topWidget,
      required this.bottomWidget,
      required this.overlappingWidget,
      required this.topWidgetBackgroundColor,
      required this.bottomWidgetBackgroundColor,
      this.topWidgetPadding = EdgeInsets.zero,
      this.bottomWidgetPadding = EdgeInsets.zero})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: topWidgetBackgroundColor,
          padding: topWidgetPadding,
          width: MediaQuery.of(context).size.width,
          child: topWidget,
        ),
        Stack(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          alignment: Alignment.center,
          children: [
            Positioned.fill(
                child: Column(children: [
              Expanded(child: Container(color: topWidgetBackgroundColor)),
              Expanded(child: Container(color: bottomWidgetBackgroundColor)),
            ])),
            Align(
                alignment: Alignment.center,
                child: Center(
                  child: overlappingWidget,
                ))
          ],
        ),
        Container(
            padding: bottomWidgetPadding,
            color: bottomWidgetBackgroundColor,
            child: bottomWidget),
      ],
    );
  }
}
