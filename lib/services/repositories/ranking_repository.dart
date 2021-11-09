import 'package:dio/dio.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/models/team_ranking.dart';
import 'package:enter_training_me/models/user_ranking.dart';
import 'package:enter_training_me/services/interfaces/api_service.dart';

class RankingRepository extends ApiService {
  static const getUserRankingUrl = "/rankings/users";
  static const getAllUrl = "/api/exercise_formats";

  Future<List<UserRanking>> getUserRanking() async {
    Response response = await getDio().get(getUserRankingUrl);
    List<dynamic> data = response.data;
    return data.map((e) => UserRanking.fromJson(e)).toList();
  }

  Future<List<TeamRanking>> getTeamRanking() async {
    Response response = await getDio().get(getUserRankingUrl);
    List<dynamic> data = response.data;
    return data.map((e) => TeamRanking.fromJson(e)).toList();
  }
}
