part of 'register_bloc.dart';

enum SubmitStatus { unknown, validated, submitting, submitted, errorSubmission }

class RegisterState extends Equatable {
  const RegisterState({
    this.status = SubmitStatus.unknown,
    this.username = "test@jpec.fr",
    this.email = "test@jpec.fr",
    this.password = "test",
    this.confirmPassword = "test",
  });

  final SubmitStatus status;
  final String email;
  final String username;
  final String password;
  final String confirmPassword;

  RegisterState copyWith({
    SubmitStatus? status,
    String? email,
    String? username,
    String? confirmPassword,
    String? password,
  }) {
    return RegisterState(
      status: status ?? this.status,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  @override
  List<Object> get props =>
      [status, username, password, confirmPassword, email];
}
