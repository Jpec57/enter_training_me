import 'package:flutter/material.dart';

import 'clippers.dart';

class ClipperExpo extends StatelessWidget {
  const ClipperExpo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipPath(
          clipper: DiagonalCornerClipper(),
          child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey),
        ),
        ClipPath(
          clipper: SmoothWaveClipper(),
          child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              color: Colors.purple),
        ),
        ClipPath(
          clipper: HillsClipper(),
          child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              color: Colors.green),
        ),
        ClipPath(
          clipper: CurvyDropTopClipper(),
          child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: const Text("This is a text"),
              color: Colors.orange),
        ),
        ClipPath(
          clipper: WavyLoginTopClipper(),
          child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              color: Colors.blue),
        ),
        ClipPath(
          clipper: WavyLoginBottomClipper(),
          child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              color: Colors.blue),
        )
      ],
    );
  }
}
