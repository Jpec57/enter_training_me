import 'package:dio/dio.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/services/interfaces/api_service.dart';
import 'package:enter_training_me/services/interfaces/irepository.dart';
import 'package:flutter/material.dart';

class TrainingRepository extends ApiService implements IRepository {
  static const GET_ALL = "/trainings/";
  // static const GET_ALL = "/api/trainings/";
  static const GET = "/api/trainings/{id}";

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
    // try {
    //   data.map((e) {
    //     print(e);
    //     var training = Training.fromJson(e);
    //     return Training.fromJson(e);
    //   }).toList();
    // } on Exception catch (e) {
    //   print(e);
    // }

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
  Future put(data) {
    // TODO: implement put
    throw UnimplementedError();
  }
}
