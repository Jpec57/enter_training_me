import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:enter_training_me/authentication/interfaces/iauthentication_repository.dart';
import 'package:enter_training_me/authentication/interfaces/iauthentication_user.dart';
import 'package:enter_training_me/authentication/interfaces/iauthentication_user_repository.dart';
import 'package:enter_training_me/authentication/models/auth_response.dart';
import 'package:enter_training_me/storage_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final IAuthenticationRepositoryInterface _authenticationRepository;
  final IAuthUserRepositoryInterface _userRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  AuthenticationBloc({
    required IAuthenticationRepositoryInterface authenticationRepository,
    required IAuthUserRepositoryInterface userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );

    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<AuthenticationAttemptRequested>(_onAuthenticationAttemptRequested);
  }

  void _onAuthenticationAttemptRequested(AuthenticationAttemptRequested event,
      Emitter<AuthenticationState> emit) async {
    AuthResponse? authResponse = await _authenticationRepository
        .logInAndGetUser(password: event.password, email: event.email);
    if (authResponse != null) {
      FlutterSecureStorage storage = const FlutterSecureStorage();

      await storage.write(key: StorageConstants.userId, value: authResponse.user.id.toString());
      await storage.write(key: StorageConstants.userEmail, value: event.email);
      emit(AuthenticationState.authenticated(authResponse.user));
    }
  }

  void _onAuthenticationLogoutRequested(AuthenticationLogoutRequested event,
      Emitter<AuthenticationState> emit) async {
    _authenticationRepository.logOut();
    emit(const AuthenticationState.unauthenticated());
  }

  void _onAuthenticationStatusChanged(AuthenticationStatusChanged event,
      Emitter<AuthenticationState> emit) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        emit(const AuthenticationState.unauthenticated());
        break;
      case AuthenticationStatus.authenticated:
      default:
        final user = await _tryGetUserWithToken();
        emit(user != null
            ? AuthenticationState.authenticated(user)
            : const AuthenticationState.unauthenticated());

        break;
    }
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  Future<IAuthUserInterface?> _tryGetUserWithToken() async {
    try {
      String? token = await _authenticationRepository.getUserToken();
      if (token != null) {
        final user = await _userRepository.getUserWithToken(token);
        return user;
      }
      return null;
    } on Exception {
      return null;
    }
  }
}
