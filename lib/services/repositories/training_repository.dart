import 'package:dio/dio.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/services/interfaces/api_service.dart';
import 'package:enter_training_me/services/interfaces/irepository.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class TrainingRepository extends ApiService implements IRepository {
  static const GET_ALL = "/trainings/";
  static const getPersonal = "/trainings/personal";
  static const getOfficialUri = "/trainings/official";
  static const getByReferenceUri = "/trainings/reference/{id}";
  static const GET = "/api/trainings/{id}";
  static const postUser = "/api/trainings";
  static const shareByEmail = "/trainings/{id}/share";

  @override
  Future<Training> get(int id) async {
    Response response =
        await getDio().get(GET.replaceFirst("{id}", id.toString()));
    dynamic data = response.data;
    return Training.fromJson(data);
  }

  Future<bool> shareByEmailAction(int id) async {
    Response response =
        await getDio().get(shareByEmail.replaceFirst("{id}", id.toString()));
    dynamic data = response.data;
    print(data);
    return response.statusCode == 200;
  }

  @override
  Future<List<Training>> getAll() async {
    Response response = await getDio().get(GET_ALL);
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
    debugPrint("Fetching official training list...");
    Response response = await getDio().get(getOfficialUri);

    List<dynamic> data = response.data;
    print(data[0]);
    return data.map((e) => Training.fromJson(e)).toList();
  }

  @override
  Future<bool> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future patch(Map<String, dynamic> data) {
    // TODO: implement patch
    throw UnimplementedError();
  }

  @override
  Future post(Map<String, dynamic> data) {
    // TODO: implement post
    throw UnimplementedError();
  }

  Future postUserTraining(Map<String, dynamic> data) async {
    debugPrint("Posting user training...");
    data["name"] = data["name"] + " " + DateTime.now().toIso8601String();
    debugPrint(data["createdAt"]);
    data["createdAt"] = null;
    Response response = await getDio().post(postUser, data: data);
    dynamic responseData = response.data;
    debugPrint(responseData.toString());
    return Training.fromJson(jsonDecode(responseData));
  }

  @override
  Future put(data) {
    // TODO: implement put
    throw UnimplementedError();
  }
}
