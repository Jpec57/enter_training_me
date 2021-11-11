import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/models/user_ranking.dart';
import 'package:enter_training_me/pages/community/views/ranking/user_ranking_card.dart';
import 'package:enter_training_me/widgets/animations/boolean_choice_widget.dart';
import 'package:enter_training_me/widgets/workout/training_container.dart';
import 'package:enter_training_me/services/repositories/ranking_repository.dart';
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
  late Future<List<UserRanking>> _rankingFuture;

  List<UserRanking> _userRankedList = [];
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _rankingFuture =
        RepositoryProvider.of<RankingRepository>(context).getUserRanking();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
      child: Column(
        children: [
          // TextField(
          //   controller: _searchController,
          //   decoration: const InputDecoration(
          //       suffixIcon: Icon(Icons.search, color: Colors.white)),
          // ),

          Expanded(
            child: FutureBuilder(
                future: _rankingFuture,
                builder: (BuildContext context,
                    AsyncSnapshot<List<UserRanking>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        List<UserRanking> rankedUsers = snapshot.data!;
                        return ListView.separated(
                          padding: const EdgeInsets.only(bottom: 50),
                          shrinkWrap: true,
                          itemCount: rankedUsers.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: UserRankingCard(
                                  rank: index + 1,
                                  rankUser: rankedUsers[index]),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(height: 1, color: Colors.grey);
                          },
                        );
                      }
                      return const Center(child: Text("Empty"));

                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      return const Center(child: Text("Error"));
                  }
                }),
          ),
        ],
      ),
    );
  }
}
