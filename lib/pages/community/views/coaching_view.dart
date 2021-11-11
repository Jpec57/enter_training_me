import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/coaching/coach_page.dart';
import 'package:enter_training_me/pages/community/views/coaching/coach_card.dart';
import 'package:enter_training_me/widgets/workout/training_container.dart';
import 'package:enter_training_me/services/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoachingView extends StatefulWidget {
  const CoachingView({Key? key}) : super(key: key);

  @override
  _CoachingViewState createState() => _CoachingViewState();
}

class _CoachingViewState extends State<CoachingView>
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
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CoachCard(coach: User.dummy()),
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
