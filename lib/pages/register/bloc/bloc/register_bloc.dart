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
        super(const RegisterState()) {
    on<RegisterUsernameChanged>(_mapUsernameChangedToState);
    on<RegisterConfirmPasswordChanged>(_mapConfirmPasswordChangedToState);
    on<RegisterPasswordChanged>(_mapPasswordChangedToState);
    on<RegisterEmailChanged>(_mapEmailChangedToState);
    on<RegisterSubmitted>(_onRegisterSubmittedEvent);
  }

  final UserRepository _userRepository;

  void _onRegisterSubmittedEvent(
      RegisterSubmitted event, Emitter<RegisterState> emit) async {
    print("RegisterSubmitted");
    emit(state.copyWith(status: SubmitStatus.submitting));
    try {
      IAuthUserInterface? user = await _userRepository.register(
        username: state.username,
        password: state.password,
        email: state.email,
      );
      emit(state.copyWith(status: SubmitStatus.submitted));

      if (user != null) {
        BlocProvider.of<AuthenticationBloc>(event.context).add(
            const AuthenticationStatusChanged(
                AuthenticationStatus.authenticated));
        get_lib.Get.offNamed(HomePage.routeName);
      }
    } on DioError catch (_) {
      emit(state.copyWith(status: SubmitStatus.errorSubmission));
    }
  }

  void _mapEmailChangedToState(
      RegisterEmailChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _mapConfirmPasswordChangedToState(
      RegisterConfirmPasswordChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(confirmPassword: event.confirmPassword));
  }

  void _mapPasswordChangedToState(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(
      password: event.password,
    ));
  }

  void _mapUsernameChangedToState(
      RegisterUsernameChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(
      username: event.username,
    ));
  }
}
