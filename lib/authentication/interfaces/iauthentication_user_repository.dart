import 'package:enter_training_me/authentication/interfaces/iauthentication_user.dart';

abstract class IAuthUserRepositoryInterface {
  Future<IAuthUserInterface?> getUserWithToken(String apiToken);
}
