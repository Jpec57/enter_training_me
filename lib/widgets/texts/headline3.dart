import 'package:flutter/material.dart';

class Headline4 extends StatelessWidget {
  final String title;
  const Headline4({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.headline4);
  }
}
