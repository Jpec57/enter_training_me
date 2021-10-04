import 'package:dio/dio.dart';
import 'package:enter_training_me/authentication/interfaces/iauthentication_repository.dart';
import 'package:enter_training_me/pages/login/login_page.dart';
import 'package:enter_training_me/services/interfaces/api_service.dart';
import 'package:enter_training_me/storage_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' as get_lib;

class AuthenticationRepository extends ApiService
    implements IAuthenticationRepositoryInterface {
  @override
  void dispose() {
    // super.dispose();
  }

  @override
  Future<String?> getUserToken() {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    return storage.read(key: StorageConstants.apiKey);
  }

  @override
  Future<bool> logIn(
      {required String username, required String password}) async {
    Response response = await getDio().get("/login");
    dynamic data = response.data;

    if (response.statusCode == null) {
      return false;
    }
    return response.statusCode! < 300 && response.statusCode! >= 200;
  }

  @override
  void logOut() {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    storage.delete(key: StorageConstants.apiKey);
    get_lib.Get.offNamedUntil(LoginPage.routeName, (route) => false);
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
  // TODO: implement status
  Stream<AuthenticationStatus> get status => throw UnimplementedError();
}
