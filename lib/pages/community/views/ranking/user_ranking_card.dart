import 'package:enter_training_me/models/user_ranking.dart';
import 'package:flutter/material.dart';

class UserRankingCard extends StatelessWidget {
  final int rank;
  final UserRanking rankUser;
  const UserRankingCard({Key? key, required this.rankUser, required this.rank})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Row(
        children: [
          Text("$rank#",
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(fontSize: 35)),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(rankUser.user.username),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(rankUser.experience.toString(),
                    style: Theme.of(context).textTheme.headline3),
                Text("points"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
