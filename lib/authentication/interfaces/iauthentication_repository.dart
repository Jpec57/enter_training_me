import 'dart:async';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

abstract class IAuthenticationRepositoryInterface {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.unknown;
    yield* _controller.stream;
  }

  Future<bool> logIn({
    required String username,
    required String password,
  });

  Future<String?> getUserToken();

  Future<bool> saveUserToken(String token);

  Future<bool> removeUserToken();

  void logOut();

  void dispose() => _controller.close();
}
