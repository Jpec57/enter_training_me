import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:enter_training_me/models/reference_exercise.dart';
import 'package:enter_training_me/services/interfaces/api_service.dart';
import 'package:enter_training_me/services/interfaces/irepository.dart';

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

  @override
  Future<List<ReferenceExercise>> getAll() async {
    Response response = await getDio().get(getAllUrl);
    Map<String, dynamic> hydraCollection = jsonDecode(response.data);
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
