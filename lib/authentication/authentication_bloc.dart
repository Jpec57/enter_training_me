import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:enter_training_me/authentication/interfaces/iauthentication_repository.dart';
import 'package:enter_training_me/authentication/interfaces/iauthentication_user.dart';
import 'package:enter_training_me/authentication/interfaces/iauthentication_user_repository.dart';
import 'package:enter_training_me/authentication/models/auth_response.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required IAuthenticationRepositoryInterface authenticationRepository,
    required IAuthUserRepositoryInterface userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  final IAuthenticationRepositoryInterface _authenticationRepository;
  final IAuthUserRepositoryInterface _userRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthenticationStatusChangedToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      _authenticationRepository.logOut();
    } else if (event is AuthenticationAttemptRequested) {
      AuthResponse? authResponse = await _authenticationRepository
          .logInAndGetUser(password: event.password, email: event.email);
      if (authResponse != null) {
        yield AuthenticationState.authenticated(authResponse.user);
      }
    }
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  Future<AuthenticationState> _mapAuthenticationStatusChangedToState(
    AuthenticationStatusChanged event,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return const AuthenticationState.unauthenticated();
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUserWithToken();
        return user != null
            ? AuthenticationState.authenticated(user)
            : const AuthenticationState.unauthenticated();
      default:
        final user = await _tryGetUserWithToken();
        return user != null
            ? AuthenticationState.authenticated(user)
            : const AuthenticationState.unauthenticated();
    }
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
