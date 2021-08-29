import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const routeName = "/";

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 4,
              child: Container(
                color: Colors.red,
              )
          ),
          Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
                child: Container(
                  color: Colors.grey,
                  child: const Text("Saisissez la barre de tractions avec vos avant-bras tournés vers l'extérieur et les paumes vers l'intérieur. Engagez vos épaules en rapprochant vos omoplates et cherchez à vous hisser en gardant une direction la plus droite possible."),
                ),
              )
          ),
        ],
      ),
    );
  }
}
