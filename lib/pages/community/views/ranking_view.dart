import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/home/training_container.dart';
import 'package:enter_training_me/services/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RankingView extends StatefulWidget {
  const RankingView({Key? key}) : super(key: key);

  @override
  _RankingViewState createState() => _RankingViewState();
}

class _RankingViewState extends State<RankingView>
    with AutomaticKeepAliveClientMixin {
  late Future<List<Training>> _feedFuture;

  @override
  void initState() {
    super.initState();
    _feedFuture =
        RepositoryProvider.of<UserRepository>(context).getPersonalFeed();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
      child: FutureBuilder(
          future: _feedFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return const Center(child: Text("Error"));
                }
                List<Training> trainings = snapshot.data;
                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 50),
                  shrinkWrap: true,
                  itemCount: trainings.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 200,
                      child: TrainingContainer(
                        otherColor: true,
                        referenceTraining: trainings[index],
                      ),
                    );
                  },
                );
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
                return const Center(child: Text("Error"));
            }
          }),
    );
  }
}
