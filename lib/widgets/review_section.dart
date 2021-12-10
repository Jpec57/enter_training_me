import 'package:enter_training_me/widgets/cards/default_section_card.dart';
import 'package:enter_training_me/widgets/review_stars.dart';
import 'package:flutter/material.dart';

class ReviewSection extends StatelessWidget {
  final double score;
  final int maxScore;
  final int reviewCount;
  const ReviewSection(
      {Key? key, required this.score, this.reviewCount = 17, this.maxScore = 5})
      : assert(score > 0),
        assert(score <= maxScore),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Reviews ($reviewCount)",
              style: Theme.of(context).textTheme.headline3),
          ReviewStars(
            score: score,
            maxScore: maxScore,
          ),
        ],
      ),
    );
  }
}
