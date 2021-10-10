import 'package:dio/dio.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/services/interfaces/api_service.dart';
import 'package:enter_training_me/services/interfaces/irepository.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class TrainingRepository extends ApiService implements IRepository {
  static const GET_ALL = "/trainings/";
  static const getOfficialUri = "/trainings/official";
  static const getByReferenceUri = "/trainings/reference/{id}";
  static const GET = "/api/trainings/{id}";
  static const postUser = "/api/trainings";

  @override
  Future<Training> get(int id) async {
    Response response =
        await getDio().get(GET.replaceFirst("{id}", id.toString()));
    dynamic data = response.data;
    return Training.fromJson(data);
  }

  @override
  Future<List<Training>> getAll() async {
    debugPrint("Fetching training list...");
    Response response = await getDio().get(GET_ALL);
    List<dynamic> data = response.data;
    return data.map((e) => Training.fromJson(e)).toList();
  }

  @override
  Future<List<Training>> getByReference(int id) async {
    debugPrint("Fetching by ref $id list...");
    Response response = await getDio()
        .get(getByReferenceUri.replaceFirst("{id}", id.toString()));
    List<dynamic> data = response.data;
    return data.map((e) => Training.fromJson(e)).toList();
  }

  @override
  Future<List<Training>> getOfficial() async {
    debugPrint("Fetching official training list...");
    Response response = await getDio().get(getOfficialUri);
    print(response.data);
    List<dynamic> data = response.data;
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

  @override
  Future postUserTraining(Map<String, dynamic> data) async {
    debugPrint("Posting user training...");
    data["name"] = data["name"] + " " + DateTime.now().toIso8601String();
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
