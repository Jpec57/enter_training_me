import 'package:dio/dio.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/services/interfaces/api_service.dart';
import 'package:enter_training_me/services/interfaces/irepository.dart';
import 'dart:convert';
import 'package:get/get.dart' as get_lib;

class TrainingRepository extends ApiService implements IRepository<Training> {
  static const getAllUrl = "/api/trainings";
  static const getOfficialUri = "/trainings/official";
  static const getByReferenceUri = "/trainings/reference/{id}";
  static const getUrl = "/api/trainings/{id}";
  static const postUser = "/api/trainings";
  static const shareByEmail = "/trainings/{id}/share";
  static const getSavedUrl = "/trainings/saved";
  static const saveTraining = "/trainings/{id}/save";
  static const removeFromSaved = "/trainings/{id}/unsave";

  @override
  Future<Training> get(int id) async {
    Response response =
        await getDio().get(getUrl.replaceFirst("{id}", id.toString()));
    dynamic data = response.data;
    print(data);
    return Training.fromJson(data);
  }

  Future<bool> shareByEmailAction(int id) async {
    Response response =
        await getDio().get(shareByEmail.replaceFirst("{id}", id.toString()));
    dynamic data = response.data;
    return response.statusCode == 200;
  }

  Future<bool> saveTrainingAction(int id) async {
    try {
      Response response =
          await getDio().get(saveTraining.replaceFirst("{id}", id.toString()));
      dynamic data = response.data;
      return response.statusCode == 200;
    } on DioError catch (e) {
      get_lib.Get.snackbar("Forbidden", "You must be connected to do this :(");
      return false;
    }
  }

  Future<bool> removeFromSavedTrainingAction(int id) async {
    try {
      Response response = await getDio()
          .get(removeFromSaved.replaceFirst("{id}", id.toString()));
      dynamic data = response.data;
      return response.statusCode == 200;
    } on DioError catch (e) {
      get_lib.Get.snackbar("Forbidden", "You must be connected to do this :(");
      return false;
    }
  }

  Future<List<Training>> getSavedTrainings() async {
    try {
      Response response = await getDio().get(getSavedUrl);
      List<dynamic> data = response.data;
      return data.map((e) => Training.fromJson(e)).toList();
    } on DioError catch (e) {
      return [];
    }
  }

  @override
  Future<List<Training>> getAll() async {
    Response response = await getDio().get(getAllUrl);
    List<dynamic> data = response.data;
    print(data);
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

    data.remove("createdAt");
    // data["createdAt"] = null;
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
