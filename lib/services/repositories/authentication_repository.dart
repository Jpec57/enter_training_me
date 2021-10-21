import 'dart:async';

import 'package:dio/dio.dart';
import 'package:enter_training_me/authentication/interfaces/iauthentication_repository.dart';
import 'package:enter_training_me/authentication/models/auth_response.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/pages/home/home_page.dart';
import 'package:enter_training_me/services/interfaces/api_service.dart';
import 'package:enter_training_me/storage_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' as get_lib;

class AuthenticationRepository extends ApiService
    implements IAuthenticationRepositoryInterface {
  @override
  final controller = StreamController<AuthenticationStatus>();

  @override
  Future<String?> getUserToken() {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    return storage.read(key: StorageConstants.apiKey);
  }

  @override
  Future<bool> logIn(
      {required String username, required String password}) async {
    Map<String, dynamic> data = {
      "username": username,
      "email": username,
      "password": password,
    };
    Response response = await getDio().post("/api/login", data: data);

    if (response.statusCode == null) {
      return false;
    }
    return response.statusCode! < 300 && response.statusCode! >= 200;
  }

  @override
  void logOut() {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    storage.delete(key: StorageConstants.apiKey);
    get_lib.Get.offNamedUntil(HomePage.routeName, (route) => false);
  }

  @override
  Future<bool> removeUserToken() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.delete(key: StorageConstants.apiKey);
    return true;
  }

  @override
  Future<bool> saveUserToken(String token) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    storage.write(key: StorageConstants.apiKey, value: token);
    return true;
  }

  @override
  void dispose() => controller.close();

  @override
  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.unknown;
    yield* controller.stream;
  }

  @override
  Future<AuthResponse?> logInAndGetUser(
      {required String email, required String password}) async {
    Map<String, dynamic> data = {
      "username": email,
      "email": email,
      "password": password,
    };

    Response response = await getDio().post("/api/login", data: data);
    Map<String, dynamic> res = response.data;
    if (!res.containsKey("token")) {
      return null;
    }
    String token = res["token"];
    await saveUserToken(token);
    return AuthResponse(token: token, user: User.fromJson(res["user"]));
  }
}
