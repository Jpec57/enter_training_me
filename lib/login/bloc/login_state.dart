part of 'login_bloc.dart';

enum SubmitStatus { unknown, validated, submitting, submitted, errorSubmission }

class LoginState extends Equatable {
  const LoginState({
    this.status = SubmitStatus.unknown,
    this.username = "",
    this.password = "",
  });

  final SubmitStatus status;
  final String username;
  final String password;

  LoginState copyWith({
    SubmitStatus? status,
    String? username,
    String? password,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [status, username, password];
}
