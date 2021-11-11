import 'package:enter_training_me/widgets/cards/default_section_card.dart';
import 'package:flutter/material.dart';

class ReviewStars extends StatelessWidget {
  final double score;
  final int maxScore;
  final int reviewCount;
  final double? size;
  const ReviewStars(
      {Key? key,
      required this.score,
      this.reviewCount = 17,
      this.maxScore = 5,
      this.size})
      : assert(score > 0),
        assert(score <= maxScore),
        super(key: key);

  double get rescaledScore => score * 5 / maxScore;

  List<Widget> get starWidgets {
    List<Widget> starWidgets = [];
    int filledStarCount = rescaledScore.round();

    for (var i = 0; i < maxScore; i++) {
      if (i < filledStarCount) {
        starWidgets.add(Icon(
          Icons.star,
          size: size,
        ));
      } else {
        starWidgets.add(Icon(
          Icons.star_border,
          size: size,
        ));
      }
    }
    return starWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...starWidgets,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text("(${rescaledScore.toStringAsFixed(1)})",
              style: const TextStyle(fontWeight: FontWeight.bold)),
        )
      ],
    );
  }
}
