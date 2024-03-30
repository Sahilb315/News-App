part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

class RegisterOnTapBtnEvent extends RegisterEvent {
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController name;

  RegisterOnTapBtnEvent({
    required this.email,
    required this.password,
    required this.name,
  });
}

class RegisterNavigateToLoginPageEvent extends RegisterEvent {}