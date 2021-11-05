import 'package:flutter/material.dart';

class TabElement {
  final Tab tab;
  final Widget view;
  final Widget? header;

  const TabElement({required this.tab, required this.view, this.header});
}
