part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    // this.status = FormzStatus.pure,
    this.username = "",
    this.password = "",
  });

  // final FormzStatus status;
  final String username;
  final String password;
  // final ServerState serverState;

  LoginState copyWith({
    // FormzStatus? status,
    String? username,
    String? password,
    // ServerState? serverState
  }) {
    return LoginState(
      // status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [
        // status,
        username, password
      ];
}
