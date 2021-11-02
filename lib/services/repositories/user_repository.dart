import 'package:dio/dio.dart';
import 'package:enter_training_me/authentication/authentication.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/models/profile_info.dart';
import 'package:enter_training_me/services/interfaces/api_service.dart';
import 'package:enter_training_me/storage_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' as get_lib;

class UserRepository extends ApiService
    implements IAuthUserRepositoryInterface {
  static const getUserFeed = "/api/users/feed";
  static const loginUrl = "/api/login";
  static const registerUrl = "/api/register";
  static const getByToken = "/api/users/token/{token}";
  static const getProfileInfoUrl = "/api/users/infos/{id}";
  static const getRealisedExosByUser = "/api/users/realised_exercises";

  @override
  Future<IAuthUserInterface?> getUserWithToken(String? apiToken) async {
    if (apiToken == null) {
      FlutterSecureStorage storage = const FlutterSecureStorage();
      apiToken = await storage.read(key: StorageConstants.apiKey);
      if (apiToken == null) {
        return null;
      }
    }
    Response response =
        await getDio().get(getByToken.replaceFirst("{token}", apiToken));
    return User.fromJson(response.data);
  }

  Future<ProfileInfo?> getUserProfileInfo(int? id) async {
    Response response = await getDio().get(getProfileInfoUrl.replaceFirst(
        "{id}", (id != null ? id.toString() : "")));
    return ProfileInfo.fromJson(response.data);
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
    try {
      Response response = await getDio().post(registerUrl, data: map);
      Map<String, dynamic> res = response.data;
      if (!res.containsKey("token")) {
        return null;
      }
      String token = res["token"];
      FlutterSecureStorage storage = const FlutterSecureStorage();
      storage.write(key: StorageConstants.apiKey, value: token);
      return User.fromJson(res["user"]);
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode == 400) {
        get_lib.Get.snackbar("Already used email",
            "This email is already in use. Please log in.");
      }
      return null;
    }
  }

  Future<IAuthUserInterface?> authenticate(
      {required String email, required String password}) async {
    Map<String, dynamic> map = {
      "email": email,
      "password": password,
    };
    Response response = await getDio().post(loginUrl, data: map);
    return null;
  }

  Future<List<Training>> getPersonalFeed({int page = 0, int limit = 10}) async {
    //Currently not taking user id and returning only trainings
    Map<String, dynamic> queryParams = {
      "limit": limit,
      "page": page,
    };
    Response response =
        await getDio().get(getUserFeed, queryParameters: queryParams);
    List<dynamic> data = response.data;
    return data.map((e) => Training.fromJson(e)).toList();
  }

  Future<List<ReferenceExercise>> getRealisedExoForViewer() async {
    try {
      Response response = await getDio().get(getRealisedExosByUser);

      List<dynamic> data = response.data;
      return data.map((e) => ReferenceExercise.fromJson(e)).toList();
    } on DioError catch (_) {
      return [];
    }
  }
}
