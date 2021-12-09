import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/user/other_profile_page.dart';
import 'package:enter_training_me/widgets/cards/default_section_card.dart';
import 'package:enter_training_me/widgets/user/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachTraineeSection extends StatelessWidget {
  final List<User> trainees;
  const CoachTraineeSection({Key? key, required this.trainees})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Trainees (${trainees.length})",
              style: Theme.of(context).textTheme.headline3),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Wrap(
              spacing: 16,
              children: trainees
                  .map((trainee) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          UserAvatar(
                            radius: 15,
                            user: trainee,
                            onTap: () {
                              Get.toNamed(OtherProfilePage.routeName,
                                  arguments: {'userId': trainee.id});
                            },
                          ),
                          Text(trainee.username)
                        ],
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
