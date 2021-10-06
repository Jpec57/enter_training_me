import 'package:flutter/material.dart';

class Headline3 extends StatelessWidget {
  final String title;
  const Headline3({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.headline3);
  }
}
