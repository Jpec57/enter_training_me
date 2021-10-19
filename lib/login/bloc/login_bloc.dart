import 'package:bloc/bloc.dart';
import 'package:enter_training_me/services/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(
      {required AuthenticationRepository authenticationRepository,
      required VoidCallback onLoginCallback})
      : _authenticationRepository = authenticationRepository,
        onLoginCallback = onLoginCallback,
        super(const LoginState());

  final AuthenticationRepository _authenticationRepository;
  final VoidCallback onLoginCallback;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginUsernameChanged) {
      yield _mapUsernameChangedToState(event, state);
    } else if (event is LoginPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    }
  }

  LoginState _mapUsernameChangedToState(
    LoginUsernameChanged event,
    LoginState state,
  ) {
    return state.copyWith(
      username: event.username,
    );
  }

  LoginState _mapPasswordChangedToState(
    LoginPasswordChanged event,
    LoginState state,
  ) {
    return state.copyWith(
      password: event.password,
    );
  }

  String? getUsernameError(LoginState state) {
    if (state.username.length <= 3) {
      return "Your username must have at least 4 characters.";
    }
    return null;
  }

  String? getPasswordError(LoginState state) {
    if (state.password.length <= 3) {
      return "Too short.";
    }
    return null;
  }
}
