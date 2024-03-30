import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/bottom_navigation/ui/bottom_nav_page.dart';
import 'package:news_app/features/register/ui/register_page.dart';

class UserAuthSession extends StatelessWidget {
  const UserAuthSession({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const MyBottomNavigationPage(index: 0);
        } else {
          return RegisterPage();
        }
      },
    );
  }
}
