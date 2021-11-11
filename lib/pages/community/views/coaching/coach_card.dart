import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/coaching/coach_page.dart';
import 'package:enter_training_me/pages/coaching/coach_page_arguments.dart';
import 'package:enter_training_me/utils/utils.dart';
import 'package:enter_training_me/widgets/review_stars.dart';
import 'package:enter_training_me/widgets/user/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachCard extends StatelessWidget {
  final User coach;
  const CoachCard({Key? key, required this.coach}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(CoachPage.routeName, arguments: CoachPageArguments(coach));
      },
      child: Card(
        color: CustomTheme.greenGrey,
        elevation: 8,
        child: Row(
          children: [
            UserAvatar(
              user: coach,
              radius: 30,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(coach.username,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5.0),
                                child: Text("3",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ),
                              Icon(Icons.person)
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text("#strength, #bodybuilding, #lifestyle",
                          style:
                              const TextStyle(fontStyle: FontStyle.italic)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: RichText(
                        text: TextSpan(
                            text: "Next availability: ",
                            style:
                                const TextStyle(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                  text: Utils.defaultDateFormatter
                                      .format(coach.createdAt),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal))
                            ]),
                      ),
                    ),
                    ReviewStars(score: 3.8, size: 14),
                  ],
                ),
              ),
            ),
            // const Icon(
            //   Icons.arrow_right_rounded,
            //   size: 50,
            // )
          ],
        ),
      ),
    );
  }
}
