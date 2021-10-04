import 'package:dio/dio.dart';
import 'package:enter_training_me/authentication/authentication.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/services/interfaces/api_service.dart';

class UserRepository extends ApiService implements IAuthUserRepositoryInterface {
  @override
  Future<IAuthUserInterface?> getUserWithToken(String apiToken) async {
    // Response response = await getDio().get("");
    if (apiToken == "toto"){
      return const User(id: 1, username: "Jpec");
    }
    return null;
  }
}
