import 'package:bloc/bloc.dart';
import 'package:enter_training_me/services/repositories/authentication_repository.dart';
import 'package:enter_training_me/storage_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required VoidCallback onLoginCallback})
      : onLoginCallback = onLoginCallback,
        super(const LoginState()) {
    on<LoginUsernameChanged>(_mapUsernameChangedToState);
    on<InitLoginEvent>(_onInitLoginEvent);
    on<LoginPasswordChanged>(_onLoginPasswordChangedEvent);
  }

  final VoidCallback onLoginCallback;

  void _mapUsernameChangedToState(
      LoginUsernameChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      username: event.username,
    ));
  }

  void _onInitLoginEvent(InitLoginEvent event, Emitter<LoginState> emit) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? username = await storage.read(key: StorageConstants.userEmail);
    emit(state.copyWith(
      username: username,
    ));
  }

  void _onLoginPasswordChangedEvent(
      LoginPasswordChanged event, Emitter<LoginState> emit) async {
    emit(state.copyWith(
      password: event.password,
    ));
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
