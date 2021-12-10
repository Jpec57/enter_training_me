import 'package:dio/dio.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/models/team_ranking.dart';
import 'package:enter_training_me/services/interfaces/api_service.dart';

class UserRelationRepository extends ApiService {
  static const becomeCoachUrl = "/user_relations";

  Future<List<TeamRanking>> coachSomeone() async {
    Response response = await getDio().get(becomeCoachUrl);
    List<dynamic> data = response.data;
    return data.map((e) => TeamRanking.fromJson(e)).toList();
  }
}
