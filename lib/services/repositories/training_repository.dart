import 'package:dio/dio.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/services/interfaces/api_service.dart';
import 'package:enter_training_me/services/interfaces/irepository.dart';
import 'dart:convert';

class TrainingRepository extends ApiService implements IRepository<Training> {
  static const GET_ALL = "/trainings/";
  static const getAllUrl = "/api/trainings";
  static const getPersonal = "/trainings/personal";
  static const getOfficialUri = "/trainings/official";
  static const getByReferenceUri = "/trainings/reference/{id}";
  static const getUrl = "/api/trainings/{id}";
  static const postUser = "/api/trainings";
  static const shareByEmail = "/trainings/{id}/share";

  @override
  Future<Training> get(int id) async {
    Response response =
        await getDio().get(getUrl.replaceFirst("{id}", id.toString()));
    dynamic data = response.data;
    return Training.fromJson(data);
  }

  Future<bool> shareByEmailAction(int id) async {
    Response response =
        await getDio().get(shareByEmail.replaceFirst("{id}", id.toString()));
    dynamic data = response.data;
    return response.statusCode == 200;
  }

  @override
  Future<List<Training>> getAll() async {
    Response response = await getDio().get(getAllUrl);
    // Response response = await getDio().get(GET_ALL);
    List<dynamic> data = response.data;
    return data.map((e) => Training.fromJson(e)).toList();
  }

  @override
  Future<List<Training>> getByReference(int id) async {
    Response response = await getDio()
        .get(getByReferenceUri.replaceFirst("{id}", id.toString()));
    List<dynamic> data = response.data;
    return data.map((e) => Training.fromJson(e)).toList();
  }

  @override
  Future<List<Training>> getOfficial() async {
    Response response = await getDio().get(getOfficialUri);

    List<dynamic> data = response.data;
    return data.map((e) => Training.fromJson(e)).toList();
  }

  @override
  Future<bool> delete(int id) {
    throw UnimplementedError();
  }

  Future postUserTraining(Map<String, dynamic> data) async {
    print("------------------------------POSTING TRAINING");
    data["name"] = data["name"] + " " + DateTime.now().toIso8601String();

    data["createdAt"] = null;
    Response response = await getDio().post(postUser, data: data);
    dynamic responseData = response.data;
    return Training.fromJson(jsonDecode(responseData));
  }

  @override
  Future<Training> patch(Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  @override
  Future<Training> post(Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  @override
  Future<Training> put(Training data) {
    throw UnimplementedError();
  }
}
