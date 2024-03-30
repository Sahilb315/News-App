part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginOnTapBtnEvent extends LoginEvent {
  final TextEditingController email;
  final TextEditingController password;

  LoginOnTapBtnEvent({
    required this.email,
    required this.password,
  });
}

class LoginNavigateToRegisterEvent extends LoginEvent {}
