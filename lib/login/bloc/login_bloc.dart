import 'package:bloc/bloc.dart';
import 'package:enter_training_me/services/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginState());

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginUsernameChanged) {
      yield _mapUsernameChangedToState(event, state);
    } else if (event is LoginPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is LoginSubmitted) {
      yield* _mapLoginSubmittedToState(event, state);
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

  Stream<LoginState> _mapLoginSubmittedToState(
    LoginSubmitted event,
    LoginState state,
  ) async* {
    // if (state.status.isValidated) {
    // yield state.copyWith(status: submissionInProgress);
    try {
      bool isLoginSuccess = await _authenticationRepository.logIn(
        username: state.username,
        password: state.password,
      );
      if (isLoginSuccess) {
        // yield state.copyWith(status: submissionSuccess);
      } else {
        // yield state.copyWith(
        //     serverState: ServerState(
        //         code: 403, message: "You are not Jpec and never will be."),
        //     status: FormzStatus.submissionFailure);
      }
    } on Exception catch (_) {
      // yield state.copyWith(status: FormzStatus.submissionFailure);
    }
    // }
  }
}
