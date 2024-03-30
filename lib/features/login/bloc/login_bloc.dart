// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_app/features/login/repo/login_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginNavigateToRegisterEvent>(loginNavigateToRegisterEvent);
    on<LoginOnTapBtnEvent>(loginOnTapBtnEvent);
  }

  FutureOr<void> loginNavigateToRegisterEvent(
      LoginNavigateToRegisterEvent event, Emitter<LoginState> emit) {
    emit(LoginNavigateToRegisterPageActionState());
  }

  FutureOr<void> loginOnTapBtnEvent(
      LoginOnTapBtnEvent event, Emitter<LoginState> emit) async {
    if (event.email.text.isEmpty || event.password.text.isEmpty) {
      emit(LoginInvalidInputTypeActionState());
    } else {
      emit(LoginLoadingActionState());
      final result = await LoginRepo.loginUser(
        email: event.email.text,
        password: event.password.text,
      );
      if (result is LoginSuccessfulActionState) {
        emit(LoginSuccessfulActionState());
      } else if (result is LoginErrorActionState) {
        emit(LoginErrorActionState(errorMessage: result.errorMessage));
      }
    }
  }
}
