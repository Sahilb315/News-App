// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_app/features/register/repo/register_repo.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterOnTapBtnEvent>(registerOnTapBtnEvent);
    on<RegisterNavigateToLoginPageEvent>(registerNavigateToLoginPageEvent);
  }

  FutureOr<void> registerOnTapBtnEvent(
      RegisterOnTapBtnEvent event, Emitter<RegisterState> emit) async {
    if (event.email.text.isEmpty ||
        event.password.text.isEmpty ||
        event.name.text.isEmpty) {
      emit(RegisterInvalidInputTypeActionState());
      return;
    }
    emit(RegisterLoadingState());
    final result = await RegisterRepo.registerUser(
      name: event.name.text,
      email: event.email.text,
      password: event.password.text,
    );
    if (result is RegisterSuccessfulActionState) {
      emit(RegisterSuccessfulActionState());
    } else if (result is RegisterErrorActionState) {
      emit(RegisterErrorActionState(errorMessage: result.errorMessage));
    }
  }

  FutureOr<void> registerNavigateToLoginPageEvent(
      RegisterNavigateToLoginPageEvent event, Emitter<RegisterState> emit) {
    emit(RegisterNavigateToLoginPageActionState());
  }
}
