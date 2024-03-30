import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/features/register/bloc/register_bloc.dart';

class RegisterRepo {
  static Future<RegisterState> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      /// Register the user
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      /// Create User Document In Firestore
      await FirebaseFirestore.instance.collection('users').doc(email).set({
        'name': name,
        'email': email,
        'bookmarks': [],
      });
      return RegisterSuccessfulActionState();
    } catch (e) {
      log(e.toString());
      return RegisterErrorActionState(errorMessage: e.toString());
    }
  }
}
