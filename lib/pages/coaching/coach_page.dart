import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/layouts/separator_overlapping_section_layout.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/coaching/sections/coach_trainee_section.dart';
import 'package:enter_training_me/pages/user/profile/sections/profile_header.dart';
import 'package:enter_training_me/widgets/last_comment_section.dart';
import 'package:enter_training_me/widgets/review_section.dart';
import 'package:flutter/material.dart';

class CoachPage extends StatelessWidget {
  static const routeName = "/coaching/show";
  final User coach;

  const CoachPage({Key? key, required this.coach}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SeparatorOverlappingSectionLayout(
                topWidgetPadding: const EdgeInsets.only(bottom: 16),
                topWidgetBackgroundColor: CustomTheme.darkGrey,
                bottomWidgetBackgroundColor: CustomTheme.middleGreen,
                topWidget: ProfileHeader(
                  user: coach,
                ),
                overlappingWidget: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.black, width: 1)),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: Icon(Icons.access_alarm),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Description",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                    coach.description ?? "No description",
                                    textAlign: TextAlign.center,
                                    style:
                                        const TextStyle(color: Colors.black)),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
                bottomWidget: Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          primary: CustomTheme.greenGrey,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(Icons.fitness_center),
                          ),
                          Text("Become a trainee"),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          primary: CustomTheme.greenGrey,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(Icons.send),
                          ),
                          Text("Ask a question"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
                child: Column(
                  children: [
                    CoachTraineeSection(
                        trainees: List.generate(7, (index) => User.dummy())),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8.0),
                      child: ReviewSection(
                        score: 3.6,
                      ),
                    ),
                    LastCommentSection(
                      commentCount: 5,
                      lastComment: "This trainer is really incredible",
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
