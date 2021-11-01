import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:enter_training_me/models/cached_request.dart';
import 'package:enter_training_me/models/reference_exercise.dart';
import 'package:enter_training_me/services/interfaces/api_service.dart';
import 'package:enter_training_me/services/interfaces/irepository.dart';
import 'package:hive/hive.dart';

typedef FutureResponseFunction = Future<Response> Function();

class ReferenceExerciseRepository extends ApiService
    implements IRepository<ReferenceExercise> {
  static const getUrl = "/api/exercise_references/{id}";
  static const getAllUrl = "/api/exercise_references/";

  @override
  Future<bool> delete(int id) {
    throw UnimplementedError();
  }

  @override
  Future<ReferenceExercise> get(int id) async {
    Response response =
        await getDio().get(getUrl.replaceFirst("{id}", id.toString()));
    dynamic data = response.data;
    return ReferenceExercise.fromJson(data);
  }

  Future<String> getCachedRequestFromBox(
      String boxName, FutureResponseFunction requestFallback,
      {int cacheDurationInHours = 24}) async {
    DateTime now = DateTime.now();
    var box = Hive.box<CachedRequest>("request");
    CachedRequest? existingValue = box.getAt(0);

    if (existingValue != null &&
        now.difference(existingValue.savedDate).inHours <
            cacheDurationInHours) {
      return existingValue.string;
    }
    Response response = await requestFallback();
    if (response.statusCode != null &&
        200 <= response.statusCode! &&
        response.statusCode! < 300) {
      var cachedRequest = CachedRequest(DateTime.now(), response.data);
      box.putAt(0, cachedRequest);
    }
    return response.data;
  }

  @override
  Future<List<ReferenceExercise>> getAll() async {
    String stringData = await getCachedRequestFromBox("request", () async {
      Response response = await getDio().get(getAllUrl);
      return response;
    });
    Map<String, dynamic> hydraCollection = jsonDecode(stringData);
    List<dynamic> data = hydraCollection['hydra:member'];
    return data.map((e) => ReferenceExercise.fromJson(e)).toList();
  }

  @override
  Future<ReferenceExercise> patch(Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  @override
  Future<ReferenceExercise> post(Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  @override
  Future<ReferenceExercise> put(ReferenceExercise data) {
    throw UnimplementedError();
  }
}
