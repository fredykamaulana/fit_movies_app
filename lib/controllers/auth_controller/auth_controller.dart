import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_movies_app/data/auth/firebase_auth_service.dart';

class AuthController {
  final FirebaseAuthService authService;
  AuthController(this.authService);

  Future<UserCredential> signIn(String email, String password) async {
    return await authService.signInWithEmailAndPassword(email, password);
  }

  Future<UserCredential> register(String email, String password) async {
    return await authService.registerWithEmailAndPassword(email, password);
  }

  Stream<User?> checkUserSignInState() {
    final state = authService.checkUserSignInState();
    return state;
  }

  Future<UserCredential?> signInWithGoogle() async {
    return authService.signInWithGoogle();
  }

  signOut() {
    authService.signOut();
  }
}
