import 'package:dio/dio.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/models/team_ranking.dart';
import 'package:enter_training_me/models/user_ranking.dart';
import 'package:enter_training_me/services/interfaces/api_service.dart';

class UserReactionRepository extends ApiService {
  static const reactToObjectUrl = "/user_reactions";

  Future<List<TeamRanking>> getTeamRanking() async {
    Response response = await getDio().get(reactToObjectUrl);
    List<dynamic> data = response.data;
    return data.map((e) => TeamRanking.fromJson(e)).toList();
  }
}
