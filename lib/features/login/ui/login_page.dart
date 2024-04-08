// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/bottom_navigation/ui/bottom_nav_page.dart';
import 'package:news_app/features/login/bloc/login_bloc.dart';
import 'package:news_app/features/login/ui/widgets/custom_btn.dart';
import 'package:news_app/features/login/ui/widgets/custom_text_field.dart';
import 'package:news_app/features/login/ui/widgets/password_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/features/register/ui/register_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final loginBloc = LoginBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<LoginBloc, LoginState>(
        bloc: loginBloc,
        listener: (context, state) {
          if (state is LoginNavigateToRegisterPageActionState) {
            Navigator.pop(context);
            Navigator.popUntil(
              context,
              (route) => route == RegisterPage(),
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RegisterPage(),
              ),
            );
          } else if (state is LoginInvalidInputTypeActionState) {
            /// If the user spams then just close the previous SnackBar & open the new one
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(seconds: 1),
                content: Text("Please fill out all fields"),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is LoginErrorActionState) {
            /// To pop the CircularProgressIndicator
            Navigator.pop(context);

            /// If the user spams then just close the previous SnackBar & open the new one
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(seconds: 1),
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is LoginLoadingActionState) {
            showDialog(
              context: context,
              builder: (context) => const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                  strokeWidth: 2.5,
                  strokeCap: StrokeCap.round,
                ),
              ),
            );
          } else if (state is LoginSuccessfulActionState) {
            Navigator.popUntil(
              context,
              (route) => route == LoginPage(),
            );
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const MyBottomNavigationPage(index: 0),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var begin = const Offset(0, 1);
                  var end = Offset.zero;
                  var curve = Curves.ease;
                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/login.svg",
                height: 200,
                width: 80,
                fit: BoxFit.cover,
              ),
              const Text(
                "Welcome Back!",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              CustomTextField(
                controller: _emailController,
                text: "Email",
                icon: CupertinoIcons.mail,
              ),
              const SizedBox(
                height: 10,
              ),
              PasswordTextField(
                controller: _passwordController,
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: SignInButton(
                  text: "Sign Up",
                  onTap: () {
                    loginBloc.add(LoginOnTapBtnEvent(
                      email: _emailController,
                      password: _passwordController,
                    ));
                  },
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      fontFamily: "Poppins",
                      color: Colors.grey,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      loginBloc.add(LoginNavigateToRegisterEvent());
                    },
                    child: Text(
                      " Register",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontFamily: "Poppins",
                        color: Colors.blue.shade400,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
