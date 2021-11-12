import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:enter_training_me/authentication/authentication.dart';
import 'package:enter_training_me/pages/home/home_page.dart';
import 'package:enter_training_me/services/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as get_lib;
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
    } else if (event is RegisterEmailChanged) {
      yield _mapEmailChangedToState(event, state);
    } else if (event is RegisterPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is RegisterConfirmPasswordChanged) {
      yield _mapConfirmPasswordChangedToState(event, state);
    } else if (event is RegisterSubmitted) {
      print("RegisterSubmitted");
      yield state.copyWith(status: SubmitStatus.submitting);
      try {
        IAuthUserInterface? user = await _userRepository.register(
          username: state.username,
          password: state.password,
          email: state.email,
        );
        yield state.copyWith(status: SubmitStatus.submitted);

        if (user != null) {
          BlocProvider.of<AuthenticationBloc>(event.context).add(
              const AuthenticationStatusChanged(
                  AuthenticationStatus.authenticated));
          get_lib.Get.offNamed(HomePage.routeName);
        }
      } on DioError catch (_) {
        yield state.copyWith(status: SubmitStatus.errorSubmission);
      }
    }
  }

  RegisterState _mapEmailChangedToState(
      RegisterEmailChanged event, RegisterState state) {
    return state.copyWith(email: event.email);
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

  RegisterState _mapConfirmPasswordChangedToState(
      RegisterConfirmPasswordChanged event, RegisterState state) {
    return state.copyWith(confirmPassword: event.confirmPassword);
  }
}
