import 'package:enter_training_me/authentication/authentication.dart';

class AuthResponse {
  final String token;
  final IAuthUserInterface user;

  AuthResponse({required this.token, required this.user});

  @override
  String toString() {
    return "TOKEN: $token FOR USER $user";
  }
}
