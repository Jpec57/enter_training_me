import 'package:dio/dio.dart';
import 'package:enter_training_me/models/performance_set.dart';
import 'package:enter_training_me/services/interfaces/api_service.dart';

class PerformanceRepository extends ApiService {
  static const getPerfForExoUrl = "/performances/exercises/{id}";

  Future<List<PerformanceSet>> getPerfForReferenceExercise(int id) async {
    Response response = await getDio()
        .get(getPerfForExoUrl.replaceFirst("{id}", id.toString()));
    List<dynamic> data = response.data;
    return data.map((e) => PerformanceSet.fromJson(e)).toList();
  }
}
