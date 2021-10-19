import 'package:bloc/bloc.dart';
import 'package:enter_training_me/authentication/authentication.dart';
import 'package:enter_training_me/services/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const RegisterState());

  final UserRepository _userRepository;

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterUsernameChanged) {
      yield _mapUsernameChangedToState(event, state);
    } else if (event is RegisterPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is RegisterSubmitted) {
      yield* _mapRegisterSubmittedToState(event, state);
    }
  }

  RegisterState _mapUsernameChangedToState(
    RegisterUsernameChanged event,
    RegisterState state,
  ) {
    return state.copyWith(
      username: event.username,
    );
  }

  RegisterState _mapPasswordChangedToState(
    RegisterPasswordChanged event,
    RegisterState state,
  ) {
    return state.copyWith(
      password: event.password,
    );
  }

  String? getUsernameError(RegisterState state) {
    if (state.username.length <= 3) {
      return "Your username must have at least 4 characters.";
    }
    return null;
  }

  String? getPasswordError(RegisterState state) {
    if (state.password.length <= 3) {
      return "Too short.";
    }
    return null;
  }

  Stream<RegisterState> _mapRegisterSubmittedToState(
    RegisterSubmitted event,
    RegisterState state,
  ) async* {
    // if (state.status == SubmitStatus.validated) {
    yield state.copyWith(status: SubmitStatus.submitting);
    try {
      IAuthUserInterface? user = await _userRepository.register(
        username: state.username,
        password: state.password,
        email: state.email,
      );
      if (user != null) {
        yield state.copyWith(status: SubmitStatus.submitted);
      } else {
        yield state.copyWith(status: SubmitStatus.submitted);
      }
    } on Exception catch (_) {
      yield state.copyWith(status: SubmitStatus.errorSubmission);
    }
  }
  // }
}
