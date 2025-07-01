import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_movies_app/data/auth/firebase_auth_service.dart';

class AuthController {
  final FirebaseAuthService authService;
  AuthController(this.authService);

  Future<User?> signIn(String email, String password) async {
    final result =
        await authService.signInWithEmailAndPassword(email, password);

    return result;
  }

  Future<User?> register(String email, String password) async {
    final result =
        await authService.registerWithEmailAndPassword(email, password);

    return result;
  }

  Stream<User?> checkUserSignInState() {
    final state = authService.checkUserSignInState();
    return state;
  }

  Future<UserCredential?> signInWithGoogle() async {
    return authService.signInWithGoogle();
  }

  signOut() {
    authService.signInWithGoogle();
  }
}
