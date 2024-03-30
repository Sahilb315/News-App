part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

abstract class LoginActionState extends LoginState {}

final class LoginInitial extends LoginState {}

class LoginNavigateToRegisterPageActionState extends LoginActionState {}

class LoginSuccessfulActionState extends LoginActionState {}

class LoginErrorActionState extends LoginActionState {
  final String errorMessage;

  LoginErrorActionState({required this.errorMessage});
}

class LoginInvalidInputTypeActionState extends LoginActionState {}

class LoginLoadingActionState extends LoginActionState {}