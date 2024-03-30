part of 'register_bloc.dart';

@immutable
sealed class RegisterState {}

abstract class RegisterActionState extends RegisterState {}

final class RegisterInitial extends RegisterState {}

class RegisterLoadingState extends RegisterActionState {}

class RegisterSuccessfulActionState extends RegisterActionState {}

class RegisterErrorActionState extends RegisterActionState {
  final String errorMessage;

  RegisterErrorActionState({required this.errorMessage});
}

class RegisterInvalidInputTypeActionState extends RegisterActionState {}

class RegisterNavigateToLoginPageActionState extends RegisterActionState {}