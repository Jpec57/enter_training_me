import 'dart:async';


import 'package:bloc/bloc.dart';
import 'package:enter_training_me/authentication/interfaces/iauthentication_repository.dart';
import 'package:enter_training_me/authentication/interfaces/iauthentication_user.dart';
import 'package:enter_training_me/authentication/interfaces/iauthentication_user_repository.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required IAuthenticationRepositoryInterface authenticationRepository,
    required IAuthUserRepositoryInterface userRepository,
  })   : _authenticationRepository = authenticationRepository,
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
    print("event status ${event.status}");
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return const AuthenticationState.unauthenticated();
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUserWithToken();
        return user != null
            ? AuthenticationState.authenticated(user)
            : const AuthenticationState.unauthenticated();
      default:
        print("DEFAULT status");
        final user = await _tryGetUserWithToken();
        return user != null
            ? AuthenticationState.authenticated(user)
            : const AuthenticationState.unauthenticated();
    }
  }

  Future<IAuthUserInterface?> _tryGetUserWithToken() async {
    try {
      String? token = await _authenticationRepository.getUserToken();
      print("User token $token");
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