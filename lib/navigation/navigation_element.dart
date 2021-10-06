import 'package:flutter/material.dart';

class NavigationElement {
  final String title;
  final IconData iconData;
  final VoidCallback? onPressed;
  final String routeName;

  const NavigationElement(
      {required this.title,
      required this.iconData,
      required this.routeName,
      this.onPressed});
}
