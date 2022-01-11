import 'package:auto_animated/auto_animated.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/models/profile_info.dart';
import 'package:enter_training_me/pages/user/profile/profile_metric_container.dart';
import 'package:enter_training_me/services/repositories/user_repository.dart';
import 'package:enter_training_me/widgets/animations/animated_count_text.dart';
import 'package:enter_training_me/widgets/dialog/double_return_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ProfileMetricsSection extends StatelessWidget {
  final ProfileInfo info;
  const ProfileMetricsSection({Key? key, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> metrics = [
      ProfileMetricContainer(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedCountText(
            count: info.trainingCount,
            widgetFromStringGenerator: (text) {
              return Text(text, style: Theme.of(context).textTheme.headline1);
            },
          ),
          const Text("trainings"),
        ],
      )),
      ProfileMetricContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedCountText(
              count: info.sbdSum,
              widgetFromStringGenerator: (text) {
                return Text(text, style: Theme.of(context).textTheme.headline1);
              },
            ),
            const Text("SBD"),
          ],
        ),
      ),
      ProfileMetricContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedCountText(
              count: info.globalRank,
              widgetFromStringGenerator: (text) {
                return Text("$text#",
                    style: Theme.of(context).textTheme.headline1);
              },
            ),
            const Text("Global Ranking"),
          ],
        ),
      ),
      InkWell(
        onTap: () async {
          await showDialog(
              context: context,
              builder: (dialogContext) => DoubleReturnDialog(
                  title: "Your weight:",
                  currentValue: info.user.fitnessProfile?.weight ?? 70,
                  callback: (value) async {
                    var parsedValue = double.parse(value);
                    if (parsedValue > 0) {
                      Map<String, dynamic> map = {"weight": parsedValue};

                      User? updatedUser =
                          await RepositoryProvider.of<UserRepository>(context)
                              .updateUserProfile(info.user.id, map);
                      if (updatedUser != null) {}
                    }
                  }));
        },
        child: ProfileMetricContainer(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedCountText(
                count: info.user.fitnessProfile?.weight ?? 70,
                widgetFromStringGenerator: (text) {
                  return Text(text,
                      style: Theme.of(context).textTheme.headline1);
                },
              ),
              const Text("BW"),
            ],
          ),
        ),
      ),
    ];

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
        padding: const EdgeInsets.only(left: 8, bottom: 24.0, top: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Dashboard", style: Theme.of(context).textTheme.headline4),
            IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
          ],
        ),
      ),
      LiveGrid.options(
        options: const LiveOptions(
          reAnimateOnVisibility: false,
        ),
        itemBuilder: (
          BuildContext context,
          int index,
          Animation<double> animation,
        ) =>
            FadeTransition(
          opacity: Tween<double>(
            begin: 0,
            end: 1,
          ).animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -0.1),
              end: Offset.zero,
            ).animate(animation),
            child: metrics[index],
          ),
        ),
        itemCount: metrics.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
      ),
    ]);
  }
}
