import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn.instance;
  final clientId =
      '179049673161-pu3etga7krf3vd8dctf0g0ghp15j38un.apps.googleusercontent.com';
  final serverClientId =
      '179049673161-v1n7npj19qqvt7eanj09pa8p4tpfrajm.apps.googleusercontent.com';

  Future<User?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      return credential.user;
    } on FirebaseException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return credential.user;
    } on FirebaseException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }

    return null;
  }

  Stream<User?> checkUserSignInState() {
    final state = firebaseAuth.authStateChanges();
    return state;
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      unawaited(googleSignIn.initialize(
          clientId: clientId, serverClientId: serverClientId));

      final GoogleSignInAccount? googleUser = await googleSignIn.authenticate();

      if (googleUser == null) {
        // The user canceled the sign-in
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e);
      return null;
    }
  }

  signOutWithGoogle() {
    googleSignIn.signOut();
    firebaseAuth.signOut();
  }
}
