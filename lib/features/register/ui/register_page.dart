// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/features/bottom_navigation/ui/bottom_nav_page.dart';
import 'package:news_app/features/login/ui/login_page.dart';
import 'package:news_app/features/login/ui/widgets/custom_btn.dart';
import 'package:news_app/features/login/ui/widgets/custom_text_field.dart';
import 'package:news_app/features/login/ui/widgets/password_text_field.dart';
import 'package:news_app/features/register/bloc/register_bloc.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final registerBloc = RegisterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocListener<RegisterBloc, RegisterState>(
          bloc: registerBloc,
          listenWhen: (previous, current) => current is RegisterActionState,
          listener: (context, state) {
            if (state is RegisterSuccessfulActionState) {
              Navigator.pushReplacement(
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
            } else if (state is RegisterErrorActionState) {
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
            } else if (state is RegisterInvalidInputTypeActionState) {
              /// If the user spams then just close the previous SnackBar & open the new one
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text("Please fill out all fields"),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is RegisterLoadingState) {
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
            } else if (state is RegisterNavigateToLoginPageActionState) {
              Navigator.pop(context);
              Navigator.popUntil(
                context,
                (route) => route == LoginPage(),
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            }
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 60,
                ),
                SvgPicture.asset(
                  "assets/register.svg",
                  height: 200,
                  width: 80,
                  fit: BoxFit.cover,
                ),
                const Text(
                  "Welcome!",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                TextField(
                  controller: _nameController,
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                    hintText: "Name",
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(
                      CupertinoIcons.person,
                      color: Colors.grey,
                    ),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                    text: "Register",
                    onTap: () {
                      registerBloc.add(RegisterOnTapBtnEvent(
                        email: _emailController,
                        password: _passwordController,
                        name: _nameController,
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
                      "Already have an account?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontFamily: "Poppins",
                        color: Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        registerBloc.add(RegisterNavigateToLoginPageEvent());
                      },
                      child: Text(
                        " Login",
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
      ),
    );
  }
}
