import 'package:dio/dio.dart';
import 'package:enter_training_me/authentication/authentication.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/services/interfaces/api_service.dart';
import 'package:flutter/material.dart';

class UserRepository extends ApiService
    implements IAuthUserRepositoryInterface {
  static const getUserFeed = "/api/users/feed";
  static const loginUrl = "/api/login";
  static const registerUrl = "/api/register";
  static const getByToken = "/api/users/token/{token}";

  @override
  Future<IAuthUserInterface?> getUserWithToken(String apiToken) async {
    print("getByToken ${getByToken.replaceFirst("{token}", apiToken)}");
    Response response =
        await getDio().get(getByToken.replaceFirst("{token}", apiToken));
    print("getUserWithToken");
    print(response.data);
    return User.fromJson(response.data);
  }

  Future<IAuthUserInterface?> register(
      {required String email,
      required String username,
      required String password}) async {
    Map<String, dynamic> map = {
      "username": username,
      "email": email,
      "password": password,
    };
    Response response = await getDio().post(registerUrl, data: map);
    response.data;
    return null;
  }

  Future<IAuthUserInterface?> authenticate(
      {required String email, required String password}) async {
    Map<String, dynamic> map = {
      "email": email,
      "password": password,
    };
    Response response = await getDio().post(loginUrl, data: map);
    response.data;
    return null;
  }

  Future<List<Training>> getPersonalFeed({int page = 0, int limit = 10}) async {
    debugPrint("Fetching personal training feed...");
    //Currently not taking user id and returning only trainings
    Map<String, dynamic> queryParams = {
      "limit": limit,
      "page": page,
    };
    Response response =
        await getDio().get(getUserFeed, queryParameters: queryParams);
    List<dynamic> data = response.data;
    print(response.data);
    return data.map((e) => Training.fromJson(e)).toList();
  }
}
