part of '../profile_page_content.dart';

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
            const Text("Not defined yet"),
          ],
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
