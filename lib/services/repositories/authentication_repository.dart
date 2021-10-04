import 'package:enter_training_me/authentication/interfaces/iauthentication_repository.dart';

class AuthenticationRepository implements IAuthenticationRepositoryInterface {

  @override
  void dispose() {
    // super.dispose();
  }

  @override
  Future<String?> getUserToken() {
    // TODO: implement getUserToken
    throw UnimplementedError();
  }

  @override
  Future<bool> logIn({required String username, required String password}) {
    // TODO: implement logIn
    throw UnimplementedError();
  }

  @override
  void logOut() {
    // TODO: implement logOut
  }

  @override
  Future<bool> removeUserToken() {
    // TODO: implement removeUserToken
    throw UnimplementedError();
  }

  @override
  Future<bool> saveUserToken(String token) {
    // TODO: implement saveUserToken
    throw UnimplementedError();
  }

  @override
  // TODO: implement status
  Stream<AuthenticationStatus> get status => throw UnimplementedError();

}