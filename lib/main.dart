import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:news_app/features/bottom_navigation/ui/bottom_nav_page.dart';
import 'package:news_app/features/home/model/news_model.dart';
import 'package:news_app/features/login/ui/login_page.dart';
import 'package:news_app/features/register/ui/register_page.dart';
import 'firebase_options.dart';

List<NewsModel> favourites = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegisterPage(),
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: Colors.blue.shade300,
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
