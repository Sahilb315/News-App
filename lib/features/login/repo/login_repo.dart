import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/features/login/bloc/login_bloc.dart';

class LoginRepo {
  static Future<LoginState> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return LoginSuccessfulActionState();
    } catch (e) {
      return LoginErrorActionState(errorMessage: e.toString());
    }
  }
}
